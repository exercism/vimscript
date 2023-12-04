function! Clock(hours, minutes) abort
  let l:minutes = s:Mod(a:hours * 60 + a:minutes, 1440)
  return {
  \       'minutes': l:minutes,
  \       'ToString': funcref('s:ToString'),
  \       'Add': funcref('s:Add'),
  \       'Subtract': funcref('s:Subtract')
  \ }
endfunction

function! s:ToString() dict
  let l:total_minutes = s:Mod(self.minutes, 1440)
  let l:hours = l:total_minutes / 60
  let l:minutes = s:Mod(l:total_minutes, 60)

  return printf('%02d:%02d', l:hours, l:minutes)
endfunction

function! s:Add(minutes) dict
  let self.minutes += a:minutes
endfunction

function! s:Subtract(minutes) dict
  let self.minutes -= a:minutes
endfunction

function! s:Mod(n, m)
  return ((a:n % a:m) + a:m) % a:m
endfunction
