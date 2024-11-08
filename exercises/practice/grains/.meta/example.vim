" add two strings as numbers from right to left, as if by hand
function! StringAdd(a, b) abort
  " zero-left-pad so the numbers are the same length
  let len = [a:a->strlen(), a:b->strlen()]->max()
  let a = printf('%0*s', len, a:a)
  let b = printf('%0*s', len, a:b)
  let result = ""
  let carry = 0

  for i in range(len - 1, 0, -1)
    let c = carry + a->strpart(i, 1)->str2nr() + b->strpart(i, 1)->str2nr()
    let result = $"{c % 10}{result}"
    let carry = c / 10
  endfor
  return $"{carry}{result}"->trim('0', 1)
endfunction

" populate the squares, doubling each previous, cache in the script scope
let s:grains = ['1']
for i in range(1, 63)
  eval s:grains->add(StringAdd(s:grains[i - 1], s:grains[i - 1]))
endfor

" return the grains on square `number`
function! Square(number) abort
  if a:number < 1 || a:number > 64
    throw 'square must be between 1 and 64'
  endif
  return s:grains[a:number - 1]
endfunction

" return the total number of grains
function! Total() abort
  let total = '0'
  for i in range(64)
    let total = StringAdd(total, s:grains[i])
  endfor
  return total
endfunction
