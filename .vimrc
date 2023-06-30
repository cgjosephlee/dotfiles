" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" User define
colorscheme sublimemonokai
syntax on
set t_Co=256
set encoding=utf-8
set splitbelow
set splitright
set ai
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set confirm
set ic
set hlsearch
set incsearch
set mouse=a

" lightline
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'one'}

" auto-pairs
" https://github.com/jiangmiao/auto-pairs/issues/211
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

" configs for *py
" let python_highlight_all=1
au FileType python
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
