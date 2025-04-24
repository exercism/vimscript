function! Rows(letter) abort
  if a:letter ==# 'A'
    return 'A'
  endif

  let l:start = char2nr('A')
  let l:end = char2nr(a:letter)
  let l:size = l:end - l:start + 1

  let l:diamond = []
  for l:i in range(0, l:size - 1)
    let l:outer = repeat(' ', l:size - 1 - i)
    let l:inner = nr2char(l:start + i)
    if l:i > 0
      let l:inner = l:inner . repeat(' ', 2 * l:i - 1) . l:inner
    endif
    let line = l:outer . l:inner . l:outer
    call add(l:diamond, l:line)
  endfor

  for l:i in range(l:size - 2, 0, -1)
    call add(l:diamond, l:diamond[l:i])
  endfor

  return join(l:diamond, '\n')
endfunction
