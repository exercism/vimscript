function! IsIsogram(phrase) abort
    let l:seen = {}
    let l:phrase = tolower(a:phrase)
    
    for l:char in split(l:phrase, '\zs')
        let l:cp = char2nr(char)
        if (l:cp < 61 || l:cp > 123)
            continue
        endif

        if has_key(l:seen, l:char)
            return 0
        endif

        let l:seen[l:char] = 1
    endfor

    return 1
endfunction
