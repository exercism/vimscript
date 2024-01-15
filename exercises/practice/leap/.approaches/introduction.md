# Introduction

There are two idiomatic approaches highlighted here for his exercise.
Both involve checking if a year is evenly divisible by 4, 100, and 400 using [the modulo operator '%'][modulo-operator].

## General guidance

Regardless of the approach chosen, this exercise requires students to use Boolean logic to decide if a given year is a leap year.

## Approach: Boolean chaining

```vim
function! LeapYear(year) abort
  return a:year % 4 == 0 && a:year % 100 != 0 && a:year % 4 == 0
endfunction
```

For more information, check the [Boolean chain approach][approach-boolean-chain].

## Approach: If else statements

```vim
function! LeapYear(year) abort
  if a:year % 400 == 0 
    return 1
  elseif a:year % 100 == 0
    return 0
  elseif a:year % 4 == 0
    return 1
  endif
endfunction
```

For more information, check the [if else statements approach][approach-if-else-statements].

[modulo-operator]: https://en.wikipedia.org/wiki/Modulo
[approach-boolean-chain]: https://exercism.org/tracks/vimscript/exercises/leap/approaches/boolean-chain
[approach-if-else-statements]: https://exercism.org/tracks/vimscript/exercises/leap/if-else-statements