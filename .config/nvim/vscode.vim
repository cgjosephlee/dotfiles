call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
call plug#end()

" vscode toggle comment
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" more actions
nnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
xnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap ga <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
xnoremap ga <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>

nnoremap <leader>f <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap <leader>o <Cmd>call VSCodeNotify('editor.action.organizeImports')<CR>

" https://github.com/vscode-neovim/vscode-neovim/pull/845
function! s:gotoEditor(...) abort
    let count = a:1
    call VSCodeCall(count ? printf('workbench.action.openEditorAtIndex%d',count) : 'workbench.action.nextEditorInGroup')
endfunction
nnoremap gt <Cmd>call <SID>gotoEditor(v:count, 'next')<CR>
xnoremap gt <Cmd>call <SID>gotoEditor(v:count, 'next')<CR>

lua require('vscode-settings')
