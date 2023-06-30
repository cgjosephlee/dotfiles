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
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "<leader>A", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<leader>X", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "g<C-a>", function() return require("dial.map").inc_gnormal() end, expr = true, desc = "Increment" },
      { "g<C-x>", function() return require("dial.map").dec_gnormal() end, expr = true, desc = "Decrement" },
      { "<C-a>", function() return require("dial.map").inc_visual() end, expr = true, desc = "Increment", mode = "v" },
      { "<C-x>", function() return require("dial.map").dec_visual() end, expr = true, desc = "Decrement", mode = "v" },
      { "g<C-a>", function() return require("dial.map").inc_gvisual() end, expr = true, desc = "Increment", mode = "v" },
      { "g<C-x>", function() return require("dial.map").dec_gvisual() end, expr = true, desc = "Decrement", mode = "v" },
    },
    config = function()
      local augend = require("dial.augend")
      -- custom enums
      local bool_true_L = augend.constant.new({ elements = { "true", "false" }, preserve_case = true })
      local bool_true_U = augend.constant.new({ elements = { "TRUE", "FALSE" }, preserve_case = true })
      local bool_true_C = augend.constant.new({ elements = { "True", "False" }, preserve_case = true })
      local bool_yes_L = augend.constant.new({ elements = { "yes", "no" }, preserve_case = true })
      local reg = {
        augend.integer.alias.decimal,
        augend.semver.alias.semver,
        bool_true_L,
        bool_true_U,
        bool_true_C,
        bool_yes_L,
      }
      require("dial.config").augends:register_group({
        default = reg,
        visual = reg,
      })
    end,
  },
}
