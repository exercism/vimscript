# If Else Statements

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
