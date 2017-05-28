function! ToRoman(number) abort
  let romandict = [
        \ [1000, 'M' ],
        \ [ 900, 'CM'],
        \ [ 500, 'D' ],
        \ [ 400, 'CD'],
        \ [ 100, 'C' ],
        \ [  90, 'XC'],
        \ [  50, 'L' ],
        \ [  40, 'XL'],
        \ [  10, 'X' ],
        \ [   9, 'IX'],
        \ [   5, 'V' ],
        \ [   4, 'IV'],
        \ [   1, 'I' ],
        \ ]

  let num = a:number
  let ret = ''

  for [arabic, roman] in romandict
    while num >= arabic
      let ret .= roman
      let num -= arabic
    endwhile
  endfor

  return ret
endfunction
