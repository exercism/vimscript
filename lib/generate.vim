"
" This Vim script fetches the canonical test data for an
" exercise from GitHub and converts it to a Vader file.
"
"   :source %
"   :Generate word-count
"

if get(g:, 'loaded_netrwPlugin') != 0
  echoerr 'This generator script needs the netrw plugin to be loaded.'
  finish
elseif !exists('*json_decode')
  echoerr 'The function json_decode() is not available. This generator script needs a newer Vim version.'
  finish
endif

function! s:data_url(slug) abort
  return printf('https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/%s/canonical-data.json', a:slug)
endfunction

function! s:generate_header(data)
  call append(0, [
        \ '"',
        \ '" Version: '. a:data.version,
        \ '"',
        \ ])
endfunction

function! s:generate_variable(name, value)
  let value = a:value
  if type(a:value) == type('')
    let value = '"'. value .'"'
  endif
  call append(line('$'), printf('  let g:%s = %s', a:name, value))
endfunction

function! s:generate_assert(test, arguments) abort
  let funcname = toupper(a:test.property[0]) . a:test.property[1:]

  if type(a:test.expected) == type({}) && has_key(a:test.expected, 'error')
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

function! s:generate_tests(tests) abort
  for test in a:tests
    if has_key(test, 'cases')
      call s:generate_tests(test.cases)
    else
      let arguments = []
      call append(line('$'), printf('Execute (%s):', test.description))
      for [arg, val] in sort(items(test.input))
        call s:generate_variable(arg, val)
        let arguments += ['g:'.arg]
      endfor
      call s:generate_assert(test, arguments)
    endif
  endfor

  if empty(getline(line('$')))
    silent $delete _
  endif
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
