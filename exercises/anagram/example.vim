function! FindAnagrams(candidates, subject) abort
  let fp = s:fingerprint(a:subject)
  let matches = []

  for cand in a:candidates
    if cand ==? a:subject
      continue
    elseif s:fingerprint(cand) ==? fp
      let matches += [cand]
    endif
  endfor

  return matches
endfunction

function! s:fingerprint(subject) abort
  return sort(reverse(split(tolower(a:subject), '\zs')))
endfunction
