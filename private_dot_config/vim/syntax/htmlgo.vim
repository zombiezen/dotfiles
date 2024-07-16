" Vim syntax file
" Language:	Go HTML template
" Maintainer:	Roxy Light <roxy@zombiezen.com>

if exists("b:current_syntax")
    finish
endif

if !exists("main_syntax")
    let main_syntax = 'html'
endif

runtime! syntax/gotemplate.vim
runtime! syntax/html.vim
unlet b:current_syntax

syn cluster gotemplateBlocks contains=gotemplateActionBlock,gotemplateComment

syn region gotemplateActionBlock start="{{" end="}}" contains=@gotemplateActionGroup display containedin=ALLBUT,@gotemplateBlocks
syn region gotemplateComment start="{{/\*" end="\*/}}" contains=gotemplateTodo,@Spell display containedin=ALLBUT,@gotemplateBlocks

let b:current_syntax = "htmlgo"
