function! TwoBucket(input) abort
  if !s:validate(a:input)
    throw "impossible"
  endif
  let twoBucket = s:initialize(a:input)

  function twoBucket.Measure() abort
    let moves = 0

    call s:fill(self.start)
    let moves += 1

    if self.other.size == self.goal
      call s:fill(self.other)
      let moves += 1
    endif

    while 1
      if self.start.amount == self.goal
        return s:result(moves, self.start, self.other)
      endif
      if self.other.amount == self.goal
        return s:result(moves, self.other, self.start)
      endif

      if     s:isEmpty(self.start) | call s:fill(self.start)
      elseif s:isFull(self.other)  | call s:empty(self.other)
      else                         | call s:pour(self.start, self.other)
      endif

      let moves += 1
    endwhile
  endfunction

  return twoBucket
endfunction

function! s:result(moves, winner, loser) abort
  return #{moves: a:moves, goalBucket: a:winner.name, otherBucket: a:loser.amount}
endfunction

function! s:isFull(bucket) abort
  return a:bucket.amount == a:bucket.size
endfunction

function! s:isEmpty(bucket) abort
  return a:bucket.amount == 0
endfunction

function! s:fill(bucket) abort
  let a:bucket.amount = a:bucket.size
endfunction

function! s:empty(bucket) abort
  let a:bucket.amount = 0
endfunction

function! s:pour(from, to) abort
  let quantity = min([a:from.amount, a:to.size - a:to.amount])
  let a:from.amount -= quantity
  let a:to.amount += quantity
endfunction

function! s:GCD(...)
  if a:2 == 0 | return a:1 | endif
  return s:GCD(a:2, a:1 % a:2)
endfunction

function! s:validate(input) abort
  if a:input.goal > max([a:input.bucketOne, a:input.bucketTwo])
    return 0
  endif
  let gcd = s:GCD(a:input.bucketOne, a:input.bucketTwo)
  return gcd == 1 || a:input.goal % gcd == 0
endfunction

function! s:initialize(input) abort
  let [b1, b2] = [
                \ #{name: 'one', size: a:input.bucketOne, amount: 0},
                \ #{name: 'two', size: a:input.bucketTwo, amount: 0},
                \ ]
  if a:input.startBucket == 'two'
    let [b1, b2] = [b2, b1]
  endif
  return #{goal: a:input.goal, start: b1, other: b2}
endfunction
