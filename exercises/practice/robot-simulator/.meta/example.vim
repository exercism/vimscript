let s:directions = ['north', 'east', 'south', 'west']

function! Create(direction, x, y) abort
  return {'direction': a:direction,
  \       'x': a:x,
  \       'y': a:y,
  \       'Move': function('MoveRobot')}
endfunction

function! MoveRobot(instructions) dict
  for l:instruction in a:instructions
    if l:instruction ==# 'L'
      let l:index = index(s:directions, self.direction)
      let self.direction = s:directions[index - 1]
    elseif l:instruction ==# 'R'
      let l:index = index(s:directions, self.direction)
      let l:index = (l:index + 1) % 4
      let self.direction = s:directions[l:index]
    elseif l:instruction ==# 'A'
      if self.direction ==# 'north'
        let self.y += 1
      elseif self.direction ==# 'east'
        let self.x += 1
      elseif self.direction ==# 'south'
        let self.y -= 1
      elseif self.direction ==# 'west'
        let self.x -= 1
      endif
    endif
  endfor
endfunction
