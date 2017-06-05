function! Transform(scores) abort
  let data = {}

  for [score, letters] in items(a:scores)
    for letter in letters
      let data[tolower(letter)] = str2nr(score)
    endfor
  endfor

  return data
endfunction
