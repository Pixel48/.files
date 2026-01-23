return {
  { -- mason-tool-installer
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = require("custom.plugins.config.tooling").tools,
      automatic_installation = true,
      auto_update = true,
      run_on_start = true,
      debounce_hours = 48,
    },
   },
   { -- mason-lspconfig
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = false,
    opts = {
      ensure_installed = require("custom.plugins.config.tooling").lsp_servers,
      automatic_installation = true,
    },
   },
   { -- lspconfig
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    lazy = false,
    config = function()
      local servers = require("custom.plugins.config.tooling").lsp_servers
      vim.lsp.enable(servers)
    end,
  },
}