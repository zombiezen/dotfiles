" hgdiff.vim -- Configure a session for Mercurial merging.
" Copyright (c) 2011 Ross Light.
"
" Usage: vim -S ~/.vim/scripts/hgdiff.vim -d $base $local $other $output

if has("gui_running")
    set co=175      " resize window
    wincmd =        " ensure split views are equal size
endif

" Output
4wincmd w
set foldmethod=diff
let tp = &filetype
wincmd J

" Base
1wincmd w
set nomodifiable foldmethod=diff
let &ft = tp

" Local
2wincmd w
set nomodifiable foldmethod=diff
let &ft = tp

" Other
3wincmd w
set nomodifiable foldmethod=diff
let &ft = tp

" Switch to output
4wincmd w
unlet tp

" vim: ft=vim et ts=8 sts=4 sw=4
