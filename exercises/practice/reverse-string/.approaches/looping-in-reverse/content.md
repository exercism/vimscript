# Loop In Reverse

```vim
function! Reverse(text) abort
    let l:reversed = ""
    for i in range(len(a:text) - 1, -1, -1)
        let l:reversed .= a:text[i]
    endfor
    return reversed
endfunction
```