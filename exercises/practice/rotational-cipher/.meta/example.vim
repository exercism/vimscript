
function! Rotate(shiftKey, text) abort
  let l:encrypted = ''
  for l:char in split(a:text, '\zs')
    let l:codepoint = char2nr(l:char)
    if s:InRange(l:codepoint, s:lcaseStart, s:lcaseStop)
      let l:codepoint = s:lcaseStart + s:FindOffset(l:codepoint, s:lcaseStart, a:shiftKey)
      let l:char = nr2char(l:codepoint)
    elseif s:InRange(l:codepoint, s:upCaseStart, s:upCaseStop)
      let l:codepoint = s:upCaseStart + s:FindOffset(l:codepoint, s:upCaseStart, a:shiftKey)
      let l:char = nr2char(l:codepoint)
    endif

    let l:encrypted .= l:char
  endfor

  return l:encrypted
endfunction

let s:lcaseStart = 97
let s:lcaseStop = 122
let s:upCaseStart = 65
let s:upCaseStop = 90

function! s:InRange(elem, start, stop) abort
  return a:elem >= a:start && a:elem <= a:stop
endfunction

function! s:FindOffset(position, start, shift) abort
  return (a:position - a:start + a:shift) % 26
endfunction
