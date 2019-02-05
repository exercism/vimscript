function! NucleotideCounts(strand) abort
  let counts = {
        \ 'A': 0,
        \ 'C': 0,
        \ 'G': 0,
        \ 'T': 0,
        \ }

  if a:strand =~# '[^ACGT]'
    throw 'Invalid nucleotide in strand'
  endif

  for nucleotide in split(a:strand, '\zs')
    let counts[nucleotide] += 1
  endfor

  return counts
endfunction
