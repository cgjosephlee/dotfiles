call plug#begin(stdpath('data') . '/plugged')
" theme
Plug 'patstockwell/vim-monokai-tasty'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" coding utilities
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'LunarWatcher/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'hrsh7th/vim-eft'
Plug 'qwertologe/nextval.vim'
" snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'onsails/lspkind-nvim'
" python
Plug 'Vimjas/vim-python-pep8-indent'
" other lang
Plug 'burneyy/vim-snakemake'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

" {{{ vim configs

colorscheme vim-monokai-tasty
syntax on
if has('termguicolors')
    set termguicolors
elseif
    set t_Co=256
endif
set encoding=utf-8
set splitbelow
set splitright
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set confirm
set ignorecase
set hlsearch
set incsearch
set mouse=a
set noshowmode
set completeopt=menu,menuone,noselect
set nofoldenable
set foldmarker={{{,}}}
set foldmethod=marker
set foldlevel=0
set foldnestmax=3 

" search selected text by '//' in visual mode, also try '*' and '#'
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" configs for *py
au FileType python
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    " \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" }}}

" {{{ plugin configs

" nextval
nmap <leader>a <Plug>nextvalInc
nmap <leader>x <Plug>nextvalDec

" nerdcommenter
" https://github.com/preservim/nerdcommenter/issues/202
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = {
    \ 'python': {'left': '#'},
    \ 'julia': {'left': '#'}
    \ }
let NERDDefaultAlign="left"

" indentLine
let g:indentLine_enabled=1
let g:indentLine_color_term=0

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

" vsnip
imap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)': '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)': '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<C-k>'

" }}}

" load init.lua
:lua require('init')
