" Ross's vimrc

" Disable vi compatibility (must be first since it sets other options)
set nocompatible

" XDG directory support
if strlen($XDG_CONFIG_HOME) == 0
  let $XDG_CONFIG_HOME = expand('$HOME') . '/.config'
endif
if strlen($XDG_CACHE_HOME) == 0
  let $XDG_CACHE_HOME = expand('$HOME') . '/.cache'
endif
set undodir=$XDG_CACHE_HOME/vim/undo
set directory=$XDG_CACHE_HOME/vim/swap
set backupdir=$XDG_CACHE_HOME/vim/backup
set viminfo='100,<50,s10,h,n$XDG_CACHE_HOME/vim/viminfo
set runtimepath=$HOME/dotfiles/vim,$HOME/vim-addons/vim-addon-manager,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/dotfiles/vim/after

" Load vim-addon-manager
function! s:InitAddons()
    call vam#ActivateAddons([
\       'Gundo',
\       'SWIG_syntax',
\       'UltiSnips',
\       'github:altercation/vim-colors-solarized',
\       'github:dart-lang/dart-vim-plugin',
\       'github:ervandew/supertab',
\       'github:lesliev/vim-inform7',
\       'github:puppetlabs/puppet-syntax-vim',
\       'github:zombiezen/vim-capnp',
\       'rust',
\       'scss-syntax',
\       'vim-go',
\       ], {'auto_install': 0})
endfunction

if !exists('vimrc_addons_inited')
    let vimrc_addons_inited = 1
    call s:InitAddons()
endif

" Enable file types/syntax highlighting
filetype plugin indent on
if has("syntax")
    syntax on
endif
set background=dark

" Solarized
let g:solarized_termtrans=1
colorscheme solarized

" Interface options
set modeline& modelines&    " allow modelines
set ruler                   " show cursor position
set laststatus=2            " always show status bar
set showcmd                 " display modifiers before a command
set backspace=indent,start  " what backspace can delete in insert mode
set nojoinspaces            " only use one space after period when joining lines
set nrformats=hex,alpha     " what CTRL-A/CTRL-X allows you to change
set gdefault                " use /g option by default in :s
set scrolloff=2             " number of lines to keep on screen around cursor
set completeopt=menu        " only show completion menu, don't show preview window

if has("mouse")
  set mouse=a               " enable mouse support
endif

if has("statusline")
    function! StatusWinnum()
        if winnr("$") == 1
            return ""
        else
            return "(" . winnr() . ") "
        endif
    endfunction
    function! StatusTabMode()
        if &expandtab
            return ""
        else
            return "[tab]"
        endif
    endfunction

    set statusline=%{StatusWinnum()}%<%f    " (N) filename
    set statusline+=\ %m%h%r%=              " [+][help][RO]
    set statusline+=%y                      " [filetype]
    set statusline+=\ %-10.([%{&sts},%{&ts}]%{StatusTabMode()}%)    " [ts,sts][tab]
    set statusline+=\ %-10.(%l,%c%V%)       " LINE,COLUMN-VIRTUALCOLUMN
    if exists("*strftime")
        set statusline+=\ %-6.{strftime('%H:%M')}   " Current time
    endif
endif

" Highlight searches, but hide quickly using \n.
set hlsearch
nnoremap <leader>n :noh<CR>

" Choose what should be saved during :mks
set sessionoptions=blank,buffers,curdir,folds,help,options,resize,tabpages,winsize

" Ex command-line completion
set wildmode=longest,full
set wildmenu

" Keymaps
nnoremap Y y$
nnoremap K <Nop>

cabbr <expr> %% expand('%:h')
cabbr vrc ~/dotfiles/vim/init.vim

" Common indentation modes
" Sets the indentation options to common settings.
" Usage: :Tabs 8
"        :Spaces 3
"        :Tabs      " same as Tabs 8
"        :Spaces    " same as Spaces 4
command! -bar -count=8 Tabs set ts=<count> sts=0 sw=<count> noet
command! -bar -count=4 Spaces set ts=8 sts=<count> sw=<count> et

" Command to replace carriage returns with newlines.
" Usage: :Cr        " for the whole file
"        :1,10Cr    " for a range
command! -bar -nargs=0 -range=% Cr <line1>,<line2>s///

" Run a command and put output in new buffer
command! -nargs=+ -complete=file Run call s:OutputBuffer(<q-args>)
function! s:OutputBuffer(line)
    new
    setlocal bt=nofile bufhidden=wipe nobuflisted noswapfile nonu
    execute '$read !'.a:line
    silent execute 'file '.escape(a:line, ' \')
    1delete _
    filetype detect
endfunction

" Indentation
set autoindent
Spaces 2 " Default to 2-space indents

" Wrapping
set wrap
set linebreak
let &showbreak='  '

" Gutter
" set number
set numberwidth=3
" set foldcolumn=3
" set relativenumber
" set colorcolumn=+0,80

" Python
let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

" LaTeX
let g:tex_flavor='latex'

" Bash
let g:is_bash=1

" Go
let go_highlight_trailing_whitespace_error = 0

" Haskell
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1

" Java
let java_allow_cpp_keywords = 1

" Zen Coding
let g:user_zen_leader_key = '<c-h>'
let g:user_zen_settings = {
\   'indentation' : '    '
\}

" UltiSnips
let g:snips_author = "Ross Light"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
