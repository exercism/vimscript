" add two strings as numbers from right to left, as if by hand
function! StringAdd(a, b) abort
  " zero-left-pad so the numbers are the same length
  let len = max([strlen(a:a), strlen(a:b)])
  let a = printf('%0*s', len, a:a)
  let b = printf('%0*s', len, a:b)
  let result = ""
  let carry = 0

  for i in range(len - 1, 0, -1)
    let c = carry + str2nr(strpart(a, i, 1)) + str2nr(strpart(b, i, 1))
    let result = $"{c % 10}{result}"
    let carry = c / 10
  endfor
  return trim($"{carry}{result}", '0', 1)
endfunction

" populate the squares, doubling each previous, cache in the script scope
let s:grains = ['1']
for i in range(1, 63)
  eval add(s:grains, StringAdd(s:grains[i - 1], s:grains[i - 1]))
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
