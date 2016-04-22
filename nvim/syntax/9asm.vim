" Vim syntax file
" Language:     Plan 9 Assembler
" Maintainer:   Ross Light <ross@zombiezen.com>

if exists("b:current_syntax")
    finish
endif

syn case ignore

syn match asmLabel		    /[a-z_][a-z0-9_]*:/he=e-1
syn match asmIdentifier		    /[a-z_][a-z0-9_]*/

syn match 9asmDecConstant           /\$[0-9]\+/
syn match 9asmOctConstant           /\$0[0-7]\+/
syn match 9asmHexConstant           /\$0[xX][0-9a-fA-F]\+/
syn match 9asmFloatConstant         /\$[0-9]\+\.[0-9]*/

syn match 9asmOffset                /+-\?[0-9]\+/

syn region 9asmComment              start="/\*" end="\*/"
syn match 9asmComment               "//.*"
syn keyword 9asmSpecialRegisters    FP SP TOS SB PC

syn keyword 9asmDirective           LONG WORD DATA GLOBAL DYNT INIT TEXT

syn region 9asmLiteral              start=/\$(/ end=/)/

hi def link 9asmComment             Comment
hi def link 9asmDecConstant         Number
hi def link 9asmOctConstant         Number
hi def link 9asmHexConstant         Number
hi def link 9asmFloatConstant       Number
hi def link 9asmLiteral             Number
hi def link 9asmOffset              Number
hi def link 9asmLabel               Label
hi def link 9asmIdentifier          Identifier
hi def link 9asmDirective           Statement
hi def link 9asmSpecialRegisters    Keyword

let b:current_syntax = "9asm"
