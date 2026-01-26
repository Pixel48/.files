 return {
   { -- Origami (folding)
     "chrisgrieser/nvim-origami",
     event = "VeryLazy",
     opts = {
       foldKeymaps = { setup = false }, -- Disable h/l/$/^ mappings
     },
     init = function()
       vim.opt.foldlevel = 99
       vim.opt.foldlevelstart = 99
     end,
     keys = {
       {
         "Z",
         function()
           local count = vim.v.count
           if count > 0 then
             vim.opt.foldlevel = count
           else
             local current_level = vim.fn.foldlevel(vim.fn.line ".")
             vim.opt.foldlevel = math.max(0, current_level - 1)
           end
         end,
         desc = "Set fold level (count for level, no count folds below current)",
       },
     },
   },


  { -- Flash
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = require "custom.plugins.config.flash",
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

