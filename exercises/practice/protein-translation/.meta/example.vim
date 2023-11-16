function! Proteins(strand) abort
  let l:proteins = []
  for i in range(0, len(a:strand) - 1, 3)
    let l:codon = strpart(a:strand, i, 3)
    let l:protein = CodonToProtein(l:codon)
    if l:protein ==# 'STOP'
        break
    endif

    let l:proteins = add(l:proteins, l:protein)
  endfor

  return l:proteins
endfunction  

function! CodonToProtein(codon) abort
  if !has_key(s:codon_mappings, a:codon)
    throw 'Invalid codon'
  endif

  return get(s:codon_mappings, a:codon)
endfunction

let s:codon_mappings = {
\   'AUG': 'Methionine',
\   'UUU': 'Phenylalanine',
\   'UUC': 'Phenylalanine',
\   'UUA': 'Leucine',
\   'UUG': 'Leucine',
\   'UCU': 'Serine',
\   'UCC': 'Serine',
\   'UCA': 'Serine',
\   'UCG': 'Serine',
\   'UAU': 'Tyrosine',
\   'UAC': 'Tyrosine',
\   'UGU': 'Cysteine',
\   'UGC': 'Cysteine',
\   'UGG': 'Tryptophan',
\   'UAA': 'STOP',
\   'UAG': 'STOP',
\   'UGA': 'STOP'
\ }