function! LargestProduct(digits, span) abort
  if a:span == 0
    return 1
  elseif a:span < 0 || empty(a:digits)
    return -1
  endif

  let max = -1

  for i in range(len(a:digits) - a:span + 1)
    let tmp = s:product(a:digits[i : i + a:span - 1])
    if tmp > max
      let max = tmp
    endif
  endfor

  return max
endfunction

function! s:product(digits) abort
  let prod = a:digits[0]

  for digit in split(a:digits[1:], '\zs')
    if digit !~? '\d'
      throw 'invalid input'
    endif
    let prod = prod * digit
  endfor

  return prod
endfunction
