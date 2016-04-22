syn clear javaScriptReserved
syn clear javaScriptNumber

syn region unityScriptPragma start=+^\s*#\s*pragma\>+ end="\n"
syn region unityScriptPreCondit start=+^\s*#\s*\(if\|else\|endif\)\>+ end="\n"
syn keyword unityScriptKeyword as catch class enum extends finally import private protected public static super throw try virtual yield
syn keyword unityScriptType boolean char sbyte int short long byte ushort uint ulong float double
syn region unityScriptAttribute start=+^\s*@+ end="\n" contains=javaScriptStringD,javaScriptStringS,javaScriptNumber

syn match unityScriptInt "\<\d\+\([Ee]\d+\)\?\>"
syn match unityScriptHex "\<0x\x\+\>"
syn match unityScriptOctal "\<0\o\+\>"
syn match unityScriptFloat "\<\d\+\.\d*\([Ee][-+]\d\+\)\?f\=\>"
syn match unityScriptFloat "\<\.\d\+\([Ee][-+]\d\+\)\?f\=\>"
syn match unityScriptFloat "\<\d\+[Ee][-+]\d\+f\=\>"

hi def link unityScriptPragma PreProc
hi def link unityScriptPreCondit PreCondit
hi def link unityScriptKeyword Keyword
hi def link unityScriptType Type
hi def link unityScriptAttribute PreProc
hi def link unityScriptInt Number
hi def link unityScriptHex Number
hi def link unityScriptOctal Number
hi def link unityScriptFloat Float
