"
" Greet someone or something!
"
" If no argument is given, return 'Hello, World!'.
" If the optional argument is given, greet that name instead.
"
" Hint: If you're confused by the first line in the function,
"       read `:help a:0`.
"
"       It also uses the short if-then-else syntax which is
"       called ternary operator in other languages:
"
"          condition ? true : false
"
function! Hello(...) abort
  let name = (a:0 == 1 ? a:1 : 'World')
  return 'Hello, ' . name . '!'
endfunction
