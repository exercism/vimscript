let s:gifts = [
  \ 'a Partridge in a Pear Tree.',
  \ 'two Turtle Doves,',
  \ 'three French Hens,',
  \ 'four Calling Birds,',
  \ 'five Gold Rings,',
  \ 'six Geese-a-Laying,',
  \ 'seven Swans-a-Swimming,',
  \ 'eight Maids-a-Milking,',
  \ 'nine Ladies Dancing,',
  \ 'ten Lords-a-Leaping,',
  \ 'eleven Pipers Piping,',
  \ 'twelve Drummers Drumming,']

let s:ordinals = [
  \ 'first',
  \ 'second',
  \ 'third',
  \ 'fourth',
  \ 'fifth',
  \ 'sixth',
  \ 'seventh',
  \ 'eighth',
  \ 'ninth',
  \ 'tenth',
  \ 'eleventh',
  \ 'twelfth']

function! Recite(startVerse, endVerse) abort
  let l:verses = []
  for l:current in range(a:startVerse, a:endVerse)
    let l:availableGifts = reverse(s:gifts[0:l:current-1])
    if l:current > 1
      let l:availableGifts[-1] = 'and ' . l:availableGifts[-1]
    endif

    let l:verse = 'On the ' . s:ordinals[l:current - 1] . ' day of Christmas my true love gave to me: ' . join(l:availableGifts, ' ')
    call add(l:verses, l:verse)
  endfor

  return join(l:verses, '\n')
endfunction
