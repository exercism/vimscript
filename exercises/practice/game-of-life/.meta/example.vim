function! Tick(matrix) abort
  if empty(a:matrix)
    return []
  endif

  let l:rows = len(a:matrix)
  let l:cols = len(a:matrix[0])
  let l:new_matrix = deepcopy(a:matrix)

  for l:row in range(l:rows)
    for l:col in range(l:cols)
      let l:live_neighbors = 0
      for l:dRow in [-1, 0, 1]
        for l:dCol in [-1, 0, 1]
          if l:dRow == 0 && l:dCol == 0
            continue " Skip current cell
          endif

          let l:nRow = l:row + l:dRow
          let l:nCol = l:col + l:dCol

          if l:nRow >= 0 && l:nRow < l:rows && l:nCol >= 0 && l:nCol < l:cols
            let l:live_neighbors += a:matrix[l:nRow][l:nCol]
          endif
        endfor
      endfor

      if a:matrix[l:row][l:col] == 1 && l:live_neighbors < 2 || l:live_neighbors > 3
        let l:new_matrix[l:row][l:col] = 0
      elseif a:matrix[l:row][l:col] == 0 && l:live_neighbors == 3
        let l:new_matrix[l:row][l:col] = 1
      endif
    endfor
  endfor

  return l:new_matrix
endfunction
