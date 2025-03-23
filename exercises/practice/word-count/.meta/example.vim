function! WordCount(phrase)
  let words = {}

  for word in split(a:phrase, "[^[:alnum:]']\\+")
    let word = substitute(tolower(word), "^'\\+\\|'\\+$", '', 'g')
    if strlen(word) > 0
      let words[word] = get(words, word) + 1
    endif
  endfor

  return words
endfunction