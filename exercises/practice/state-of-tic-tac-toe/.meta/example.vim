" Determine the state of a Tic-Tac-Toe game represented
" by a list of strings representing each row. An exception
" is thrown if the board represents an invalid state.
"
function! Gamestate(board) abort
  let x_count = 0
  let o_count = 0

  for row in a:board
    let x_count += count(split(row, '\zs'), 'X')
    let o_count += count(split(row, '\zs'), 'O')
  endfor

  if o_count > x_count
    throw 'Wrong turn order: O started'
  endif
  if x_count > o_count + 1
    throw 'Wrong turn order: X went twice'
  endif

  let x_won = s:CheckWin(a:board, 'X')
  let o_won = s:CheckWin(a:board, 'O')

  if x_won && o_won
    throw 'Impossible board: game should have ended after the game was won'
  endif

  if x_won
    if x_count == o_count
      throw 'Impossible board: game should have ended after the game was won'
    endif
    return 'win'
  endif

  if o_won
    if x_count > o_count
      throw 'Impossible board: game should have ended after the game was won'
    endif
    return 'win'
  endif

  if x_count + o_count == 9
    return 'draw'
  endif

  return 'ongoing'
endfunction

function! s:CheckWin(board, player) abort
  " Three in a row
  for row in a:board
    if row ==# repeat(a:player, 3)
      return v:true
    endif
  endfor

  " Three in a column
  for col in range(3)
    let matches = 0
    for row in range(3)
      if a:board[row][col] ==# a:player
        let matches += 1
      endif
    endfor
    if matches == 3
      return v:true
    endif
  endfor

  " Diagonal from top-left to bottom-right
  let matches = 0
  for i in range(3)
    if a:board[i][i] ==# a:player
      let matches += 1
    endif
  endfor
  if matches == 3
    return v:true
  endif

  " Diagonal from top-right to bottom-left
  let matches = 0
  for i in range(3)
    if a:board[i][2-i] ==# a:player
      let matches += 1
    endif
  endfor
  if matches == 3
    return v:true
  endif

  return v:false
endfunction
