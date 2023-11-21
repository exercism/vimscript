function! Square(number) abort
  if a:number < 1 || a:number > 64
    throw 'square must be between 1 and 64'
  endif

  return float2nr(pow(2, (a:number-1)))
endfunction

function! Total() abort
  return float2nr(pow(2, 64) - 1)
endfunction
