# Reverse a List of Characters

```vim
function! Reverse(text) abort
    return join(reverse(split(a:text, '\zs')), '')
endfunction
```
