function! Find(list, value) abort
  let l:start = 0
  let l:stop = len(a:list) - 1

  while l:start <= l:stop
    let l:index = float2nr((l:start + l:stop) / 2)
    let l:median = a:list[l:index]

    if l:median == a:value
      return l:index
    endif

    if l:median < a:value
      let l:start = l:index + 1
    else
      let l:stop = l:index - 1
    endif
  endwhile

  throw 'value not in list'
endfunction
