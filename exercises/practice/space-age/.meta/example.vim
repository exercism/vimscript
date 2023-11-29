let s:SecondsInEarthYear = 31557600.0

let s:OrbitalRatios = {
    \ 'Mercury':    0.2408467,
    \ 'Venus':      0.61519726,
    \ 'Earth':      1,
    \ 'Mars':       1.8808158,
    \ 'Jupiter':    11.862615,
    \ 'Saturn':     29.447498,
    \ 'Uranus':     84.016846,
    \ 'Neptune':    164.79132
    \ }

function! Age(planet, seconds) abort
    if !has_key(s:OrbitalRatios, a:planet)
        throw 'not a planet'
    endif

    let l:years = a:seconds / s:SecondsInEarthYear
    let l:ratio = get(s:OrbitalRatios, a:planet)
    return l:years / l:ratio
endfunction
