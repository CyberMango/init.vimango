--[[Utility functions for working with lua in nvim configs.
]]

local lua_utils = {}

local reload_configs = vim.api.nvim_create_augroup("reload_configs", {})

function lua_utils.table_length(a_table)
    local size = 0
    for _ in pairs(a_table) do
        size = size + 1
    end

    return size
end

function lua_utils.is_file_exist(filename)
    if nil == io.open(filename) then
        return false
    end
    return true
end

function lua_utils.goto_line_start()
    local curr_pos = vim.api.nvim_win_get_cursor(0)
    local curr_line = vim.api.nvim_buf_get_lines(0, curr_pos[1] - 1, curr_pos[1], false)
    local line_start = curr_line[1]:find("%S")
    if curr_pos[2] == line_start - 1 then
        return "0"
    end
    return "^"
end

--[[Close nvim if the last window open has a file_type buffer.
]]
function lua_utils.close_if_last(file_type)
    vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
            if file_type == vim.o.ft and 1 == lua_utils.table_length(vim.api.nvim_list_wins()) then
                vim.cmd(":q")
            end
        end,
        group = reload_configs
    })
end

return lua_utils
