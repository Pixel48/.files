return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<C-;>", mode = { "n", "x" }, function() require("flash").jump() end, desc = "Flash" },
    { "<S-C-;>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<C-;>", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "<S-C-;>", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<C-space>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
