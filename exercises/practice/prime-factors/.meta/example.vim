function! Factors(value) abort
  let l:results = []
  let l:divisor = 2
  let l:working = a:value
  while l:working > 1
    while l:working % l:divisor == 0
      call add(l:results, l:divisor)
      let l:working /= l:divisor
    endwhile
    let l:divisor += 1
  endwhile

  return l:results
endfunction
