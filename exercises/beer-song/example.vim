function! Verse(verse) abort
  if a:verse == 0
    return "No more bottles of beer on the wall, no more bottles of beer.\n".
          \ "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  elseif a:verse == 1
    return "1 bottle of beer on the wall, 1 bottle of beer.\n".
          \ "Take it down and pass it around, no more bottles of beer on the wall.\n"
  elseif a:verse == 2
    return "2 bottles of beer on the wall, 2 bottles of beer.\n".
          \ "Take one down and pass it around, 1 bottle of beer on the wall.\n"
  else
    return printf(
          \ "%s bottles of beer on the wall, %s bottles of beer.\n".
          \ "Take one down and pass it around, %s bottles of beer on the wall.\n",
          \ a:verse, a:verse, a:verse - 1)
  end
endfunction

function! Verses(start, end) abort
  return join(map(range(a:start, a:end, -1), 'Verse(v:val)'), "\n")
endfunction
