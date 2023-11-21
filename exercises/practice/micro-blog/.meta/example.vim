function! Truncate(string) abort
  let l:length = strchars(a:string)
  let l:limit = min([l:length, 5])
    
  return strcharpart(a:string, 0, l:limit - 1)
endfunction
