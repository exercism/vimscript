function! IsArmstrongNumber(number) abort
  let l:sum = 0
  let l:digits = split(string(a:number), '\zs')
  for l:digit in l:digits
    let l:digit = str2nr(l:digit)
    let l:sum += float2nr(pow(l:digit, len(l:digits)))
  endfor

  return l:sum == a:number
endfunction
