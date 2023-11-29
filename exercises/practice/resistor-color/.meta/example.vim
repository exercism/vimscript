let s:COLORS = ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white']

function! ColorCode(color) abort
  return index(s:COLORS, a:color)
endfunction

function! Colors() abort
  return s:COLORS
endfunction
