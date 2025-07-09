function! FindFewestCoins(coins, target_balance) abort
  if a:target_balance < 0
    throw "target can't be negative"
  endif

  if a:target_balance == 0
    return []
  endif

  let l:available_coins = sort(a:coins, {a, b -> b - a})

  let l:queue = [0]
  let l:visited = {0: []}

  while !empty(l:queue)
    let l:starting_balance = remove(l:queue, 0)

    for l:coin in l:available_coins
      let l:updated_balance = l:starting_balance + l:coin

      if l:updated_balance > a:target_balance || has_key(l:visited, l:updated_balance)
        continue
      endif

      let l:used_coins = copy(l:visited[l:starting_balance])
      call add(l:used_coins, l:coin)
      call sort(l:used_coins, {a, b -> b - a})

      if l:updated_balance == a:target_balance
        return sort(l:used_coins, 'n')
      endif

      let l:visited[l:updated_balance] = l:used_coins

      call add(l:queue, l:updated_balance)
    endfor
  endwhile

  throw "can't make target with given coins"
endfunction
