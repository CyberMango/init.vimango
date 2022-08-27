local lua_utils = require("lua_utils")

--TODO add relevant paths to lua.

lua_utils.setlocal.formatoptions:remove({ "r", "o" })

-- Run lua REPL with <leader>ti
vim.keymap.set('n', '<leader>ti', '<c-w>s:terminal<cr>ilua<cr><c-l>', { silent = true, buffer = true })
