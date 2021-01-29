"
" TravisCI's Trusty uses Vim 7.4.52. No uniq() for us.
"

function! Equilateral(triangle) abort
  let [a, b, c] = a:triangle
  return s:invalid(a:triangle) ? 0 : a == b && a == c
endfunction

function! Isosceles(triangle) abort
  let [a, b, c] = a:triangle
  return s:invalid(a:triangle) ? 0 : a == b || a == c || b == c
endfunction

function! Scalene(triangle) abort
  let [a, b, c] = a:triangle
  return s:invalid(a:triangle) ? 0 : a != b && a != c && b != c
endfunction

function! s:invalid(triangle) abort
  let [a, b, c] = a:triangle

  if a == 0 || b == 0 || c == 0 || a + b < c || a + c < b || b + c < a
    return 1
  endif

  return 0
endfunction
