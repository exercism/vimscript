function! Slices(series, sliceLength) abort
  let l:seriesLength = len(a:series)
  if l:seriesLength == 0
    throw 'series cannot be empty'
  elseif a:sliceLength == 0
    throw 'slice length cannot be zero'
  elseif a:sliceLength <= 0
    throw 'slice length cannot be negative'
  elseif l:seriesLength < a:sliceLength
    throw 'slice length cannot be greater than series length'
  endif

  let l:slices = []
  let l:limit = l:seriesLength - a:sliceLength + 1
  for l:i in range(l:limit)
    let l:stop = l:i + a:sliceLength - 1
    call add(l:slices, a:series[l:i : l:stop])
  endfor

  return l:slices
endfunction
