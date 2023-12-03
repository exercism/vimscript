function! SimpleLinkedList(values) abort
  let l:list = {'head': v:null,
  \       'Head': function('s:Head'), 
  \       'length': 0,
  \       'Length': function('s:Length'),
  \       'Push': function('s:Push'),
  \       'Pop': function('s:Pop'),
  \       'AsList': function('s:AsList'),
  \       'Reversed': function('s:Reversed')}

  for l:value in a:values
    call l:list.Push(l:value)
  endfor

  return l:list
endfunction

function! s:Length() dict
  return self.length
endfunction

function! s:Head() dict
  if self.head is v:null
    throw 'The list is empty'
  endif

  return self.head
endfunction

function! s:Push(value) dict
  let l:node = Node(a:value)
  let l:node.next = self.head
  let self.head = l:node
  let self.length += 1
endfunction

function! s:Pop() dict
  let l:node = self.Head()
  let self.head = self.Head().Next()
  let self.length -= 1

  return l:node.Value()
endfunction

function! s:AsList() dict
  let l:result = []
  let l:current = self.head
  while l:current isnot v:null
    call add(l:result, l:current.value)
    let l:current = l:current.Next()
  endwhile

  return l:result
endfunction

function! s:Reversed() dict
  return SimpleLinkedList(self.AsList())
endfunction

function! Node(value) abort
  return {'value': a:value, 
  \       'Value': function('s:NodeValue'),
  \       'next': v:null,
  \       'Next': function('s:NodeNext')}
endfunction

function s:NodeValue() dict
  return self.value
endfunction

function s:NodeNext() dict
  return self.next
endfunction
