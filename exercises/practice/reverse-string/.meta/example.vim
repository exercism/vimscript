function! Reverse(text) abort
  return join(reverse(split(a:text, '.\zs')), '')
endfunction
