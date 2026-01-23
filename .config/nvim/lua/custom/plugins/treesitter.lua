return {
  { -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = require("custom.plugins.config.tooling").treesitter_parsers,
    },
  },
}