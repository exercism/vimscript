function! Raindrops(number) abort
  let s = ''

  if a:number % 3 == 0 | let s .= 'Pling' | endif
  if a:number % 5 == 0 | let s .= 'Plang' | endif
  if a:number % 7 == 0 | let s .= 'Plong' | endif

  return empty(s) ? string(a:number) : s
endfunction
