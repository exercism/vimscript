""
"" Write a function that will perform the algorithm that is known as "run-length
"" encoding".
""
"" Run-length encoding (RLE) is a simple form of data compression where runs of
"" consecutive identical data elements are replaced with one data value and
"" count.
""
"" Example:
""
"" "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  ->  "12WB12W3B24WB"
""
"" RLE allows the original data to be perfectly reconstructed from the
"" compressed data, which makes it a lossless data compression.
""
"" Example:
""
"" "AABCCCDEEEE"  ->  "2AB3CD4E"  ->  "AABCCCDEEEE"
""
"" For simplicity, you can assume that the unencoded string will only contain
"" the letters A through Z. (either upper or lower case) and whitespace.

"" This means that the encoded data will not contain any numbers, so that any
"" numbers contained within data to be decoded will always represent the count
"" for the character that follows it.
""
function! Decode(string) abort
  " your code goes here
endfunction

function! Encode(string) abort
  " your code goes here
endfunction
