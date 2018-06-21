set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'ErichDonGubler/vim-sublime-monokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" User difine
syntax on
colorscheme sublimemonokai
" set termguicolors
set t_Co=256
set encoding=utf-8
set splitbelow
set splitright
set ai
set tabstop=4
set expandtab
set nu
set confirm
set ic
set hlsearch
set incsearch
set mouse=a
let python_highlight_all=1
let g:syntastic_python_python_exec = 'python3'

" last status
set laststatus=2
set statusline=%4*%<\ %1*[%F] " file path
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
highlight User1 ctermfg=red
highlight User2 ctermfg=green
highlight User3 ctermfg=yellow
highlight User4 ctermfg=white
highlight BadWhitespace ctermbg=red guibg=darkred

" hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Error /\s\+$/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    "\ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
