function! Translate(phrase) abort
  let l:words = split(a:phrase, '\s\+')
  let l:translated = map(l:words, 's:TranslateWord(v:val)')
  return join(l:translated, ' ')
endfunction

let s:Regexes = [
    \ '\v^([^aeiou]*qu)(.+)',
    \ '\v^([^aeiouy]+)(y.+)',
    \ '\v^()(xr|yt|[aeiou].+)',
    \ '\v^([^aeiou]+)(.+)'
    \]

function! s:TranslateWord(word) abort
  for l:regex in s:Regexes
      let l:match = matchlist(a:word, l:regex)
      if empty(l:match)
          continue
      elseif empty(l:match[1])
          break
      else
          return l:match[2] . l:match[1] . 'ay'
      endif
  endfor
  return a:word . 'ay'
endfunction