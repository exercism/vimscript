function! DifferenceOfSquares(number) abort
  return SquareOfSum(a:number) - SumOfSquares(a:number)
endfunction

function! SquareOfSum(number) abort
  let sum = 0
  for n in range(1, a:number)
    let sum += n
  endfor
  return float2nr(pow(sum, 2))
endfunction

function! SumOfSquares(number) abort
  let sum = 0
  for n in range(1, a:number)
    let sum += float2nr(pow(n, 2))
  endfor
  return sum
endfunction
