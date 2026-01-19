"
" This Vim script fetches the canonical test data for an
" exercise from GitHub and converts it to a Vader file.
" It also provides a bulk command to convert the canonical
" test data for all implemented practice exercises.
"
"   :source %
"   :Generate word-count
"   :GenerateAll
"

if get(g:, 'loaded_netrwPlugin') != 0
  echoerr 'This generator script needs the netrw plugin to be loaded.'
  finish
elseif !exists('*json_decode')
  echoerr 'The function json_decode() is not available. This generator script needs a newer Vim version.'
  finish
endif

" Capture script location at load time for GenerateAll
let s:script_dir = expand('<sfile>:p:h')
let s:root_dir = fnamemodify(s:script_dir, ':h')

function! s:data_url(slug) abort
  return printf('https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/%s/canonical-data.json', a:slug)
endfunction

function! s:get_practice_exercises() abort
  let slugs = glob(s:get_practice_dir() . '*', 0, 1)
  return sort(map(slugs, 'fnamemodify(v:val, ":t")'))
endfunction

function! s:get_exercise_dir(slug) abort
  return s:get_practice_dir() . a:slug
endfunction

function! s:get_practice_dir() abort
  return s:root_dir . '/exercises/practice/'
endfunction

function! s:get_test_path(slug) abort
  return s:get_exercise_dir(a:slug) . '/' . s:exercise_to_vader(a:slug)
endfunction

function! s:exercise_to_vader(slug) abort
  return substitute(a:slug, '-', '_', 'g') . '.vader'
endfunction

function! s:get_test_toml(slug) abort
  return s:get_exercise_dir(a:slug) . '/.meta/tests.toml'
endfunction

function! s:parse_tests_toml(toml_path) abort
  let config = {}
  let current_uuid = ''
  for line in readfile(a:toml_path)
    let uuid_match = matchstr(line, '^\[\zs.*\ze\]$')
    if !empty(uuid_match)
      let current_uuid = uuid_match
      let config[current_uuid] = {}
      continue
    endif
    
    if !empty(current_uuid)
      let kv_match = matchlist(line, '^\(\w\+\)\s*=\s*\(.*\)$')
      if !empty(kv_match)
        let k = kv_match[1]
        let v = kv_match[2]
        let v = trim(v)

        if v ==# 'false'
          let config[current_uuid][k] = v:false
        elseif v ==# 'true'
          let config[current_uuid][k] = v:true
        else
          let config[current_uuid][k] = substitute(v, '^"\|"$', '', 'g')
        endif
      endif
    endif
  endfor
  
  return config
endfunction

function! s:get_excluded_uuids(test_config) abort
  let excluded = []
  for [uuid, props] in items(a:test_config)
    if has_key(props, 'include') && props.include ==# v:false
      call add(excluded, uuid)
    endif
    if has_key(props, 'reimplements')
      call add(excluded, props.reimplements)
    endif
  endfor
  return excluded
endfunction

function! s:filter_test_cases(cases, excluded_uuids) abort
  let filtered = []
  for test in a:cases
    if has_key(test, 'uuid') && index(a:excluded_uuids, test.uuid) != -1
      continue
    endif
    let new_test = copy(test)
    if has_key(test, 'cases')
      let new_test.cases = s:filter_test_cases(test.cases, a:excluded_uuids)
      if empty(new_test.cases)
        continue
      endif
    endif
    call add(filtered, new_test)
  endfor
  return filtered
endfunction

function! s:generate_variable(name, value)
  call append(line('$'), printf('  let g:%s = %s', a:name, string(a:value)))
endfunction

function! s:generate_assert(test, arguments) abort
  let funcname = toupper(a:test.property[0]) . a:test.property[1:]

  if type(a:test.expected) ==# type({}) && has_key(a:test.expected, 'error')
    call s:generate_variable('expected', a:test.expected.error)
    call append(line('$'),
          \ printf('  AssertThrows call %s(%s)', funcname, join(a:arguments, ', ')))
    call append(line('$'), '  AssertEqual g:expected, g:vader_exception')
  else
    call s:generate_variable('expected', a:test.expected)
    call append(line('$'),
          \ printf('  AssertEqual g:expected, %s(%s)', funcname, join(a:arguments, ', ')))
  endif

  call append(line('$'), '')
endfunction

