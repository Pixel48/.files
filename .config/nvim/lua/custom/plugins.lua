local result = {}
local modules = vim.fn.stdpath "config" .. "/lua/custom/plugins"
for _, file in ipairs(vim.fn.glob(modules .. "/*.lua", true, true)) do
  local module = "custom.plugins." .. vim.fn.fnamemodify(file, ":t:r")
  table.insert(result, { import = module })
end
return result
