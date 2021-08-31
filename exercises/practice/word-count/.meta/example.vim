function! WordCount(phrase) abort
  let words = {}

  for word in split(a:phrase, "[^[:alnum:]']\\+")
    let word = substitute(tolower(word), "^'\\(.*\\)'$", '\1', '')
    let words[word] = get(words, word) + 1
  endfor

  return words
endfunction
