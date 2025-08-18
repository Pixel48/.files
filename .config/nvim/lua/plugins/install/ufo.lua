---@type NvPluginSpec
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { "lsp", "indent" }
    end,
  },
  init = function() end,
}
