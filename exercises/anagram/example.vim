function! Anagram(word, candidates) abort
  let fp = s:fingerprint(a:word)
  let matches = []

  for cand in a:candidates
    if cand ==? a:word
      continue
    elseif s:fingerprint(cand) ==? fp
      let matches += [cand]
    endif
  endfor

  return sort(matches)
endfunction

function! s:fingerprint(word) abort
  return sort(reverse(split(tolower(a:word), '\zs')))
endfunction
