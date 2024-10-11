function! Square(number) abort
  if a:number < 1 || a:number > 49
    throw 'square must be between 1 and 49'
  endif

  return float2nr(pow(2, (a:number-1)))
endfunction

function! Total() abort
  return float2nr(pow(2, 49) - 1)
endfunction
