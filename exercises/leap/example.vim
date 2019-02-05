function! LeapYear(num) abort
  return a:num % 400 == 0 || a:num % 4 == 0 && a:num % 100 != 0
endfunction
