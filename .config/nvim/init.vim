call plug#begin(stdpath('data') . '/plugged')
" theme
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" coding utilities
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'hrsh7th/vim-eft'
Plug 'qwertologe/nextval.vim'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
" python
Plug 'Vimjas/vim-python-pep8-indent'
" other lang
Plug 'burneyy/vim-snakemake'
Plug 'JuliaEditorSupport/julia-vim'
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
set noshowmode
set completeopt=menuone,noselect

" nextval
nmap <leader>a <Plug>nextvalInc
nmap <leader>x <Plug>nextvalDec

" search selected text by '//' in visual mode, also try '*' and '#'
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" auto-pairs
" https://github.com/jiangmiao/auto-pairs/issues/211
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = {
    \ 'python': {'left': '#'},
    \ 'julia': {'left': '#'}
    \ }
let NERDDefaultAlign="left"

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_color_term = 0

" vim-eft
nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)
nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)
nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)

" configs for *py
au FileType python
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    " \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" load init.lua
:lua require'init'
