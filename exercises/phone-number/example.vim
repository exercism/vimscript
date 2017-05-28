function! ToNANP(number) abort
  let num = substitute(a:number, '\D', '', 'g')
  return num =~? '\v^1?[2-9]\d{2}[2-9]\d{6}$' ? num[-10:] : ''
endfunction
