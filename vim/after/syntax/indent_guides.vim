function! IndentGuides()
    let position = range(&tabstop + 1, &textwidth > 0 ? &textwidth : 80, &tabstop)
    call map(position, '"\\%" . v:val . "v"')
    let pattern = '\%(\_^.*  \+\)\@<=\%(' . join(position, '\|') . '\) '
    execute 'syntax match Normal "' . pattern . '" conceal cchar=│'
endfunction

call IndentGuides()
