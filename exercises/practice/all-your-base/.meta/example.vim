function! Rebase(digits, inputBase, outputBase) abort
  if a:inputBase < 2
    throw 'input base must be >= 2'
  endif

  if a:outputBase < 2
    throw 'output base must be >= 2'
  endif

  let l:invalid = filter(copy(a:digits), {_, n ->  n < 0 || n >= a:inputBase})
  if len(l:invalid) > 0
    throw 'all digits must satisfy 0 <= d < input base'
  endif

  let l:decimal = s:ToDecimal(a:digits, a:inputBase)

  let l:result = []
  while l:decimal > 0
    let l:remainder = l:decimal % a:outputBase
    let l:result = add(l:result, l:remainder)
    let l:decimal = l:decimal / a:outputBase
  endwhile

  return empty(l:result) ? [0] : reverse(l:result)
endfunction

function! s:ToDecimal(digits, inputBase) abort
  let l:decimal = 0
  for i in range(len(a:digits))
    let l:decimal = l:decimal * a:inputBase + a:digits[i]
  endfor

  return l:decimal
endfunction
