function! Prime(number) abort
  if a:number == 0
    throw 'there is no zeroth prime'
  elseif a:number == 1
    return 2
  endif

  let l:tally = 1
  let l:candidate = 1
  while l:tally < a:number
    let l:candidate += 2
    if IsPrime(l:candidate)
      let l:tally += 1
    endif
  endwhile

  return l:candidate
endfunction

function! IsPrime(n) abort
  if a:n <= 1
    return 0
  elseif a:n == 2
    return 1
  elseif a:n % 2 == 0
    return 0
  endif

  for l:i in range(3, float2nr(sqrt(a:n)) + 1, 2)
    if a:n % l:i == 0
      return 0
    endif
  endfor

  return 1
endfunction
