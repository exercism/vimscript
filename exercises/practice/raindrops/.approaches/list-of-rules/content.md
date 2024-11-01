# Looping Over A List of Rules

```vim
let s:rules = [[3, 'Pling'], [5, 'Plang'], [7, 'Plong']]

function! Raindrops(number) abort
  let l:str = ''

  for [l:factor, l:sound] in s:rules
    if a:number % l:factor == 0
      let l:str .= l:sound
    endif
  endfor

  return empty(l:str) ? string(a:number) : l:str
endfunction
```
