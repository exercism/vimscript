let s:allergy_map = {
      \ 'eggs':         1,
      \ 'peanuts':      2,
      \ 'shellfish':    4,
      \ 'strawberries': 8,
      \ 'tomatoes':     16,
      \ 'chocolate':    32,
      \ 'pollen':       64,
      \ 'cats':         128,
      \ }

function! AllergicTo(score, allergy) abort
  return and(a:score, s:allergy_map[a:allergy]) != 0
endfunction

function! List(score) abort
  return filter(map(sort(items(s:allergy_map), 's:valsort'),
        \ 'v:val[0]'), 'AllergicTo(a:score, v:val)')
endfunction

function! s:valsort(a, b) abort
  return a:a[1] - a:b[1]
endfunction
