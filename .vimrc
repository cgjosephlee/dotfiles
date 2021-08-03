call plug#begin('~/.vim/plugged')
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'itchyny/lightline.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
call plug#end()

" User define
colorscheme sublimemonokai
syntax on
" set termguicolors
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

" remap C-a and C-x (conflict with tmux prefix)
nnoremap <leader>a <C-a>
nnoremap <leader>x <C-x>

" search selected text by '//' in visual mode, also try '*' and '#'
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ }

" auto-pairs
" https://github.com/jiangmiao/auto-pairs/issues/211
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = {
    \ 'python': {'left': '#'},
    \ 'julia': {'left': '#'}}
let NERDDefaultAlign="left"

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_color_term = 0

" configs for *py
" let python_highlight_all=1
au FileType python
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    " \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
