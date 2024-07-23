function! Plants(diagram, student) abort
  let l:garden = s:Parse(a:diagram)
  let l:positions = get(s:studentPositions, a:student)
  let l:firstPosition = positions[0]
  let l:secondPosition = positions[1]

  let l:firstRow = garden[0]
  let l:secondRow = garden[1]

  return [ firstRow[firstPosition],  firstRow[secondPosition],
  \        secondRow[firstPosition], secondRow[secondPosition] ]
endfunction


function s:Parse(diagram) abort
  let l:garden = []
  for l:row in split(a:diagram, '\n')
    let l:section = []
    for l:code in split(l:row, '\zs')
      let l:plant = get(s:plantCodes, l:code)
      call add(l:section, l:plant)
    endfor

    call add(l:garden, l:section)
  endfor

  return l:garden
endfunction

let s:plantCodes = {
\   'G': 'grass',
\   'C': 'clover',
\   'R': 'radishes',
\   'V': 'violets'
\ }

let s:studentPositions = {
\   'Alice':    [0,  1],
\   'Bob':      [2,  3],
\   'Charlie':  [4,  5],
\   'David':    [6,  7],
\   'Eve':      [8,  9],
\   'Fred':     [10, 11],
\   'Ginny':    [12, 13],
\   'Harriet':  [14, 15],
\   'Ileana':   [16, 17],
\   'Joseph':   [18, 19],
\   'Kincaid':  [20, 21],
\   'Larry':    [22, 23]
\ }
