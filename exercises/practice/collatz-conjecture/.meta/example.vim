function! Steps(number) abort
  if a:number < 1
    throw 'Only positive integers are allowed'
  endif

  let l:step = 0
  let l:working = a:number
  while l:working != 1
    if l:working % 2 == 0
      let l:working /= 2
    else
      let l:working = 3 * l:working + 1
    endif
  
    let l:step += 1
  endwhile
  
  return l:step
endfunction
