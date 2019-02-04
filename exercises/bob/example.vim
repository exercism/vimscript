function! Response(remark) abort
  if s:is_silent(a:remark)
    return 'Fine. Be that way!'
  elseif s:is_loud(a:remark) && s:is_question(a:remark)
    return "Calm down, I know what I'm doing!"
  elseif s:is_loud(a:remark)
    return 'Whoa, chill out!'
  elseif s:is_question(a:remark)
    return 'Sure.'
  else
    return 'Whatever.'
  endif
endfunction

function! s:is_silent(remark) abort
  return a:remark !~# '[[:graph:]]'
endfunction

function! s:is_loud(remark) abort
  return a:remark =~# '[A-Z]' && a:remark ==# toupper(a:remark)
endfunction

function! s:is_question(remark) abort
  return a:remark =~? '?\s*$'
endfunction
