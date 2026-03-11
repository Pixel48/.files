require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("t", "<C-Space>", "<C-x>", { remap = true, silent = true })
map("t", "<C-@>", "<C-x>", { remap = true, silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Remap ZZ to QW, ZQ to QQ
vim.keymap.set("n", "QW", "<Cmd>xa!<CR>", { desc = "Save all and quit" })
vim.keymap.set("n", "QQ", "<Cmd>qa!<CR>", { desc = "Quit all without saving" })

