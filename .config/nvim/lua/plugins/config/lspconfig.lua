---@type NvPluginSpec
return { "neovim/nvim-lspconfig",
  config = function()
    -- require "configs.lspconfig"
    require("nvchad.configs.lspconfig").defaults()

    local lspconfig = require "lspconfig"

    local servers = require "custom.servers"
    local nvlsp = require "nvchad.configs.lspconfig"
    local on_attach = nvlsp.on_attach
    local on_init = nvlsp.on_init
    local capabilities = nvlsp.capabilities

    -- lsps with default config
    for _, lsp in ipairs(servers) do lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
    end

    lspconfig.terraformls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"terraform", "terraform-vars", "tf"},
    }
  end,
}
