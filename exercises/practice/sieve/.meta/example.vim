function! Primes(limit) abort
  let l:results = []
  let l:numbers = range(2, a:limit)
  while len(l:numbers) > 0
    let l:current = remove(l:numbers, 0)
    call add(l:results, l:current)
    let l:numbers = Filter(l:numbers, {x -> x % current != 0})
  endwhile

  return l:results
endfunction

function! Filter(list, F) abort
let l:results = []
for l:item in a:list
  if a:F(l:item) == 1
    call add(l:results, l:item)
  endif
endfor

return l:results
endfunction
