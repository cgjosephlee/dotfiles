call plug#begin('~/.vim/plugged')
" Plug 'vim-scripts/indentpython.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'jpalardy/vim-slime'
Plug 'burneyy/vim-snakemake'
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

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E309,E501,E302,E305'
" let g:syntastic_python_python_exec = 'python3'
highlight SyntasticError ctermbg=lightmagenta ctermfg=black
highlight SyntasticWarning ctermbg=lightyellow ctermfg=black

" YCM
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_global_extra_conf.py'
nnoremap <leader>yd :YcmCompleter GetDoc<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>

" last status
set laststatus=2
" set statusline=%4*%<\ %1*[%F] " file path
" set statusline+=%4*\ %5*[%{&encoding}, " encoding
" set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
" set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
highlight User1 ctermfg=red
highlight User2 ctermfg=green
highlight User3 ctermfg=yellow
highlight User4 ctermfg=white
highlight BadWhitespace ctermbg=red guibg=darkred

" vim-airline
set noshowmode
set ttimeoutlen=10
" let g:airline_powerline_fonts = 1

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
let NERDDefaultAlign="left"

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_color_term = 0

" vim-slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": ".2"}

" configs for *py
" let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    " \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
