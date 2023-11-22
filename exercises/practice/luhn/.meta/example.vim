function! IsValid(value) abort
  let l:value = substitute(a:value, ' ', '', 'g')
  let l:length = len(l:value)
  if l:length < 2
    return 0
  endif

  let l:sum = 0
  for l:i in range(l:length - 1, 0, -1)
    let l:char = strpart(l:value, l:i, 1)
    if l:char <# '0' || l:char ># '9'
      return 0
    elseif l:i % 2 == (l:length % 2)
      let l:char *= 2
      if l:char ># '9'
        let l:char -= 9
      endif
    endif
    
    let l:sum += l:char
  endfor

  return l:sum % 10 == 0
endfunction