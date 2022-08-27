local lua_utils = require("lua_utils")

local function vscode_config()
    if "vscode" == vim.g.colors_name then
        local vs_colors = require("vscode.colors")
        require("vscode").setup({
            -- Enable transparent background
            -- transparent = true,

            -- Enable italic comment
            -- italic_comments = true,

            -- Disable nvim-tree background color
            -- disable_nvimtree_bg = true,

            -- Override colors (see ./lua/vscode/colors.lua)
            color_overrides = {
                vscLineNumber = "#8A8A8A",
            },

            --[[Override highlight groups (see ./lua/vscode/theme.lua)
                this supports the same val table as vim.api.nvim_set_hl
                use colors from this colorscheme by requiring vscode.colors!
            ]]
            group_overrides = {
                -- Changes the line number color for the cursor line.
                CursorLineNr = { fg = "#dddddd" },
                -- Makes constants Blue like in vscode (default is yellow).
                TSConstant = { fg = vs_colors.vscBlue },
            },
        })
    end
end

vscode_config()

vim.api.nvim_create_autocmd("ColorScheme", {
    group = lua_utils.reload_configs,
    callback = vscode_config,
})
