function! Score(x, y) abort
    let l:distance = sqrt(pow(a:x, 2) + pow(a:y, 2))

    if l:distance <= 1
        return 10
    elseif l:distance <= 5
        return 5
    elseif l:distance <= 10
        return 1
    else
        return 0
    endif
endfunction
