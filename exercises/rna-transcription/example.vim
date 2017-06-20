function! ToRna(strand) abort
  return a:strand =~# '[^CGTA]' ? '' : tr(a:strand, 'CGTA', 'GCAU')
endfunction
