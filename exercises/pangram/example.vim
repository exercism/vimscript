function! IsPangram(sentence) abort
  let dict = {}

  for char in map(split(a:sentence, '\zs'), 'tolower(v:val)')
    if char =~? '\a' && !has_key(dict, char)
      let dict[char] = 1
    endif
  endfor

  return len(dict) == 26
endfunction
