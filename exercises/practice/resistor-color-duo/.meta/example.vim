let s:COLORS = ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white']

function! Value(colors) abort
  let [color1, color2; rest] = a:colors
  let tens = index(s:COLORS, color1)
  let ones = index(s:COLORS, color2)

  return tens * 10 + ones
endfunction
