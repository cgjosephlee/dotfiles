call plug#begin(stdpath('data') . '/plugged')
" theme
Plug 'patstockwell/vim-monokai-tasty'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" coding utilities
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'Yggdroot/indentLine'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
" snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
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
call plug#end()

" {{{ vim configs

colorscheme vim-monokai-tasty
syntax on
if has('termguicolors')
    set termguicolors
else
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

" nvim-tree
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
nnoremap <leader>e <Cmd>NvimTreeToggle<CR>

"bufferline
nnoremap <leader>bn <Cmd>BufferLineCycleNext<CR>
nnoremap <leader>bb <Cmd>BufferLineCyclePrev<CR>
nnoremap <leader>bj <Cmd>BufferLinePick<CR>

" indentLine
let g:indentLine_enabled=1
let g:indentLine_color_term=0

" vsnip
imap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)': '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)': '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<C-k>'

" }}}

lua require('init')
