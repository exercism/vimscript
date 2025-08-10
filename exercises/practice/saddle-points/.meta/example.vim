function! SaddlePoints(matrix) abort
  if empty(a:matrix)
    return []
  endif

  let l:row_count = len(a:matrix)
  let l:col_count = len(a:matrix[0])
  let l:highest_in_a_row = map(copy(a:matrix), 'max(v:val)')
  let l:lowest_in_a_column = []
  for l:i in range(l:col_count)
      let l:values = []
      for l:j in range(l:row_count)
          call add(l:values, a:matrix[l:j][l:i])
      endfor
      call add(l:lowest_in_a_column, min(l:values))
  endfor

  let l:saddle_points = []
  
  for l:i in range(l:row_count)
      for l:j in range(l:col_count)
          let l:current = a:matrix[l:i][l:j]
          if l:current == l:highest_in_a_row[l:i] &&
           \ l:current == l:lowest_in_a_column[l:j]
              call add(l:saddle_points, {'row': l:i + 1, 'column': l:j + 1})
          endif
      endfor
  endfor

  return l:saddle_points
endfunction
