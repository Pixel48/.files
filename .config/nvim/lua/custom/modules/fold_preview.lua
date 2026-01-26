-- Function to preview folded lines in a floating window
local function preview_fold()
    local winid = vim.api.nvim_get_current_win()
    local lnum = vim.api.nvim_win_get_cursor(winid)[1]

    -- Check if the line is actually folded
    local fold_start = vim.fn.foldclosed(lnum)
    if fold_start == -1 then
        vim.notify("No fold under cursor", vim.log.levels.INFO)
        return
    end

    local fold_end = vim.fn.foldclosedend(lnum)
    local lines = vim.api.nvim_buf_get_lines(0, fold_start - 1, fold_end, false)

    -- Create a temporary buffer for the preview
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Set filetype to match current buffer for syntax highlighting
    local current_ft = vim.bo.filetype
    vim.bo[buf].filetype = current_ft

    -- Calculate window size
    local width = vim.api.nvim_win_get_width(0)
    local height = math.min(#lines, vim.api.nvim_win_get_height(0) - 5)

    -- Open floating window
    local float_win = vim.api.nvim_open_win(buf, false, {
        relative = 'cursor',
        row = 1,
        col = 0,
        width = width - 4,
        height = height,
        style = 'minimal',
        border = 'rounded'
    })

    -- Close window on cursor move or mode change
    vim.api.nvim_create_autocmd({"CursorMoved", "ModeChanged", "BufLeave"}, {
        buffer = 0,
        once = true,
        callback = function()
            if vim.api.nvim_win_is_valid(float_win) then
                vim.api.nvim_win_close(float_win, true)
            end
        end
    })
end

-- Keybinding to trigger preview
vim.keymap.set('n', 'zv', preview_fold, { desc = "Preview fold under cursor" })
