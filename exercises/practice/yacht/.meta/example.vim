function! Score(category, dice) abort
  if a:category ==# 'yacht'
    if len(uniq(a:dice)) > 1
      return 0
    endif
    return 50
  elseif a:category ==# 'ones'
    return count(a:dice, 1) * 1
  elseif a:category ==# 'twos'
    return count(a:dice, 2) * 2
  elseif a:category ==# 'threes'
    return count(a:dice, 3) * 3
  elseif a:category ==# 'fours'
    return count(a:dice, 4) * 4
  elseif a:category ==# 'fives'
    return count(a:dice, 5) * 5
  elseif a:category ==# 'sixes'
    return count(a:dice, 6) * 6
  elseif a:category ==# 'full house'
    let l:counts = {}
    for l:roll in a:dice
      let l:counts[l:roll] = get(l:counts, l:roll, 0) + 1
    endfor
    let l:tallies = values(l:counts)
    if index(l:tallies, 2) != -1 && index(l:tallies, 3) != -1
      return Sum(a:dice)
    endif
    return 0
  elseif a:category ==# 'four of a kind'
    if count(a:dice, 1) >= 4
      return 4 * 1
    elseif count(a:dice, 2) >= 4
      return 4 * 2
    elseif count(a:dice, 3) >= 4
      return 4 * 3
    elseif count(a:dice, 4) >= 4
      return 4 * 4
    elseif count(a:dice, 5) >= 4
      return 4 * 5
    elseif count(a:dice, 6) >= 4
      return 4 * 6
    endif
    return 0
  elseif a:category ==# 'little straight'
    if sort(uniq(a:dice)) == [1, 2, 3, 4, 5]
      return 30
    endif
    return 0
  elseif a:category ==# 'big straight'
    if sort(uniq(a:dice)) == [2, 3, 4, 5, 6]
      return 30
    endif
    return 0
  elseif a:category ==# 'choice'
    return Sum(a:dice)
  endif
endfunction

function! Sum(values) abort
    let l:sum = 0
    for l:value in a:values
        let l:sum += l:value
    endfor

    return l:sum
endfunction
