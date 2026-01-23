local ufo_opts = require "custom.plugins.config.ufo"

vim.o.colorcolumn = "80"
vim.o.relativenumber = true
vim.o.cursorlineopt = "both" -- to enable cursorline!
vim.o.foldcolumn = ufo_opts.foldcolumn
vim.o.foldlevel = ufo_opts.foldlevel
vim.o.foldlevelstart = ufo_opts.foldlevelstart
vim.o.foldenable = ufo_opts.foldenable