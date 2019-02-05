"
" This function takes two strings which represent strands and returns
" their Hamming distance.
"
" If the lengths of the strands don't match, throw this exception:
"
"     'left and right strands must be of equal length'
"
function! Distance(strand1, strand2)
  if len(a:strand1) != len(a:strand2)
    throw 'left and right strands must be of equal length'
  endif
  let distance = 0
  for i in range(len(a:strand1))
    let distance += (a:strand1[i] != a:strand2[i])
  endfor
  return distance
endfunction
