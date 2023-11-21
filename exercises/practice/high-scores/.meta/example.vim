function! HighScores(scores) abort
  return {'scores': a:scores,
    \ 'Scores': function('Scores'),
    \ 'Latest': function('Latest'),
    \ 'PersonalBest': function('PersonalBest'),
    \ 'PersonalTopThree': function('PersonalTopThree')}
endfunction

function! Scores() dict
  return self.scores
endfunction

function! Latest() dict
  let l:last = len(self.scores) - 1
  return self.scores[l:last]
endfunction

function! PersonalBest() dict
  let l:max = self.scores[0]
  for l:score in self.scores
    if l:score > l:max
      let l:max = l:score
    endif
  endfor

  return l:max
endfunction

function! PersonalTopThree() dict
  let l:descending = reverse(sort(copy(self.scores), 'n'))
  if len(l:descending) >= 3
    let l:descending = l:descending[0:2]
  endif

  return l:descending
endfunction
