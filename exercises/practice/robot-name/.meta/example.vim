let s:census = {}

function! Create() abort
  let l:name = s:AssignName()
  return {
    \ 'name': l:name,
    \ 'Reset': function('s:Reset')
    \ }
endfunction

function! s:Reset() dict
  let self.name = s:AssignName()
endfunction

function! s:AssignName() abort
  if len(s:census) == 26 * 26 * 10 * 10 * 10
    throw 'All possible robot names have been used'
  endif
  
  let l:name = s:GenerateName()
  while has_key(s:census, l:name)
    let l:name = s:GenerateName()
  endwhile

  let s:census[l:name] = 1
  return l:name
endfunction

function! s:GenerateName() abort
  let l:letters = map(repeat(['*'], 2), 's:GenerateLetter()')
  let l:numbers = map(repeat(['*'], 3), 's:GenerateNumber()')
  return join(l:letters + l:numbers, '')
endfunction

let s:alphabet = range(65, 90)

function! s:GenerateLetter() abort
  return nr2char(s:alphabet[rand() % len(s:alphabet)])
endfunction

function! s:GenerateNumber() abort
  return rand() % 10
endfunction
