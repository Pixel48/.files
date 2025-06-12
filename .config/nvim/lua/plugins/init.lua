return {
  { -- Conform
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { -- Rust
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  { -- Kualala
    "mistweaverco/kulala.nvim",
    ft = {"http", "rest"},
    opts = {
      global_keymaps = true
    },
  },
  { -- Mason
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "cssls",
        "jedi_language_server",
        "rust_analyzer",
        "clangd",
      }
    }
  },
  { -- PlatformIO supprt
    "anurag3301/nvim-platformio.lua",
    dependencies = {
      {"akinsho/nvim-toggleterm.lua"},
      {"nvim-telescope/telescope.nvim"},
      {"nvim-lua/plenary.nvim"},
    },
    ft = "cpp",
  },
  -- {
  --   "cuducos/yaml.nvim",
  --   ft = {"yaml", "yml"},
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "folke/snacks.nvim", -- optional
  --     "nvim-telescope/telescope.nvim", -- optional
  --     "ibhagwan/fzf-lua" -- optional
  --   },
  --
  -- },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = "go",
    -- opts = function()
      -- return require "custom.configs.null-ls"
    -- end,
  -- },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   opts = function()
  --     return require "custom.configs.rust-tools"
  --   end,
  --   config = function(_, opts)
  --     require('rust-tools').setup(opts)
  --   end
  -- },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
