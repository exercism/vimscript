function! Transpose(lines) abort
  if a:lines ==# ''
    return ''
  endif

  let l:substituted = []
  let l:max_row_length = 0
  for l:row in reverse(split(a:lines, "\n"))
    let l:row = substitute(l:row, ' ', '*', 'g')
    if len(l:row) > l:max_row_length
      let l:max_row_length = len(l:row)
    else
      let l:row .= repeat(' ', l:max_row_length - len(l:row))
    endif
    call add(l:substituted, l:row)
  endfor

  let l:padded = reverse(l:substituted)

  let l:zipped = []
  let l:count = len(l:padded[0])
  for l:i in range(l:count)
    let l:zip = ''
    for l:row in l:padded
      let l:zip .= l:row[i]
    endfor
    call add(l:zipped, l:zip)
  endfor

  let l:results = []
  for l:row in l:zipped
    let l:row = trim(l:row, '', 2)
    let l:row = substitute(l:row, '*', ' ', 'g')
    call add(l:results, l:row)
  endfor

  return join(l:results, "\n")
endfunction
