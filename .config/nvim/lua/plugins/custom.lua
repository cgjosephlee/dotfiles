-- Configurations of additional plugins

return {
  {
    "HiPhish/nvim-ts-rainbow2",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "HiPhish/nvim-ts-rainbow2" },
    opts = function(_, opts)
      opts.rainbow = {
        enable = true,
        query = "rainbow-parens",
        strategy = require("ts-rainbow").strategy.global,
      }
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>cJ", "<cmd>TSJToggle<cr>", desc = "Toggle SplitJoin" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 500,
    },
  },
  {
    "cgjosephlee/boole.nvim",
    branch = "issue-27",
    keys = {
      { "<C-a>", "<cmd>Boole increment<cr>" },
      { "<C-x>", "<cmd>Boole decrement<cr>" },
    },
    opts = {
      mappings = {},
      allow_caps_additions = {
        {
          "i",
          "ii",
          "iii",
          "iv",
          "v",
          "vi",
          "vii",
          "viii",
          "ix",
          "x",
          "xi",
          "xii",
          "xiii",
          "xiv",
          "xv",
          "xvi",
          "xvii",
          "xviii",
          "xix",
          "xx",
        },
      },
    },
  },
}
