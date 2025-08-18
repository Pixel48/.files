---@type NvPluginSpec
return {
  "WhoIsSethDaniel/mason-tool-installer",
  ensure_installed = require "custom.lsp",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, require "custom.lua")
  end,
}
