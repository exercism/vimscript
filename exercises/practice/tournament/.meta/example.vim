let s:HEADER = 'Team                           | MP |  W |  D |  L |  P'

function! Tally(lines) abort
  if empty(a:lines)
    return [s:HEADER]
  endif

  let l:team_data = s:ProcessGameResults(a:lines)
  let l:team_standings = s:PrepareStandings(l:team_data)
  let l:rows = s:BuildTableRows(l:team_standings)

  return [s:HEADER] + l:rows
endfunction

function! s:ProcessGameResults(lines) abort
  let l:teams = {}
  for l:line in a:lines
    let [l:team1, l:team2, l:result] = split(l:line, ';')

    if !has_key(l:teams, l:team1)
      let l:teams[l:team1] = {'name': l:team1, 'W': 0, 'D': 0, 'L': 0}
    endif

    if !has_key(l:teams, l:team2)
      let l:teams[l:team2] = {'name': l:team2, 'W': 0, 'D': 0, 'L': 0}
    endif

    if l:result ==? 'win'
      let l:teams[l:team1]['W'] += 1
      let l:teams[l:team2]['L'] += 1
    elseif l:result ==? 'loss'
      let l:teams[l:team1]['L'] += 1
      let l:teams[l:team2]['W'] += 1
    elseif l:result ==? 'draw'
      let l:teams[l:team1]['D'] += 1
      let l:teams[l:team2]['D'] += 1
    endif
  endfor

  return l:teams
endfunction

function! s:PrepareStandings(teams) abort
  let l:standings = []
  for l:team in keys(a:teams)
    let l:team_data = a:teams[l:team]
    let l:team_data['MP'] = l:team_data['W'] + l:team_data['D'] + l:team_data['L']
    let l:team_data['P'] = l:team_data['W'] * 3 + l:team_data['D']
    call add(l:standings, l:team_data)
  endfor

  call sort(l:standings, 's:SortTeams')

  return l:standings
endfunction

function! s:BuildTableRows(teams) abort
  let l:rows = []
  for l:team_data in a:teams
    let l:row = printf('%-30s | %2d | %2d | %2d | %2d | %2d',
                      \ l:team_data['name'],
                      \ l:team_data['MP'],
                      \ l:team_data['W'],
                      \ l:team_data['D'],
                      \ l:team_data['L'],
                      \ l:team_data['P'])
    call add(l:rows, l:row)
  endfor

  return l:rows
endfunction

function! s:SortTeams(teamA, teamB) abort
  if a:teamA['P'] ==? a:teamB['P']
    return a:teamA['name'] > a:teamB['name']
  endif

  return a:teamA['P'] < a:teamB['P']
endfunction
