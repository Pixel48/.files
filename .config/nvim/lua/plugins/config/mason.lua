---@type NvPluginSpec
return {
  { -- Mason
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,

    opts = {
      ensure_installed = require "custom.lsp",
      -- automatic_install = true,
    },
  },
  { -- Mason lsp
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = require "custom.lua",
        automatic_installation = true,
      }
    end,
  },
  -- opts = function(_, opts)
  --   vim.list_extend(opts.ensure_installed, require "custom.lua")
  -- end,
  -- },
  -- { -- Mason Tool Installer
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   config = function()
  --     require("mason-tool-installer").setup {
  --       ensure_installed = require "custom.lua",
  --     }
  --   end,
  -- },
}
