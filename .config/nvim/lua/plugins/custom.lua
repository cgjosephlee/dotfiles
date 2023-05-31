-- Configurations of additional plugins

return {
  {
    "mrjones2014/nvim-ts-rainbow",
    lazy = true,
  },
  {
    "nvim-treesitter",
    dependencies = { "mrjones2014/nvim-ts-rainbow" },
    opts = {
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
    },
  },
}
