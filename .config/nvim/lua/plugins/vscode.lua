-- Configurations when using vscode-neovim.
-- Modified from https://github.com/LazyVim/LazyVim/raw/main/lua/lazyvim/plugins/extras/vscode.lua

if not vim.g.vscode then
  return {}
end

local enabled = {
  "lazy.nvim",
  "flit.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  -- "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "nvim-ts-rainbow2", -- not used but required for loading treesitter
  "vim-repeat",
  "dial.nvim",
  "LazyVim",
}

local Config = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false

-- HACK: disable all plugins except the ones we want
local fix_disabled = Plugin.Spec.fix_disabled
function Plugin.Spec.fix_disabled(self)
  for _, plugin in pairs(self.plugins) do
    if not (vim.tbl_contains(enabled, plugin.name) or plugin.vscode) then
      plugin.enabled = false
    end
  end
  fix_disabled(self)
end

-- HACK: don't clean plugins in vscode
local update_state = Plugin.update_state
function Plugin.update_state()
  update_state()
  Config.to_clean = {}
end

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set("n", "H", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>")
    vim.keymap.set("n", "L", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>")
    vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>call VSCodeNotify('editor.action.quickFix')<cr>")
    vim.keymap.set({ "n", "x" }, "<leader>cr", "<cmd>call VSCodeNotify('editor.action.rename')<cr>")
    vim.keymap.set("n", "<leader>cf", "<cmd>call VSCodeNotify('editor.action.formatDocument')<cr>")
    vim.keymap.set("n", "<leader>co", "<cmd>call VSCodeNotify('editor.action.organizeImports')<cr>")
    vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
    -- vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
    -- vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
  end,
})

return {
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false }, rainbow = { enable = false } },
  },
}
