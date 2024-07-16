" Roxy's Java import plugin
" Based on Go's Import/Drop commands

" Register commands (local to buffer)
command! -buffer -nargs=1 -bar -complete=customlist,s:CompleteImport Import call s:SwitchImport(1, <f-args>)
command! -buffer -nargs=1 -bar -complete=customlist,s:CompleteDrop Drop call s:SwitchImport(0, <f-args>)

" s:SwitchImport -- enable/disable an import
function! s:SwitchImport(enabled, name)
    let view = winsaveview()
    let name = a:name

    let packageline = -1
    let appendline = -1
    let deleteline = -1
    let linesdelta = 0

    let line = 0
    while line <= line('$')
        let linestr = getline(line)

        if linestr =~# '^package\s'
            let packageline = line
            let appendline = line
        elseif linestr =~# '^import\s'
            if appendline == packageline
                let appendline = line - 1
            endif

            let m = matchlist(linestr, '^import\%(\s\+\)\([^;]\+\);')
            if !empty(m)
                if m[1] == name
                    let appendline = -1
                    let deleteline = line
                    break
                elseif m[1] < name
                    let appendline = line
                endif
            endif
        elseif linestr =~# '^\%(public\|protected\|private\|class\)'
            break
        endif
        let line = line + 1
    endwhile

    " Append or remove the package import, as requested.
    if a:enabled
        if deleteline == -1     " only add if not already imported
            if appendline == packageline
                call append(appendline + 0, '') " no-op for the -1 case
                let appendline += 1
                let linesdelta += 1
            endif
            call append(appendline, 'import ' . name . ';')
            let linesdelta += 1
        endif
    else
        if deleteline == -1
            call s:Error(name . ' not being imported')
        else
            execute deleteline 'd'
            let linesdelta -= 1
            " delete leading blank space
            if getline(deleteline) == '' && getline(deleteline - 1) == ''
                execute deleteline 'd'
                let linesdelta -= 1
            endif
        endif
    endif

    " Restore view (adjusting for changes)
    let view.lnum += linesdelta
    let view.topline += linesdelta
    if view.topline < 0
        let view.topline = 0
    endif
    call winrestview(view)
endfunction

" s:CompleteImport -- return list of completions for Import command
" Completions are packages of already imported classes, followed by a dot.
function! s:CompleteImport(lead, line, pos)
    let prefixes = filter(map(s:GetImports(), 's:PackageName(v:val) . "."'), '!empty(v:val)')
    return s:Unique(sort(filter(prefixes, 's:HasPrefix(v:val, a:lead)')))
endfunction

" s:CompleteDrop -- return list of completions for Drop command
" Completions are existing imports.
function! s:CompleteDrop(lead, line, pos)
    return s:Unique(sort(filter(s:GetImports(), 's:HasPrefix(v:val, a:lead)')))
endfunction

" s:PackageName -- return the package of a class or wildcard.
" empty for the default package.
function! s:PackageName(name)
    let m = matchlist(a:name, '^\(\%(\.\|\i\)\{-1,}\)\.\%(\i\|\*\)\+$')
    if empty(m) | return '' | endif
    return m[1]
endfunction

" s:GetImports -- return a list of imported names.
function! s:GetImports()
    let imports = []
    let line = 0
    while line <= line('$')
        let linestr = getline(line)
        let m = matchlist(linestr, '^import\%(\s\+\)\([^;]\+\);')
        if !empty(m)
            call add(imports, m[1])
        elseif linestr =~# '^\%(public\|protected\|private\|class\)'
            break
        endif
        let line = line + 1
    endwhile
    return imports
endfunction

" s:Error -- display an error.
function! s:Error(s)
    echohl Error | echo a:s | echohl None
endfunction

" s:HasPrefix -- return whether a string has a prefix.
function! s:HasPrefix(s, prefix)
    return strpart(a:s, 0, strlen(a:prefix)) == a:prefix
endfunction

" s:Unique -- filter out repeated rows in lst. (assumes lst is sorted)
" Returns the list.
function! s:Unique(lst)
    let i = 1
    while i < len(a:lst)
        if a:lst[i - 1] == a:lst[i]
            call remove(a:lst, i)
        else
            let i = i + 1
        end
    endwhile
    return a:lst
endfunction
