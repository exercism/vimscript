function! Commands(binary) abort
  let l:actions = []
  let l:digits = reverse(split(a:binary, '\zs'))
  for l:i in range(5)
    if l:digits[i] ==? '1'
      if l:i == 0
        call add(l:actions, 'wink')
      elseif l:i == 1
        call add(l:actions, 'double blink')
      elseif l:i == 2
        call add(l:actions, 'close your eyes')
      elseif l:i == 3
        call add(l:actions, 'jump')
      elseif l:i == 4
        call reverse(l:actions)
      endif
    endif
  endfor

  return l:actions
endfunction
