function! Matrix(string) abort
  let l:values = []
  for l:row in split(a:string, '\n')
    let l:working = []
    for l:token in split(l:row, ' ')
      call add(l:working, l:token)
    endfor

    call add(l:values, l:working)
  endfor

  return {'values': l:values,
  \       'Row': function('s:Row'),
  \       'Column': function('s:Column')}
endfunction

function! s:Row(index) dict
  return get(self.values, a:index - 1)
endfunction

function! s:Column(index) dict
  let l:index = a:index - 1
  let l:results = []
  for l:row in self.values
    call add(l:results, get(l:row, l:index))
  endfor

  return l:results
endfunction
