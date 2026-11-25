return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local opts = function(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
        vim.keymap.set("n", "<Right>", api.node.open.edit, opts "Open")
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
        vim.keymap.set("n", "<Left>", api.node.navigate.parent_close, opts "Close Directory")
      end,
    },
  },
}
