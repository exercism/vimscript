function! SimulateGame(playerA, playerB) abort
  let l:handA = map(copy(a:playerA), 's:Val(v:val)')
  let l:handB = map(copy(a:playerB), 's:Val(v:val)')
  let l:turn = 'A'
  let l:pile = []
  let l:seen = {}
  let l:total_tricks = 0
  let l:cards_played = 0
  let l:current_debt = 0 
  
  while v:true
    if empty(l:pile)
      let l:round = string([l:handA, l:handB, l:turn])
      if has_key(l:seen, l:round)
        return {'status': 'loop', 'tricks': l:total_tricks, 'cards': l:cards_played}
      endif
      let l:seen[l:round] = v:true
    endif
    
    let l:active_hand = l:turn ==# 'A' ? l:handA : l:handB
    let l:other_hand = l:turn ==# 'A' ? l:handB : l:handA
    if empty(l:active_hand)
      let l:extra_trick = empty(l:pile) ? 0 : 1
      return {'status': 'finished', 'tricks': l:total_tricks + l:extra_trick, 'cards': l:cards_played}
    endif
    
    let l:card_val = remove(l:active_hand, 0)
    call add(l:pile, l:card_val)
    let l:cards_played += 1
    
    " payment card so debt is either forgiven for player or assigned to opponent
    if l:card_val > 0
      let l:current_debt = l:card_val
      let l:turn = l:turn ==# 'A' ? 'B' : 'A'
    else
      " time to pay up!
      if l:current_debt > 0
        let l:current_debt -= 1
        if l:current_debt == 0
          " penalty paid off
          call extend(l:other_hand, l:pile)
          let l:pile = []
          let l:total_tricks += 1
          let l:current_debt = 0 

          if empty(l:handA) || empty(l:handB)
             return {'status': 'finished', 'tricks': l:total_tricks, 'cards': l:cards_played}
          endif

        let l:turn = l:turn ==# 'A' ? 'B' : 'A'
        endif
      else
        let l:turn = l:turn ==# 'A' ? 'B' : 'A'
      endif
    endif
  endwhile
endfunction

function! s:Val(card) abort
  if a:card ==# 'J'
    return 1
  elseif a:card ==# 'Q'
    return 2
  elseif a:card ==# 'K'
    return 3
  elseif a:card ==# 'A'
    return 4
  endif
  return 0
endfunction
