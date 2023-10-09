function! TwoFer(name) abort
  let person = (a:name ==? '') ? 'you' : a:name
  return 'One for ' . l:person . ', one for me.'
endfunction
