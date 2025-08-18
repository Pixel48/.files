---@type NvPluginSpec
return {
  "stevearc/conform.nvim",
  event = 'BufWritePre',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    -- css = { "prettier" }, html = { "prettier" },
    },
    format_on_save = { -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  }
}
