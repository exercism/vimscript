function! Score(x, y) abort
  let l:distance = sqrt(a:x * a:x + a:y * a:y)
  
  if l:distance <= 1
    return 10
  elseif l:distance <= 5
    return 5
  elseif l:distance <= 10
    return 1
  else
    return 0
  endif
endfunction
  