---@type NvPluginSpec
return { -- PlatformIO supprt
  "anurag3301/nvim-platformio.lua",
  dependencies = {
    {"akinsho/nvim-toggleterm.lua"},
    {"nvim-telescope/telescope.nvim"},
    {"nvim-lua/plenary.nvim"},
  },
  ft = "cpp",
}
