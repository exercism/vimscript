function! Modifier(score) abort
    return float2nr(floor((a:score - 10) / 2.0))
endfunction

function! Ability() abort
    let l:rolls =  map(repeat([0], 4), '(rand(g:seed) % 6) + 1')
    let l:kept = sort(l:rolls)[1:]

    let l:sum = 0
    for l:dice in l:kept
        let l:sum += l:dice
    endfor

    return l:sum
endfunction

function! Character() abort
    let l:constitution = Ability()
    return {'strength': Ability(), 
    \       'dexterity': Ability(),
    \       'constitution': l:constitution,
    \       'intelligence': Ability(),
    \       'wisdom': Ability(),
    \       'charisma': Ability(),
    \       'hitpoints': 10 + Modifier(l:constitution)}
endfunction

let g:seed = srand()
