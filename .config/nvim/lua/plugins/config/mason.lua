---@type NvPluginSpec
return { -- Mason
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = require "custom.servers"
  }
}
