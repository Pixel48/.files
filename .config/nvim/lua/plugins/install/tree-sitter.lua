---@type NvPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "terraform",
      "hcl",
      "bash",
      "yaml",
      "c",
      "cpp",
    },
  },
}
