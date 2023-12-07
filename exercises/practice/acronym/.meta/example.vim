function! Abbreviate(phrase) abort
  let l:result = ''
  let l:phrase = substitute(a:phrase, '_', ' ', 'g')
  for l:section in split(l:phrase, ' ')
    for l:word in split(l:section, '-')
      let l:result .= toupper(l:word[0])
    endfor
  endfor

  return l:result
endfunction 
