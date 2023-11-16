function! Recite(startBottles, takeDown) abort
  let l:verses = []
  let l:end = a:startBottles - a:takeDown + 1

  for l:bottle in range(a:startBottles, l:end, -1)
    let l:verses = extend(l:verses, s:Section(l:bottle))
    if l:bottle > (a:startBottles - a:takeDown + 1)
    let l:verses = add(l:verses, '')
    endif
  endfor

  return l:verses
endfunction

function! s:Section(currentBottle) abort
  return [
    \    s:MainVerse(a:currentBottle),
    \    s:MainVerse(a:currentBottle),
    \    'And if one green bottle should accidentally fall,',
    \    s:SecondaryVerse(a:currentBottle)
    \   ]
endfunction

function! s:MainVerse(currentBottle) abort
  let l:currentOrdinal =  get(s:decimal_to_ordinal, a:currentBottle)
  let l:casedOrdinal = s:SentenceCase(l:currentOrdinal)
  let l:bottleWord = s:Pluralize('bottle', a:currentBottle)

  return $"{casedOrdinal} green {bottleWord} hanging on the wall,"
endfunction

function! s:SecondaryVerse(currentBottle) abort
  let l:nextBottle = a:currentBottle - 1
  let l:nextOrdinal =  get(s:decimal_to_ordinal, l:nextBottle, 'no')
  let l:bottleWord = s:Pluralize('bottle', l:nextBottle)

  return $"There'll be {nextOrdinal} green {bottleWord} hanging on the wall."
endfunction

let s:decimal_to_ordinal = {
  \   1: 'one',
  \   2: 'two',
  \   3: 'three',
  \   4: 'four',
  \   5: 'five',
  \   6: 'six',
  \   7: 'seven',
  \   8: 'eight',
  \   9: 'nine',
  \   10: 'ten',
  \ }

function! s:SentenceCase(str) abort
  return toupper(a:str[0]) . a:str[1:]
endfunction

function! s:Pluralize(word, quantity) abort
  let l:suffix =  a:quantity != 1 ? 's' : ''

  return a:word . l:suffix
endfunction
