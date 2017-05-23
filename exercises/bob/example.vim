function! Answer(drivel) abort
  if s:is_silent(a:drivel)
    return 'Fine. Be that way!'
  elseif s:is_loud(a:drivel)
    return 'Whoa, chill out!'
  elseif s:is_quizzical(a:drivel)
    return 'Sure.'
  else
    return 'Whatever.'
  endif
endfunction

function! s:is_silent(phrase) abort
  return a:phrase =~? '^\s*$'
endfunction

function! s:is_loud(phrase) abort
  return a:phrase =~# '[A-Z]' && a:phrase ==# toupper(a:phrase)
endfunction

function! s:is_quizzical(phrase) abort
  return a:phrase =~? '?$'
endfunction
