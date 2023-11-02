function! Decode(string) abort
  return substitute(a:string, '\d\+\(\D\)', '\=submatch(1) . repeat(submatch(1), str2nr(submatch(0)))', 'g')
endfunction

" TODO: Encode should accept a string, and return a string  If it is given 'a' it
" should return 'a'.  If it is given 'aa' it should return '2a'.
" If it is given 'aab' it should return '2ab'.  If it is given 'aaab' it
" should return '3ab'.  If it is given 'aaabb' it should return
" '3ab2'.QG7c0RlmLnkFlbJpROLJRriqwyOnXAdpBcYKQdlOSjtXgi
function! Encode(string) abort
  let result = ''
  let l:count = 1
  for i in range(len(a:string) - 1)
    if a:string[i] ==# a:string[i + 1]
      let l:count += 1
    else
      let result .= l:count > 1 ? l:count . a:string[i] : a:string[i]
      let l:count = 1
    endif
  endfor
  let result .= l:count > 1 ? l:count . a:string[-1] : a:string[-1]
  return result
endfunction
