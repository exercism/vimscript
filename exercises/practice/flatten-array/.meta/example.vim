function! Flatten(array) abort
    let l:results = []
    for l:elem in a:array
        if type(l:elem) == v:t_list
            call extend(l:results, Flatten(l:elem))
        elseif l:elem isnot v:null
            call add(l:results, l:elem)
        endif
    endfor

    return results
endfunction
