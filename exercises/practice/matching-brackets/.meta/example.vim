function! IsPaired(str) abort
  let l:stack = []
  let l:pairs = {'(': ')', '[': ']', '{': '}'}

  for l:char in split(a:str, '\zs')
    if has_key(l:pairs, l:char)
      call add(l:stack, l:char)
    elseif index(values(l:pairs), l:char) != -1
      if empty(l:stack)
          return 0
      endif

      let l:popped = remove(l:stack, -1)
      if l:pairs[popped] !=# l:char
        return 0
      endif
    endif
  endfor

  return empty(l:stack)
endfunction

