---@type NvPluginSpec
return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup {
      ensure_installed = require "custom.lsp",
      automatic_installation = true,
    }
  end,
}
