function! Recite(strings) abort
  if len(a:strings) == 0
    return []
  endif

  let l:verses = []
  for i in range(len(a:strings) - 1)
    let l:verse = 'For want of a ' . a:strings[i] . ' the ' . a:strings[i + 1] . ' was lost.'
    let l:verses = add(l:verses, l:verse)
  endfor

  let l:final = 'And all for the want of a ' . a:strings[0] . '.'
  let l:verses = add(l:verses, l:final)

  return l:verses
endfunction
