# Introduction

Here are two common approaches for this exercise.

## Approach: If else statements

```vim
function! Raindrops(number) abort
  let l:str = ''
  if a:number % 3 == 0
    let l:str .= 'Pling'
  endif
  if a:number % 5 == 0
    let l:str .= 'Plang'
  endif
  if a:number % 7 == 0
    let l:str .= 'Plong'
  endif

  return empty(l:str) ? string(a:number) : l:str
endfunction
```

For more information, check the [if else statements approach][approach-if-else-statements].

## Approach: Looping over a list of rules

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

For more information, check the [looping over a list of rules approach][approach-list-of-rules].


[approach-if-else-statements]: https://exercism.org/tracks/vimscript/exercises/raindrops/approaches/if-else-statements
[approach-boolean-chain]: https://exercism.org/tracks/vimscript/exercises/raindrops/approaches/list-of-rules