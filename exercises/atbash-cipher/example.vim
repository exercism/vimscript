function! AtbashDecode(cipher) abort
  return s:algorithm(s:normalize(a:cipher))
endfunction

function! AtbashEncode(plaintext) abort
  return s:chunk(AtbashDecode(a:plaintext))
endfunction

function! s:normalize(text) abort
  return substitute(tolower(a:text), '[^a-z0-9]', '', 'g')
endfunction

function! s:algorithm(text) abort
  let alphabet = 'abcdefghijklmnopqrstuvwxyz'
  let reversed = 'zyxwvutsrqponmlkjihgfedcba'
  return tr(a:text, alphabet, reversed)
endfunction

function! s:chunk(text) abort
  return join(split(a:text, '.\{5}\zs'))
endfunction
