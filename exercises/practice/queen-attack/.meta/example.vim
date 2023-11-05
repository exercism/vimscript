function! Queen(row, column) abort
    if a:row < 0
        throw 'row not positive'
    elseif a:column < 0
        throw 'column not positive'
    elseif a:row > 7
        throw 'row not on board'
    elseif a:column > 7
        throw 'column not on board'
    endif

    return {'row': a:row, 'column': a:column, 'CanAttack': function('DoCanAttack')}
endfunction

function! DoCanAttack(other) dict
    return self.row == a:other.row ||
    \ self.column == a:other.column ||
    \ (abs(a:other.column - self.column) == abs(a:other.row - self.row))
endfunction