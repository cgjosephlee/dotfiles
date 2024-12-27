-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<cr>")
  vim.keymap.set({ "n", "x" }, "<leader>cr", "<cmd>lua require('vscode').action('editor.action.rename')<cr>")
  vim.keymap.set("n", "<leader>cf", "<cmd>lua require('vscode').action('editor.action.formatDocument')<cr>")
  vim.keymap.set("n", "<leader>co", "<cmd>lua require('vscode').action('editor.action.organizeImports')<cr>")
end
