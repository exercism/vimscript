"
" This Vim script fetches the canonical test data for an
" exercise from GitHub and converts it to a Vader file.
"
"   :source %
"   :Generate word-count
"

function! s:data_url(slug) abort
  return printf('https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/%s/canonical-data.json', a:slug)
endfunction

function! s:generate_header(data)
  call append(0, [
        \ '"',
        \ '" Version: '. a:data.version,
        \ '"',
        \ '',
        \ 'Before:',
        \ '  unlet! input expected',
        \ ])
endfunction

function! s:generate_variable(name, value)
  let value = a:value
  if type(a:value) == type('')
    let value = '"'. value .'"'
  endif
  return printf('  let %s = %s', a:name, value)
endfunction

function! s:generate_assert(property) abort
  let funcname = toupper(a:property[0]) . a:property[1:]
  return printf('  AssertEqual expected, %s(input)', funcname)
endfunction

function! s:get_input_value(test) abort
  let t = copy(a:test)
  if has_key(t, 'comments')    | call remove(t, 'comments')    | endif
  if has_key(t, 'description') | call remove(t, 'description') | endif
  if has_key(t, 'expected')    | call remove(t, 'expected')    | endif
  if has_key(t, 'property')    | call remove(t, 'property')    | endif
  return items(t)[0][1]
endfunction

function! s:generate_tests(tests) abort
  for test in a:tests
    if has_key(test, 'cases')
      call s:generate_tests(test.cases)
    else
      call append(line('$'), printf('Execute (%s):', test.description))
      call append(line('$'), s:generate_variable('input', s:get_input_value(test)))
      call append(line('$'), s:generate_variable('expected', test.expected))
      call append(line('$'), [s:generate_assert(test.property), ''])
    endif
  endfor
endfunction

function! s:replace_types() abort
  silent %substitute/v:true/1/eg
  silent %substitute/v:false/0/eg
  silent %substitute/v:null/''/eg
endfunction

function! s:generate(slug) abort
  execute 'silent edit' s:data_url(a:slug)
  if getline(1) ==# '404: Not Found'
    silent bwipeout!
    redraw!
    echomsg '404: Not Found'
    return
  elseif line2byte('$') == -1
    silent bwipeout!
    echomsg 'Got empty buffer. Have you disabled the netrw plugin?'
    return
  endif
  %yank x
  try
    let data = json_decode(substitute(@x, '\\', '\\\\', 'g'))
  catch
    redraw
    echohl ErrorMsg
    echomsg 'JSON decoding failed.'
    echomsg 'Trying again without backslash escaping.'
    echomsg 'Check escaping in the generated tests!'
    echohl None
    call input('[press any key]')
    let data = json_decode(@x)
  endtry
  bwipeout!
  enew!
  setfiletype vader
  call s:generate_header(data)
  call s:generate_tests(data.cases)
  call s:replace_types()
  set nomodified
  redraw!
endfunction

command! -nargs=1 Generate call s:generate(<f-args>)
