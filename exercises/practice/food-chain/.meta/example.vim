let creatures=['fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse']

let uniqueLine={
  \   'fly': "I don't know why she swallowed the fly. Perhaps she'll die.",
  \   'spider': 'It wriggled and jiggled and tickled inside her.',
  \   'bird': 'How absurd to swallow a bird!',
  \   'cat': 'Imagine that, to swallow a cat!',
  \   'dog': 'What a hog, to swallow a dog!',
  \   'goat': 'Just opened her throat and swallowed a goat!',
  \   'cow': "I don't know how she swallowed a cow!",
  \   'horse': "She's dead, of course!"
  \ }

function! Verse(num)
  let i = a:num
  let creature = g:creatures[l:i - 1]
  let lines = [
    \         'I know an old lady who swallowed a ' . l:creature . '.',
    \         g:uniqueLine[l:creature]
    \       ]

  if l:creature ==# 'fly' || l:creature ==# 'horse'
    return l:lines
  endif

  while l:i > 1 
    let creature1 = g:creatures[l:i - 1]
    let creature2 = g:creatures[l:i - 2]
    if l:creature2 ==# 'spider' 
      let lines = add(l:lines, 'She swallowed the ' . creature1 . ' to catch the ' . creature2 . ' that wriggled and jiggled and tickled inside her.')
    else
      let lines = add(l:lines, 'She swallowed the ' . creature1 . ' to catch the ' . creature2 . '.')
    endif
    let i -= 1
  endwhile

  return add(l:lines, g:uniqueLine['fly'])
endfunction

function! Recite(endVerse, startVerse)
  let content=[]
  let num = a:startVerse
  let break = 0

  while l:num <= a:endVerse
    if l:break 
      let content = add(l:content, '')
    endif
    let content += Verse(l:num)

    let num += 1
    let break = 1
  endwhile

  return content
endfunction
