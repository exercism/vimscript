function! Format(name, number) abort
  let l:suffix = s:Suffix(a:number)
  return printf('%s, you are the %d%s customer we serve today. Thank you!', a:name, a:number, l:suffix)
endfunction

function! s:Suffix(number) abort
  let l:mod10 = a:number % 10
  let l:mod100 = a:number % 100

  if l:mod10 == 1 && l:mod100 != 11
      return 'st'
  elseif l:mod10 == 2 && l:mod100 != 12
      return 'nd'
  elseif l:mod10 == 3 && l:mod100 != 13
      return 'rd'
  endif
  return 'th'
endfunction
