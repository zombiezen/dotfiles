" Vim syntax file
" Language:   mercurial commit file
" Maintainer: Ross Light <ross@zombiezen.com>
" Filenames:  hg-editor-*

" Influenced heavily by gitcommit.vim

if exists("b:current_syntax")
    finish
endif

syn case match
syn sync minlines=50

if has("spell")
    syn spell toplevel
endif

syn match hgcommitFirstLine "\%^.*"
syn match hgcommitSummary "^.\{0,50\}" contained containedin=hgcommitFirstLine nextgroup=hgcommitOverflow contains=@Spell
syn match hgcommitOverflow ".*" contained contains=@Spell
syn match hgcommitComment "^HG:.*"
syn region hgcommitUser start=/user:\s*/ end=/$/ keepend oneline contained containedin=hgcommitComment transparent
syn match hgcommitOnBranch /branch\s\+/ contained containedin=hgcommitComment nextgroup=hgcommitBranch transparent
syn match hgcommitBranch /'[^ \t']\+'/hs=s+1,he=e-1 contained

syn match hgcommitAdded /added\s\+/ contained containedin=hgcommitComment nextgroup=hgcommitAddedFiles transparent
syn region hgcommitAddedFiles start=// end=/$/ contained contains=hgcommitAddedFile oneline transparent
syn match hgcommitAddedFile "\S\+" contained

syn match hgcommitChanged /changed\s\+/ contained containedin=hgcommitComment nextgroup=hgcommitChangedFiles transparent
syn region hgcommitChangedFiles start=// end=/$/ contained contains=hgcommitChangedFile oneline transparent
syn match hgcommitChangedFile "\S\+" contained

syn match hgcommitRemoved /removed\s\+/ contained containedin=hgcommitComment nextgroup=hgcommitRemovedFiles transparent
syn region hgcommitRemovedFiles start=// end=/$/ contained contains=hgcommitRemovedFile oneline transparent
syn match hgcommitRemovedFile "\S\+" contained

hi def link hgcommitSummary Keyword
hi def link hgcommitComment Comment
hi def link hgcommitBranch Special
hi def link hgcommitAddedFile DiffAdd
hi def link hgcommitChangedFile DiffChange
hi def link hgcommitRemovedFile DiffDelete

let b:current_syntax = "hgcommit"
