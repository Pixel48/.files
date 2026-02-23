-- Mass-pull all files from custom/modules directory
require "custom.options"
local modules_path = vim.fn.stdpath "config" .. "/lua/custom/modules"
for _, file in ipairs(vim.fn.glob(modules_path .. "/*.lua", true, true)) do
  local module_name = "custom.modules." .. vim.fn.fnamemodify(file, ":t:r")
  require(module_name)
end
