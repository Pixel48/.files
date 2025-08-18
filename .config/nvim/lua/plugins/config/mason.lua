---@type NvPluginSpec
return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = require "custom.lsp",
  },
}
