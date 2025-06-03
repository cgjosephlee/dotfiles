-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<cr>")
  vim.keymap.set({ "n", "x" }, "<leader>cr", "<cmd>lua require('vscode').action('editor.action.rename')<cr>")
  vim.keymap.set("n", "<leader>cf", "<cmd>lua require('vscode').action('editor.action.formatDocument')<cr>")
  vim.keymap.set("n", "<leader>co", "<cmd>lua require('vscode').action('editor.action.organizeImports')<cr>")
  vim.keymap.set("n", "<leader>cR", "<cmd>lua require('vscode').action('renameFile')<cr>")
  vim.keymap.set({ "n", "x" }, "gK", "<cmd>lua require('vscode').action('editor.action.showHover')<cr>")
  -- vim.keymap.set({ "n", "x" }, "gd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<cr>")
  vim.keymap.set({ "n", "x" }, "gD", "<cmd>lua require('vscode').action('editor.action.revealDeclaration')<cr>")
  vim.keymap.set({ "n", "x" }, "gy", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<cr>")
  vim.keymap.set({ "n", "x" }, "gI", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<cr>")
  vim.keymap.set({ "n", "x" }, "gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<cr>")
  vim.keymap.set({ "n", "x" }, "<C-w>gd", "<cmd>lua require('vscode').action('editor.action.peekDefinition')<cr>")
  vim.keymap.set({ "n", "x" }, "<C-w>gI", "<cmd>lua require('vscode').action('editor.action.peekImplementation')<cr>")

  vim.keymap.del({ "n", "x" }, "gh")
  vim.keymap.del({ "n", "x" }, "gH")
  vim.keymap.del({ "n", "x" }, "gf")
  vim.keymap.del({ "n", "x" }, "gF")
  vim.keymap.del({ "n", "x" }, "<C-w>gf")
  vim.keymap.del("n", "z=")
end
