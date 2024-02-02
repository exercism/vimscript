function! EggCount(num) abort
    let counter = 0

    let working = a:num
    while working != 0
        if working % 2
            let counter += 1
        endif

        let working /= 2
    endwhile

    return counter
endfunction
