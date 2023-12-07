"
" Flattens an arbitrarily-deep nested array, removing v:null values.
"
" Examples:
"
"   :echo Flatten([])
"   []
"   :echo Flatten([0, 1, 2])
"   [0, 1, 2]
"   :echo Flatten([0, 1, [2, 3, v:null]])
"   [0, 1, 2, 3]
"
function! Flatten(array) abort
  " your implementation goes here
endfunction
