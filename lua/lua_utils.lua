--[[Utility functions for working with lua in nvim configs.
]]

local lua_utils = {}

local reload_configs = vim.api.nvim_create_augroup("reload_configs", {})

-- Use this to make it easier to move settings from vim.o to vim.opt if you swap the two.
lua_utils.set = vim.o

function lua_utils.table_length(a_table)
    local size = 0
    for _ in pairs(a_table) do
        size = size + 1
    end

    return size
end

function lua_utils.is_file_exist(filename)
    local f = io.open(filename, "r")
    if nil ~= f then
        io.close(f)
        return true
    end

    return false
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
            if file_type == lua_utils.set.ft and 1 == lua_utils.table_length(vim.api.nvim_list_wins()) then
                vim.cmd(":q")
            end
        end,
        group = reload_configs
    })
end

return lua_utils
