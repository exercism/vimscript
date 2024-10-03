function! IsValid(isbn) abort
  let l:digits = substitute(a:isbn, '-', '', 'g')
  if len(l:digits) != 10
    return 0
  endif

  let l:sum = 0
  for l:i in range(len(l:digits))
    let l:digit = l:digits[l:i]
    if l:digit == 'X'
      if l:i != len(l:digits) - 1
        return 0
      endif
      let l:digit = 10
    endif
    if l:digit !~ '\d'
      return 0
    endif
    let l:sum += l:digit * (10 - i)
  endfor

  return l:sum % 11 == 0
endfunction
