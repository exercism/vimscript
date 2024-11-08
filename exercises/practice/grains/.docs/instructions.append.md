## Maximum integer value

According to [the Vim docs][number]:

> Assuming 64 bit numbers are used (see v:numbersize) an unsigned number is truncated to 0x7fffffffffffffff or 9223372036854775807.

That means that Vim cannot express any number `2^63` or greater as an integer.

For this exercise, you will return the values as strings.
That means you will have to implement a way to do addition on two _string_ operands.

[number]: https://vimhelp.org/eval.txt.html#expr-number
