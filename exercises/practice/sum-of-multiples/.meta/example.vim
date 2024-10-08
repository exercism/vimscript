function! Sum(factors, limit) abort
  let l:multiples = []
  for l:i in range(1, a:limit - 1)
    for l:factor in a:factors
      if l:i % l:factor == 0 && l:factor != 0
        call add(l:multiples, l:i)
        break
      endif
    endfor
  endfor

  let l:sum = 0
  for l:multiple in l:multiples
    let l:sum += l:multiple
  endfor

  return l:sum
endfunction
