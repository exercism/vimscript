## Maximum integer value

According to [the Vim docs][number]:

> Assuming 64 bit numbers are used (see v:numbersize) an unsigned number is truncated to 0x7fffffffffffffff or 9223372036854775807.

In other words, Vimscript cannot express any number `2^63` or greater as an integer.

Some of the tests for this exercise require 64 bit integers which is behond the integer size limitation ov Vimscript.
Because of this limitation, the results of the calculations are tested against a string which expresses the integer value, rather than expressing the answer as Integer.
Can you solve this by avoiding numbers that are larger than the language will allow directly?

[number]: https://vimhelp.org/eval.txt.html#expr-number
