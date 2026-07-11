function! Data(treeData) abort
  if empty(a:treeData)
    return v:null
  endif

  let l:tree = s:Node(a:treeData[0])
  for l:value in a:treeData[1:]
    let l:tree = s:Insert(l:tree, l:value)
  endfor

  return l:tree
endfunction

function! SortedData(treeData) abort
  return s:InOrder(Data(a:treeData))
endfunction

function! s:Insert(tree, value) abort
  if a:tree is v:null
    return s:Node(a:value)
  endif

  if a:value <=# a:tree.data
    let a:tree.left = s:Insert(a:tree.left, a:value)
  else
    let a:tree.right = s:Insert(a:tree.right, a:value)
  endif

  return a:tree
endfunction

function! s:Node(value) abort
  return {'data': a:value, 'left': v:null, 'right': v:null}
endfunction

function! s:InOrder(tree) abort
  if a:tree is v:null
    return []
  endif

  return s:InOrder(a:tree.left) + [a:tree.data] + s:InOrder(a:tree.right)
endfunction
