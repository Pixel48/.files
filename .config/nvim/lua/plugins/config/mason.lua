---@type NvPluginSpec
return { -- Mason
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
}