function! s:generate_tests(tests, ...) abort
  let is_top_level = a:0 ==# 0 ? 1 : 0
  for test in a:tests
    if has_key(test, 'cases')
      call s:generate_tests(test.cases, 0)
    else
      let arguments = []
      if line('$') > 1 && getline(line('$')) != ''
        call append(line('$'), '')
      endif
      call append(line('$'), printf('Execute (%s):', test.description))
      for [arg, val] in sort(items(test.input))
        call s:generate_variable(arg, val)
        let arguments += ['g:'.arg]
      endfor
      call s:generate_assert(test, arguments)
    endif
  endfor

  if is_top_level && empty(getline(line('$')))
    silent $delete _
  endif
endfunction

function! s:replace_types() abort
  silent %substitute/['"]v:true['"]/1/eg
  silent %substitute/['"]v:false['"]/0/eg
  silent %substitute/['"]v:null['"]/v:null/eg
endfunction

function! s:generate(slug, ...) abort
  let output_path = a:0 > 0 ? a:1 : ''
  
  execute 'silent edit' s:data_url(a:slug)
  if getline(1) ==# '404: Not Found'
    silent bwipeout!
    if !empty(output_path)
      throw '404: Not Found'
    endif
    redraw!
    echohl WarningMsg
    echomsg 'Skipped: No canonical data available for ' . a:slug
    echohl None
    return
  elseif line2byte('$') ==# -1
    silent bwipeout!
    if !empty(output_path)
      throw 'Got empty buffer. Have you disabled the netrw plugin?'
    endif
    echohl WarningMsg
    echomsg 'Skipped: Got empty buffer for ' . a:slug . '. Have you disabled the netrw plugin?'
    echohl None
    return
  endif
  silent %yank x
  
  let json_text = substitute(@x, '\%x00', '', 'g')
  
  try
    let data = json_decode(substitute(json_text, '\\\\', '\\\\\\\\', 'g'))
  catch
    if !empty(output_path)
      silent bwipeout!
      throw 'JSON decoding failed: ' . v:exception
    endif
    redraw
    echohl ErrorMsg
    echomsg 'JSON decoding failed.'
    echomsg 'Trying again without backslash escaping.'
    echomsg 'Check escaping in the generated tests!'
    echohl None
    call input('[press any key]')
    let data = json_decode(json_text)
  endtry
  bwipeout!
  
  let tests_toml = s:get_test_toml(a:slug)
  if filereadable(tests_toml)
    let test_config = s:parse_tests_toml(tests_toml)
    let excluded_uuids = s:get_excluded_uuids(test_config)
    if !empty(excluded_uuids)
      let data.cases = s:filter_test_cases(data.cases, excluded_uuids)
    endif
  endif
  
  enew!
  setfiletype vader
  call s:generate_tests(data.cases)
  call s:replace_types()
  
  if getline(1) ==# ''
    1delete _
  endif
  
  if !empty(output_path)
    execute 'silent write! ' . fnameescape(output_path)
    silent bwipeout!
  else
    set nomodified
    redraw!
  endif
endfunction

function! s:generate_all() abort
  let exercises = s:get_practice_exercises()
  let total = len(exercises)
  let generated = 0
  let skipped = []
  let failed = []
  
  redraw!
  echo 'Regenerating tests for ' . total . ' exercises...'
  
  for [idx, slug] in items(exercises)
    let output_path = s:get_test_path(slug)
    redraw!
    echo printf('[%d/%d] Generating %s...', idx + 1, total, slug)
    
    try
      call s:generate(slug, output_path)
      let generated += 1
    catch
      if v:exception =~# '404' || v:exception =~# 'empty buffer'
        call add(skipped, slug)
      else
        call add(failed, {'slug': slug, 'error': v:exception})
      endif
    endtry
  endfor
  
  redraw!
  echohl MoreMsg
  echomsg printf('Successfully generated %d/%d tests', generated, total)
  echohl None
  
  if !empty(skipped)
    echohl WarningMsg
    echomsg printf('Skipped %d exercises (no canonical data available):', len(skipped))
    echohl None
    for slug in skipped
      echomsg '  - ' . slug
    endfor
  endif
  
  if !empty(failed)
    echohl ErrorMsg
    echomsg printf('Failed to generate %d tests:', len(failed))
    echohl None
    for item in failed
      echomsg '  - ' . item.slug . ': ' . item.error
    endfor
  endif
endfunction

command! -nargs=1 Generate call s:generate(<f-args>)
command! GenerateAll call s:generate_all()
