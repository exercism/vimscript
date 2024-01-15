# Chaining Boolean expressions

```vim
function! LeapYear(year) abort
  return a:year % 4 == 0 && a:year % 100 != 0 || a:year % 400 == 0
endfunction
```

In the snippet `year % 4 == 0`, `year` is first divided by 4, returning the remainder or portion left over.
If the year is evenly divisible by 4, the remainder would be 0 and `0 == 0` produces true.
This check will be repeated two more times for our other rules.
The logical AND (`&&`) and OR (`||`) operators are used to produce a single value from the expressions on either side.
These operators notably short-circuit and only evaluate the right-hand side in specific situations.
The `&&` operator only evaluates and returns the right-hand side when the left-hand side is truthy.
If the left-hand side is falsey, it is returned without evaluating the right-hand side.
The `||` operator only evaluates and returns the right-hand side when the left-hand side is falsey.
If the left-hand side is truthy, it is returned without evaluating the right-hand side.
In the below table, Vim script represents true and false as 1 and 0.

| n1 | n2 | n1 OR n2 | n1 AND n2 |
| -- | -- | -------- | --------- |
| 0  | 0  |        0 |         0 |
| 0  | 1  |        1 |         0 |
| 1  | 0  |        1 |         0 |
| 1  | 1  |        1 |         1 | 

By situationally skipping some checks, the code can be efficientlly calculate the result with fewer operations.
