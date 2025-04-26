function! DegreeOfSeparation(familyTree, personA, personB) abort
  if a:personA ==# a:personB
    return 0 
  endif

  let l:neighbors = {}
  for [l:parent, l:children] in items(a:familyTree)
    let l:neighbors[l:parent] = get(l:neighbors, l:parent, [])
    for l:child in l:children
      let l:neighbors[l:child] = get(l:neighbors, l:child, [])
      call add(l:neighbors[l:parent], l:child)
      call add(l:neighbors[l:child], l:parent)
    endfor

    " Add links only between siblings
    if len(l:children) > 1
      for l:child1 in l:children
        for l:child2 in l:children
          if l:child1 != l:child2 && index(l:neighbors[l:child1], l:child2) == -1
            call add(l:neighbors[l:child1], l:child2)
          endif
        endfor
      endfor
    endif
  endfor

  if !has_key(l:neighbors, a:personA) || !has_key(l:neighbors, a:personB)
   return -1
  endif

  let l:queue = [[a:personA, 0]]

  let l:visited = {}
  let l:visited[a:personA] = 1
   
  while !empty(l:queue)
    let [l:current, l:degree] = remove(l:queue, 0)
  
    if l:current ==# a:personB
      return l:degree
    endif

    let l:unvisited = filter(l:neighbors[l:current], '!has_key(visited, v:val)')
    for l:neighbor in l:unvisited
      call add(l:queue, [l:neighbor, l:degree + 1])
      let l:visited[l:neighbor] = 1
    endfor
  endwhile

  return -1
endfunction
