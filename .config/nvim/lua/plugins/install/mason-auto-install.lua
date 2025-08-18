---@type NvPluginSpec
return {
  "owallb/mason-auto-install.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    packages = require "custom.lsp",
  },
}
