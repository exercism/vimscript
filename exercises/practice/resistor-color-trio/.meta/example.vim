let s:COLORS = [
\ 'black',
\ 'brown',
\ 'red',
\ 'orange',
\ 'yellow',
\ 'green',
\ 'blue',
\ 'violet',
\ 'grey',
\ 'white',
\ ]

function! Label(colors) abort
    let [l:first, l:second, l:third; l:rest] = a:colors
    let l:tens = index(s:COLORS, l:first)
    let l:ones = index(s:COLORS, l:second)
    let l:multiplier = index(s:COLORS, l:third)
    let l:value = float2nr((l:tens * 10 + l:ones) * pow(10, l:multiplier))

    if l:value < 1000
        return l:value . ' ohms'
    elseif l:value < 1000000
        return l:value / 1000 . ' kiloohms'
    elseif l:value < 1000000000
        return l:value / 1000000 . ' megaohms'
    else
        return l:value / 1000000000 . ' gigaohms'
    endif
endfunction
