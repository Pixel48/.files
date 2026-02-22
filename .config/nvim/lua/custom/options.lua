vim.o.colorcolumn = "80"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorlineopt = "both"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.spell = true
vim.opt.spelllang = { "en", "pl" }

-- Remap ZZ to QW, ZQ to QQ
vim.keymap.set("n", "QW", "<Cmd>xa<CR>", { desc = "Save all and quit" })
vim.keymap.set("n", "QQ", "<Cmd>qa!<CR>", { desc = "Quit all without saving" })

-- Mass-pull all files from custom/modules directory
