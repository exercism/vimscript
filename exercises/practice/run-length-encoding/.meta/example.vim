function! Decode(string) abort
  let l:result = ''
  let l:charCount = ''
  for l:current in split(a:string,  '\zs')
    let l:codepoint = char2nr(l:current)
    if (l:codepoint < 48 || l:codepoint > 57)
      let l:number = max([l:charCount, 1])
      let l:result .= repeat(l:current, l:number)
      let l:charCount = ''
    else
      let l:charCount .= l:current
    endif
  endfor

  return l:result
endfunction

function! Encode(string) abort
  if len(a:string) == 0
    return ''
  endif

  let l:result = ''
  let l:charCount = 1
  let l:previous = ''
  for l:current in split(a:string,  '\zs')
    if (l:current != l:previous)
      let l:number = l:charCount > 1 ? l:charCount : ''
      let l:result .= l:number . l:previous

      let l:previous = l:current
      let l:charCount = 1
    else
      let l:charCount += 1
    endif
  endfor

  let l:number = l:charCount > 1 ? l:charCount : ''
  let l:result .= l:number . l:previous

  return l:result
endfunction

