vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

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

vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  eol = "¶",
}

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-settings", { clear = true }),
  callback = function()
    vim.opt_local.spell = false
  end,
})
