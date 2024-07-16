" see.vim -- Vim color file for SubEthaEdit colors
" For other Vim UI elements, I use desert. I *like* desert.
" Maintainer: Roxy Light <roxy@zombiezen.com>

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "see"

if &background == "light"
    " UI
    hi Normal               guibg=white guifg=black
    hi Cursor               guibg=black guifg=white
    hi ModeMsg              guifg=darkorange
    hi MoreMsg              guifg=SeaGreen
    hi NonText              guifg=Blue guibg=grey80
    hi Question             guifg=SeaGreen
    hi SpecialKey           guifg=yellowgreen guibg=grey30
    hi Title                guifg=firebrick
    hi Visual               guibg=#9fb9f5
    hi WarningMsg           guifg=hotpink

    hi DiffAdd              gui=none guibg=#bfe0ba
    hi DiffDelete           gui=bold guibg=#d98b9c guifg=#b3253d
    hi DiffChange           gui=none guibg=#c5cbe8
    hi DiffText             gui=bold guibg=#a8b3ed

    " Syntax
    hi String               gui=none guifg=#760f15 guibg=NONE
    hi Constant             gui=none guifg=blue guibg=NONE
    hi Statement            gui=bold guifg=#881350 guibg=NONE
    hi PreProc              gui=none guifg=#683821 guibg=NONE
    hi Comment              gui=italic guifg=#236e25 guibg=NONE
    hi helpExample          gui=none guifg=#236e25 guibg=NONE
    hi Type                 gui=none guifg=#400080 guibg=NONE
    hi Identifier           gui=none guifg=#003369 guibg=NONE
else
    " UI
    hi Normal               guibg=grey20 guifg=white
    hi Cursor               guibg=khaki guifg=slategrey
    hi ModeMsg              guifg=goldenrod
    hi MoreMsg              guifg=SeaGreen
    hi NonText              guifg=LightBlue guibg=grey30
    hi Question             guifg=springgreen
    hi SpecialKey           guifg=yellowgreen
    hi Title                guifg=indianred
    hi Visual               guibg=#0e3b82
    hi WarningMsg           guifg=salmon

    hi DiffAdd              gui=none guibg=#415c3e
    hi DiffDelete           gui=bold guibg=#753b48 guifg=#cc818d
    hi DiffChange           gui=none guibg=#3c4678
    hi DiffText             gui=bold guibg=#0f2385

    " Syntax
    hi String               gui=none guifg=#f0898f guibg=NONE
    hi Constant             gui=none guifg=#7671f5 guibg=NONE
    hi Statement            gui=bold guifg=#ec77b4 guibg=NONE
    hi PreProc              gui=none guifg=#deae97 guibg=NONE
    hi Comment              gui=italic guifg=#91dc93 guibg=NONE
    hi helpExample          gui=none guifg=#91dc93 guibg=NONE
    hi Type                 gui=none guifg=#bf7fff guibg=NONE
    hi Identifier           gui=none guifg=#96c9ff guibg=NONE
endif

" COMMON
" UI
hi LineNr               gui=none guifg=grey40 guibg=grey90
hi! link VertSplit      StatusLineNC
hi StatusLine           gui=none guibg=#c2bfa5 guifg=black
hi StatusLineNC         gui=none guibg=#c2bfa5 guifg=grey50

hi Folded               guibg=grey50 guifg=gold
hi FoldColumn           guibg=grey50 guifg=grey10

hi Search               guibg=peru guifg=wheat
hi IncSearch            guifg=slategrey guibg=khaki

"hi CursorIM
"hi Directory
"hi ErrorMsg
"hi VisualNOS
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" Syntax
hi link Number          Constant
hi link Float           Constant
hi link Character       Constant
hi link Boolean         Keyword

hi link Conditional     Statement
hi link Repeat          Statement
hi link Label           Statement
hi link Operator        Statement
hi link Keyword         Statement
hi link Exception       Statement

hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc

hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type

hi link Function        Identifier
