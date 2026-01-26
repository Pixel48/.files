require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })


map("t", "<C-Space>", "<C-x>", { remap = true, silent = true })
map("t", "<C-@>", "<C-x>", { remap = true, silent = true })

-- Scroll buffer by line
map("n", "<C-j>", "<C-e>", { desc = "Scroll down one line" })
map("n", "<C-k>", "<C-y>", { desc = "Scroll up one line" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")