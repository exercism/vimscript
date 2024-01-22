# Introduction

There are two common approaches highlighted here for this exercise.

## Approach: Reversing a list of characters

```vim
function! Reverse(text) abort
    return join(reverse(split(a:text, '\zs')), '')
endfunction
```

For more information, check the [reversing a list of characters approach][approach-list-of-characters].

## Approach: Looping in reverse

```vim
function! Reverse(text) abort
    let l:reversed = ""
    for i in range(len(a:text) - 1, -1, -1)
        let l:reversed .= a:text[i]
    endfor
    return reversed
endfunction
```

For more information, check the [looping in reverse approach][approach-loop-in-reverse].

[modulo-operator]: https://en.wikipedia.org/wiki/Modulo
[approach-list-of-characters]: https://exercism.org/tracks/vimscript/exercises/reverse-string/approaches/list-of-characters
[approach-looping-in-reverse]: https://exercism.org/tracks/vimscript/exercises/reverse-string/approaches/looping-in-reverse
