-- Configurations of additional plugins

return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "Wansmer/treesj",
    vscode = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Toggle SplitJoin" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 500,
    },
  },
}
