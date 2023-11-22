function! Set(values) abort
  let l:data = {}
  for l:value in a:values
    let l:data[l:value] = 1
  endfor

  return {'values': l:data, 
  \       'Add': function('CustomSetAdd'),
  \       'Contains': function('CustomSetContains'),
  \       'Intersection': function('CustomSetIntersection'),
  \       'Difference': function('CustomSetDifference'),
  \       'Union': function('CustomSetUnion'),
  \       'IsDisjoint': function('CustomSetIsDisjoint'),
  \       'IsSubset': function('CustomSetIsSubset'),
  \       'IsEmpty': function('CustomSetIsEmpty')}
endfunction

function! CustomSetAdd(value) abort dict
  if !self.Contains(a:value)
    let self.values[a:value] = 1
  endif
endfunction

function! CustomSetContains(value) abort dict
  return has_key(self.values, a:value)
endfunction

function! CustomSetIsEmpty() abort dict
  return len(self.values) == 0
endfunction

function! CustomSetIsDisjoint(other) abort dict
  return len(self.Intersection(a:other).values) == 0
endfunction

function! CustomSetIsSubset(other) abort dict
  return self.Intersection(a:other) == self
endfunction

function! CustomSetIntersection(other) abort dict
  let l:intersect = Set([])
  for l:value in keys(self.values) + keys(a:other.values)
    if self.Contains(l:value) && a:other.Contains(l:value)
      call l:intersect.Add(l:value)
    endif
  endfor

  return l:intersect
endfunction

function! CustomSetDifference(other) abort dict
  let l:difference = Set([])

  for l:value in keys(self.values)
    if !a:other.Contains(l:value)
      call l:difference.Add(l:value)
    endif
  endfor

  return l:difference
endfunction

function! CustomSetUnion(other) abort dict
  let l:union = Set([])
  for l:value in keys(self.values) + keys(a:other.values)
    call l:union.Add(l:value)
  endfor

  return l:union
endfunction
