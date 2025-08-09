function! Say(number) abort
  if a:number < 0 || a:number > 999999999999
    throw 'input out of range'
  endif

  if a:number == 0
    return 'zero'
  endif

  let l:chunks = s:ChunksReversed(a:number)
  let l:fragments = map(l:chunks, function('s:ToWords'))
  let l:fragments = map(l:fragments, function('s:ApplyScale'))
  let l:fragments = filter(l:fragments, '!empty(v:val)')
  call reverse(l:fragments)
  return join(l:fragments, ' ')
endfunction

function! s:ApplyScale(index, value) abort
  if empty(a:value)
    return
  endif

  if !a:index
    return a:value
  elseif a:index == 1
    return a:value . ' thousand'
  elseif a:index == 2
    return a:value . ' million'
  elseif a:index == 3
    return a:value . ' billion'
  endif
endfunction

function! s:ChunksReversed(str) abort
  let l:result = []
  let l:working = a:str

  while len(l:working) > 0
      call add(l:result, l:working[-3:])
      let l:working = l:working[:-4]
  endwhile

  return l:result
endfunction

function! s:ToWords(index, chunk)
  let l:words = []
  if a:chunk < 20
    call add(l:words, s:FirstTwentyNumbers[a:chunk])
  elseif a:chunk < 100
    let l:tens = s:WordsForTens[a:chunk / 10]
    let l:ones = s:FirstTwentyNumbers[a:chunk % 10]
    if !empty(l:ones)
      call add(l:words, l:tens . '-' . l:ones)
    else
      call add(l:words, l:tens)
    endif
  else
    let l:hundreds = s:FirstTwentyNumbers[a:chunk / 100]
    let l:rest = s:ToWords(a:index, a:chunk % 100)
    if !empty(l:rest)
      call add(l:words, l:hundreds . ' hundred ' . l:rest)
    else
      call add(l:words, l:hundreds . ' hundred')
    endif
  endif

  return join(l:words, ' ')
endfunction

let s:FirstTwentyNumbers = [
\ '','one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',
\ 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
\ ]

let s:WordsForTens = [
\ '', 'tens', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
\ ]
