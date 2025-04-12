function! Annotate(minefield) abort
  if empty(a:minefield)
    return []
  endif

  let l:rows = len(a:minefield)
  let l:cols = len(a:minefield[0])

  let l:result = []
  for l:row in range(l:rows)
    let l:marked = []
    for l:col in range(l:cols)
      if a:minefield[l:row][l:col] == '*'
        call add(l:marked, '*')
      else
        let l:count = 0
        let l:minRow = max([0, l:row - 1])
        let l:maxRow = min([l:rows - 1, l:row + 1])
        let l:minCol = max([0, l:col - 1])
        let l:maxCol = min([l:cols - 1, l:col + 1])
        for l:newRow in range(l:minRow, l:maxRow)
          for l:newCol in range(l:minCol, l:maxCol)
            if l:newRow == l:row && l:newCol == l:col
              continue
            endif
            if a:minefield[l:newRow][l:newCol] == '*'
                let l:count += 1
            endif
          endfor
        endfor
        if l:count == 0
          call add(l:marked, ' ')
        else
          call add(l:marked, l:count)
        endif
      endif
    endfor
    call add(result, join(l:marked, ''))
  endfor
  return result
endfunction
