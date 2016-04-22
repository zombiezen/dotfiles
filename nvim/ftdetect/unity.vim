function! s:unity_pre()
    if getline(1) =~ '^\s*#\s*pragma\>'
        set ft=javascript.unity
    endif
endfunction

au BufRead *.js call s:unity_pre()
