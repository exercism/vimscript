"
" Returns a dictionary representing a circular buffer with a set capacity
"
function! CircularBuffer(capacity) abort
  return {
  \  'capacity': a:capacity,
  \  'size': 0,
  \  'data': repeat([v:null], a:capacity),
  \  'readIndex': 0,
  \  'writeIndex': 0,
  \  'Read': funcref('s:Read'),
  \  'Write': funcref('s:Write'),
  \  'Overwrite': funcref('s:Overwrite'),
  \  'Clear': funcref('s:Clear')
  \  }
endfunction

function! s:Read() dict
  if self.size == 0
    throw 'Empty buffer'
  endif

  let l:value = self.data[self.readIndex]
  let self.readIndex = (self.readIndex + 1) % self.capacity
  let self.size -= 1

  return l:value
endfunction

function! s:Write(value) dict
  if self.size >= self.capacity
    throw 'Full buffer'
  endif

  let self.data[self.writeIndex] = a:value
  let self.writeIndex = (self.writeIndex + 1) % self.capacity
  let self.size += 1
endfunction

function! s:Overwrite(value) dict
  if self.size == self.capacity
    call self.Read()
  endif

  call self.Write(a:value)
endfunction

function! s:Clear() dict
  let l:capacity = len(self.data)
  let self.data = repeat([v:null], l:capacity)
  let self.readIndex = 0
  let self.writeIndex = 0
  let self.size = 0
endfunction
