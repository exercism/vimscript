function! Classify(number) abort
  if a:number <= 0
    throw 'Classification is only possible for positive integers.'
  elseif a:number == 1
    return 'deficient'
  endif
  
  let l:aliquot_sum = 1
  let l:stop = float2nr(sqrt(a:number))
  
  for l:divisor in range(2, l:stop)
    if a:number % l:divisor == 0
      let l:increment = l:divisor
      if (l:divisor * l:divisor) != a:number
        let l:increment += a:number / l:divisor
      endif
      
      let l:aliquot_sum += l:increment
    endif
  endfor
  
  if l:aliquot_sum < a:number
    return 'deficient'
  elseif l:aliquot_sum == a:number
    return 'perfect'
  else
    return 'abundant'
  endif
endfunction