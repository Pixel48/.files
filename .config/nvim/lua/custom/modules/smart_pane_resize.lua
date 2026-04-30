local map = vim.keymap.set

-- Smart context-aware window resizing
local function smart_resize(axis, direction, amount)
  local current_win = vim.fn.winnr()
  -- If amount is not provided, default to 5
  amount = amount or 5

  if axis == "vertical" then
    -- Check if we are in the rightmost window
    local is_rightmost = current_win == vim.fn.winnr "l"
    if direction == "left" then
      vim.cmd(is_rightmost and ("vertical resize +" .. amount) or ("vertical resize -" .. amount))
    elseif direction == "right" then
      vim.cmd(is_rightmost and ("vertical resize -" .. amount) or ("vertical resize +" .. amount))
    end
  elseif axis == "horizontal" then
    -- Check if we are in the bottommost window
    local is_bottommost = current_win == vim.fn.winnr "j"
    if direction == "up" then
      vim.cmd(is_bottommost and ("resize +" .. amount) or ("resize -" .. amount))
    elseif direction == "down" then
      vim.cmd(is_bottommost and ("resize -" .. amount) or ("resize +" .. amount))
    end
  end
end

-- Normal resize windows (Shift + Alt + Arrows, step = 5)
map("n", "<S-M-Left>", function()
  smart_resize("vertical", "left", 5)
end, { desc = "Resize window left (step 5)" })
map("n", "<S-M-Right>", function()
  smart_resize("vertical", "right", 5)
end, { desc = "Resize window right (step 5)" })
map("n", "<S-M-Up>", function()
  smart_resize("horizontal", "up", 5)
end, { desc = "Resize window up (step 5)" })
map("n", "<S-M-Down>", function()
  smart_resize("horizontal", "down", 5)
end, { desc = "Resize window down (step 5)" })

-- Large resize windows (Ctrl + Shift + Alt + Arrows, step = 15)
map("n", "<C-S-M-Left>", function()
  smart_resize("vertical", "left", 15)
end, { desc = "Large resize window left" })
map("n", "<C-S-M-Right>", function()
  smart_resize("vertical", "right", 15)
end, { desc = "Large resize window right" })
map("n", "<C-S-M-Up>", function()
  smart_resize("horizontal", "up", 15)
end, { desc = "Large resize window up" })
map("n", "<C-S-M-Down>", function()
  smart_resize("horizontal", "down", 15)
end, { desc = "Large resize window down" })
