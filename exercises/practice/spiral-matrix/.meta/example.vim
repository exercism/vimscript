function! SpiralMatrix(n)
    if a:n == 0
        return []
    endif
    
    let l:matrix = repeat([0], a:n * a:n)
    let l:currentX = 0
    let l:stopX = a:n - 1
    let l:currentY = 0
    let l:stopY = a:n - 1

    let l:currentNumber = 1

    while l:currentX < l:stopX && l:currentY < l:stopY
        for l:i in range(l:currentX, l:stopX)
            let l:matrix[l:currentY * a:n + l:i] = l:currentNumber
            let l:currentNumber += 1
        endfor
        let l:currentY += 1

        for l:i in range(l:currentY, l:stopY)
            let l:matrix[l:i * a:n + l:stopX] = l:currentNumber
            let l:currentNumber += 1
        endfor
        let l:stopX -= 1

        if l:currentY == l:stopY
            break
        endif

        for l:i in range(l:stopX, l:currentX, -1)
            let l:matrix[l:stopY * a:n + l:i] = l:currentNumber
            let l:currentNumber += 1
        endfor
        let l:stopY -= 1

        for l:i in range(l:stopY, l:currentY, -1)
            let l:matrix[l:i * a:n + l:currentX] = l:currentNumber
            let l:currentNumber += 1
        endfor
        let l:currentX += 1
    endwhile

    let l:matrix[l:currentY * a:n + l:currentX] = l:currentNumber

    let l:results = []
    for l:i in range(0, len(l:matrix) - 1, a:n)
        call add(l:results, l:matrix[l:i:l:i + a:n - 1])
    endfor

    return l:results
endfunction

