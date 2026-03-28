require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

map("t", "<C-Space>", "<C-x>", { remap = true, silent = true })
map("t", "<C-@>", "<C-x>", { remap = true, silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Remap ZZ to QW, ZQ to QQ
map("n", "QW", "<Cmd>xa!<CR>", { desc = "Save all and quit" })
map("n", "QQ", "<Cmd>qa!<CR>", { desc = "Quit all without saving" })

-- :Telescope keymaps
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope Find Keymaps" })

-- gitsigns

pcall(del, "n", "<leader>h")
pcall(del, "n", "<leader>v")

local gitsigns = require "gitsigns"
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Git: Next Hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Git: Previous Hunk" })

map("n", "hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Git: Stage Hunk" })
map("v", "hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Git: Stage Hunk" })
map("n", "hw", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Git: Reset Hunk" })
map("n", "hv", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Git: Preview Hunk" })
map("n", "hz", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Git: Undo Stage Hunk" })

map("n", "ha", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Git: Stage Buffer" })
map("n", "hq", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Git: Reset Buffer" })

map("n", "hb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git: Blame Line" })
map("n", "hd", "<cmd>Gitsigns diffthis<CR>", { desc = "Git: Diff This" })
