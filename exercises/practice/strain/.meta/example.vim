function! Keep(list, predicate) abort
  let l:results = []

  for l:elem in a:list
    if a:predicate(l:elem)
      let l:results = add(l:results, l:elem)
    endif
  endfor

  return l:results
endfunction

function! Discard(list, predicate) abort
  return Keep(a:list, {x -> !a:predicate(x)})
endfunction
