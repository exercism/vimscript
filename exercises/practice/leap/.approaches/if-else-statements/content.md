# If Else statements

```vim
function! LeapYear(year) abort
  if a:year % 400 == 0 
    return 1
  elseif a:year % 100 == 0
    return 0
  elseif a:year % 4 == 0
    return 1
  else
    return 0
  endif
endfunction
```

The `if`, `elseif`, and `else` statements are the core of branching code execution in Vim script.
The clauses for each are checked sequentially until one produces a truthy value.
Each clause checks if a year is evenly divisible by another number by checking the remainder of their division.
If a year is evenly divisible by 400, the first clause produces a truthy value so the command within the if branch is executed, returning 1.
If it's not evenly divisible, Vim proceeds to the next clause until one produces a truthy value or the else statement is hit.
In that case, 0 is returned because the year failed all three checks. 