" Vim syntax file
" Language:	Go template
" Maintainer:	Ross Light <ross@zombiezen.com>

if exists("b:current_syntax")
    finish
endif

syntax case match

" Keywords
syn keyword gotemplateAction contained define end if else range template with
syn keyword gotemplateFunction contained and html index js len not or print printf println urlquery

hi def link gotemplateAction Statement
hi def link gotemplateFunction Identifier

" Operators
syn match gotemplateOperator contained ":="
syn match gotemplateOperator contained "|"

hi def link gotemplateOperator Operator

" Variables
syn match gotemplateVariable contained "\$[a-zA-Z0-9_]*"
hi def link gotemplateVariable Identifier

" Literals
syn keyword gotemplateBoolean contained true false

syn match gotemplateInt contained "\<\d\+\([Ee]\d\+\)\?\>"
syn match gotemplateInt contained "\<0x\x\+\>"
syn match gotemplateInt contained "\<0\o\+\>"

syn match gotemplateFloat contained "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match gotemplateFloat contained "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match gotemplateFloat contained "\<\d\+[Ee][-+]\d\+\>"

syn match gotemplateImaginary contained "\<\d\+i\>"
syn match gotemplateImaginary contained "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match gotemplateImaginary contained "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match gotemplateImaginary contained "\<\d\+[Ee][-+]\d\+i\>"

hi def link gotemplateBoolean Boolean
hi def link gotemplateInt Number
hi def link gotemplateFloat Float
hi def link gotemplateImaginary Number

" Character escapes
syn match gotemplateEscapeOctal display contained "\\[0-7]\{3}"
syn match gotemplateEscapeC display contained +\\[abfnrtv\\'"]+
syn match gotemplateEscapeX display contained "\\x\x\{2}"
syn match gotemplateEscapeU display contained "\\u\x\{4}"
syn match gotemplateEscapeBigU display contained "\\U\x\{8}"
syn match gotemplateEscapeError display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link gotemplateEscapeOctal gotemplateSpecialString
hi def link gotemplateEscapeC gotemplateSpecialString
hi def link gotemplateEscapeX gotemplateSpecialString
hi def link gotemplateEscapeU gotemplateSpecialString
hi def link gotemplateEscapeBigU gotemplateSpecialString
hi def link gotemplateSpecialString Special
hi def link gotemplateEscapeError Error

" Strings
syn cluster gotemplateStringGroup contains=gotemplateEscapeOctal,gotemplateEscapeC,gotemplateEscapeX,gotemplateEscapeU,gotemplateEscapeBigU,gotemplateEscapeError
syn region gotemplateString contained start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=@gotemplateStringGroup
syn region gotemplateRawString contained start=/`/ end=/`/

hi def link gotemplateString String
hi def link gotemplateRawString String

" Characters
syn cluster gotemplateCharacterGroup contains=gotemplateEscapeOctal,gotemplateEscapeC,gotemplateEscapeX,gotemplateEscapeU,gotemplateEscapeBigU
syn region gotemplateCharacter contained start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=@gotemplateCharacterGroup

hi def link gotemplateCharacter Character

" Action Block
syn cluster gotemplateActionGroup contains=gotemplateAction,gotemplateFunction,gotemplateOperator,gotemplateVariable,gotemplateBoolean,gotemplateInt,gotemplateFloat,gotemplateImaginary,gotemplateString,gotemplateRawString,gotemplateCharacter
syn region gotemplateActionBlock start="{{" end="}}" contains=@gotemplateActionGroup display

hi def link gotemplateActionBlock PreProc

" Comments
syn keyword gotemplateTodo contained TODO FIXME XXX
syn region gotemplateComment start="{{/\*" end="\*/}}" contains=gotemplateTodo,@Spell display

hi def link gotemplateTodo Todo
hi def link gotemplateComment Comment

let b:current_syntax = "gotemplate"
