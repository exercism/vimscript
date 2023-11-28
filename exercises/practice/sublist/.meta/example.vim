function! Sublist(list1, list2) abort
  if a:list1 == a:list2
    return 'equal'
  elseif s:IsSublist(a:list2, a:list1)
      return 'sublist'
  elseif s:IsSublist(a:list1, a:list2)
    return 'superlist'
  else
    return 'unequal'
  endif
endfunction

function! s:IsSublist(list1, list2) abort
  let l:len1 = len(a:list1)
  let l:len2 = len(a:list2)
  if l:len2 == 0
    return 1
  elseif l:len2 > l:len1 
    return 0
  endif

  let l:offset = s:FindRelativeStart(a:list1, a:list2)
  for l:i in range(l:len2)
    if a:list1[l:i + l:offset] != a:list2[l:i]
      return 0
    endif
  endfor

  return 1
endfunction

function! s:FindRelativeStart(list1, list2) abort
  let l:len1 = len(a:list1)
  let l:len2 = len(a:list2)
  let l:stop = l:len1 - l:len2 + 1
  for l:i in range(l:stop)
    let l:sublist = a:list1[l:i : l:i + l:len2 - 1]

    if l:sublist == a:list2
      return l:i
    endif
  endfor


  return -1
endfunction
