local lua_utils = require("lua_utils")

local python_lua_aus = vim.api.nvim_create_augroup("python_lua_aus", {})

--TODO change this when local path appending bug is solved.
lua_utils.setlocal.path = (lua_utils.set.path + "/usr/lib/python*/**"):get()
lua_utils.setlocal.path:append(os.getenv("HOME") .. "/.local/lib/**/site-packages/**")

-- Run ipython with <leader>ti
vim.keymap.set("n", "<leader>ti", "<c-w>s:terminal<cr>iipython<cr><c-l>", { silent = true, buffer = true })

-- Run main with :make. See output again with :copen. Exists for compatability with cpp commands.
lua_utils.setlocal.makeprg = "python3 main.py"

-- Run current file with <F5> in a split window.
vim.keymap.set("n", "<f5>", "<c-w>s4<c-w>-:terminal<space>python3<space>%<cr>i", { buffer = true })
-- Run main file in a split window with ctrl-f5.
vim.keymap.set("n", "<f29>", "<c-w>s4<c-w>-:terminal<space>python3<space>main.py<cr>i", { buffer = true })

-- Make python constants blue like in VSCode for the vscode colorscheme.
local function config_vscode_colors()
    if "vscode" == vim.g.colors_name then
        require("vscode").setup({
            group_overrides = {
                TSConstant = { fg = "#4fc1ff" },
            },
        })
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = config_vscode_colors,
    pattern = "*.py",
    group = python_lua_aus,
})

config_vscode_colors()
