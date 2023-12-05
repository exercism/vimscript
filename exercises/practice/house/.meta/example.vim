let s:parts = [
  \ ['house', 'Jack built'],
  \	['malt', 'lay in'],
  \	['rat', 'ate'],
  \	['cat', 'killed'],
  \	['dog', 'worried'],
  \	['cow with the crumpled horn', 'tossed'],
  \	['maiden all forlorn', 'milked'],
  \	['man all tattered and torn', 'kissed'],
  \	['priest all shaven and shorn', 'married'],
  \	['rooster that crowed in the morn', 'woke'],
  \	['farmer sowing his corn', 'kept'],
  \	['horse and the hound and the horn', 'belonged to']]

function! ReciteVerses(startVerse, endVerse) abort
  let l:verses = []

  for l:verse in range(a:startVerse - 1, a:endVerse - 1)
    let l:working = ''
    for l:n in range(l:verse + 1)
        let l:part = s:parts[l:verse - l:n]
        let l:subject = l:part[0]
        let l:action = l:part[1]
        let l:working .= ' the ' . l:subject . ' that ' . l:action
    endfor

    let l:working = 'This is' . l:working . '.'
    call add(l:verses, l:working)
  endfor

  return l:verses
endfunction
