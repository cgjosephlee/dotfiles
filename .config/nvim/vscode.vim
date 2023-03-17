call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
Plug 'qwertologe/nextval.vim'
call plug#end()

" vscode toggle comment
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" more actions
nnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
xnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>

nmap <leader>f <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>

" nextval
nmap <leader>a <Plug>nextvalInc
nmap <leader>x <Plug>nextvalDec

lua require('vscode-settings')
