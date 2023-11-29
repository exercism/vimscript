"
" Returns the number of grains on a chessboard square given the grains on each square
" double from the previous square. 
" Throws an error if the square is below 1 or above 64.
"
" Examples:
"
"   :echo Square(16)
"   32768
"
"   :echo Square(-1)
"   E605: Exception not caught: square must be between 1 and 64
"
function! Square(number) abort
  " your code goes here
endfunction

"
" Returns the total number of grains for a filled chessboard
"
function! Total(number) abort
  " your code goes here
endfunction
