function! Append(list1, list2) abort
  if len(a:list1) == 0
    return a:list2
  endif

  return [ a:list1[0] ] + Append(a:list1[1:], a:list2)
endfunction

function! Concat(lists) abort
  return Foldl(a:lists, funcref('Append'), [])
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

function! Length(list) abort
  let l:F = {acc, _ -> acc + 1}

  return Foldl(a:list, l:F, 0)
endfunction

function! Map(list, F) abort
  let l:results = []
  for l:item in a:list
    call add(l:results, a:F(l:item))
  endfor

  return l:results
endfunction

function! Foldl(list, F, initial) abort
  let l:length = len(a:list)
  if l:length == 0
    return a:initial
  endif

  let l:result = a:initial

  for l:i in range(l:length)
    let l:result = a:F(l:result, a:list[l:i])
  endfor

  return l:result
endfunction

function! Foldr(list, F, initial) abort
  let l:length = len(a:list)
  if l:length == 0
    return a:initial
  endif

  let l:result = a:initial

  for l:i in range(l:length - 1, 0, -1)
    let l:result = a:F(a:list[l:i], l:result)
  endfor

  return l:result
endfunction

function! ReversalOf(list) abort
  let l:results = []
  for l:i in range(len(a:list) - 1, 0, -1)
    call add(l:results, a:list[l:i])
  endfor

  return l:results
endfunction
