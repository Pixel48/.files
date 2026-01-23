return {
  { -- UFO
    "kevinhwang91/nvim-ufo",
    name = "ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    opts = require("custom.plugins.config.ufo"),
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with" },
      { "zv", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, desc = "Peek fold or hover" },
    },
  },
  { -- Flash
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = require("custom.plugins.config.flash"),
    keys = {
      {
        "<C-;>",
        mode = { "n", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<S-C-;>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<C-;>",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "<S-C-;>",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<C-space>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  { -- Makrdown
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    ft = { "markdown", "vimwiki" },
    opts = {
      enabled = true,
    },
  },
  { -- diffview
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>dg", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  },
}