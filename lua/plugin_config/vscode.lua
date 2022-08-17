--TODO ask if this is the correct way to add colorscheme settings.
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
            -- Changes the line number color for the cursor line.
            vscPopupFront = "#dddddd",
        },

        -- Override highlight groups (see ./lua/vscode/theme.lua)
        -- group_overrides = {
        --     -- this supports the same val table as vim.api.nvim_set_hl
        --     -- use colors from this colorscheme by requiring vscode.colors!
        --     Cursor = { fg=vs_colors.vscDarkBlue, bg=vs_colors.vscLightGreen, bold=true },
        -- }
    })
end
