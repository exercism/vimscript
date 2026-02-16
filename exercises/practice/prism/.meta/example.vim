function! FindSequence(prisms, start) abort
  let l:sequence = []
  let l:x = a:start.x + 0.0
  let l:y = a:start.y + 0.0
  let l:angle = a:start.angle + 0.0
  let l:pi = acos(-1.0)
  
  while 1
    let l:rad = l:angle * l:pi / 180.0
    let l:dirX = cos(l:rad)
    let l:dirY = sin(l:rad)
    
    let l:nearest = {}
    let l:nearestDist = 1.0 / 0.0
    let l:found = 0

    for l:prism in a:prisms
      let l:dx = l:prism.x - l:x
      let l:dy = l:prism.y - l:y

      " how far along the ray is the prism?
      let l:dist = l:dx * l:dirX + l:dy * l:dirY
      
      " ignore prisms behind us
      if l:dist <= 1.0e-6
        continue
      endif

      " how far off center is the prism?  
      let l:crossX = l:dx - l:dist * l:dirX
      let l:crossY = l:dy - l:dist * l:dirY
      let l:crossSq = l:crossX * l:crossX + l:crossY * l:crossY
      
      " bail if outside relative tolerance (scale by distance)
      let l:scale = 1.0
      if (l:dist * l:dist) > 1.0
        let l:scale = l:dist * l:dist
      endif
      if l:crossSq >= 1.0e-6 * l:scale
        continue
      endif
      
      if l:dist < l:nearestDist
        let l:nearestDist = l:dist
        let l:nearest = l:prism
        let l:found = 1
      endif
    endfor
    
    if !l:found
      break
    endif
    
    call add(l:sequence, l:nearest.id)
    let l:x = l:nearest.x
    let l:y = l:nearest.y
    let l:angle = fmod(l:angle + l:nearest.angle, 360.0)
    
  endwhile

  return {'sequence': l:sequence}
endfunction
