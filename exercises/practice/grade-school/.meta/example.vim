function! GradeSchool() abort
  return {
    \ 'values': {},
    \ 'Add': function('s:Add'),
    \ 'Grade': function('s:Grade'),
    \ 'Roster': function('s:Roster')}
endfunction

function! s:Add(student, grade) abort dict
  if has_key(self.values, a:student)
    return v:false
  endif

  let self.values[a:student] = a:grade
  return v:true
endfunction

function! s:Grade(grade) abort dict
  let l:result = []

  for l:item in items(self.values)
    if l:item[1] == a:grade
      call add(l:result, l:item[0])
    endif
  endfor

  let l:sorted = sort(l:result)
  return l:sorted
endfunction

function! s:Roster() abort dict
  let l:result = []

  let l:grades = sort(s:Unique(values(self.values)))
  for l:grade in l:grades
    call extend(l:result, self.Grade(l:grade))
  endfor

  return l:result
endfunction

function s:Unique(list) abort
  let l:result = []
  for l:item in a:list
    if index(l:result, l:item) == -1
      call add(l:result, l:item)
    endif
  endfor

  return l:result
endfunction
