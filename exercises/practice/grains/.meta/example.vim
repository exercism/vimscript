" Helper function to add two numbers represented as strings
function! StringAdd(num1, num2)
    let carry = 0
    let result = ''

    " Pad the shorter number with leading zeros
    let len1 = strlen(a:num1)
    let len2 = strlen(a:num2)
    if len1 < len2
        let a:num1 = repeat('0', len2 - len1) . a:num1
    elseif len2 < len1
        let a:num2 = repeat('0', len1 - len2) . a:num2
    endif

    " Add digits from right to left
    for i in range(strlen(a:num1) - 1, 0, -1)
        let sum = str2nr(a:num1[i]) + str2nr(a:num2[i]) + carry
        let carry = sum >= 10 ? 1 : 0
        let result = string(sum % 10) . result
    endfor

    " Add the last carry if it exists
    if carry > 0
        let result = '1' . result
    endif

    return result
endfunction

" Function to calculate grains on a specific square using string manipulation
function! Square(n)
    if a:n < 1 || a:n > 64
        throw 'square must be between 1 and 64'
    endif

    " Start with 1 grain on the first square
    let grains = '1'
    for i in range(2, a:n)
        " Double the grains by adding it to itself
        let grains = StringAdd(grains, grains)
    endfor

    return grains
endfunction

" Function to calculate the total grains on the chessboard using string manipulation
function! Total()
    let total = '0'

    " Accumulate grains for each square from 1 to 64
    let grains = '1'
    for i in range(1, 64)
        let total = StringAdd(total, grains)
        " Double grains for the next square
        let grains = StringAdd(grains, grains)
    endfor

    return total
endfunction
