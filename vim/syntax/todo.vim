" File:         syntax/todo.vim
" Language:     To-Do List
" Maintainer:   Ross Light <ross@zombiezen.com>

if exists("b:current_syntax")
    finish
endif

syntax cluster todoMarkers contains=todoMarker,todoNotDone,todoDone
syntax match todoMarker /\[.\]/ contained
syntax match todoNotDone /\V[ ]/ contained
syntax match todoDone /\V[X]/ contained

syntax region todoItem start="^\s*\[.\]" end="$" contains=todoMarker,todoNotDone,todoDone,todoDoneText
syntax region todoDoneText start="^\s*\[X\]" end="$" contained contains=todoDone

hi todoMarker term=bold cterm=bold gui=bold
hi todoNotDone term=bold cterm=bold ctermfg=Red gui=bold guifg=Red
hi todoDone term=italic ctermfg=Green guifg=Green
hi todoDoneText term=italic cterm=italic ctermfg=Grey gui=italic guifg=Grey
