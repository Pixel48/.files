local set_hl = vim.api.nvim_set_hl

set_hl(0, "DiffDelete", { fg = "#ff5555", bg = "#2b1d1d" })
set_hl(0, "DiffRemoved", { fg = "#ff5555" })

set_hl(0, "NeogitDiffDelete", { fg = "#ff5555", bg = "#3d1919" })
set_hl(0, "NeogitDiffDeleteHighlight", { fg = "#ff8888", bg = "#4d2222" })
