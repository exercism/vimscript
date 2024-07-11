function! Rows(count) abort
  let l:result = []
  for l:i in range(a:count)
    let l:row = []
    for l:j in range(l:i + 1)
      if l:j == 0 || l:j == l:i
        call add(l:row, 1)
      else
        call add(l:row, l:result[l:i - 1][l:j - 1] + l:result[l:i - 1][l:j])
      endif
    endfor
    call add(l:result, l:row)
  endfor
  return l:result
endfunction
