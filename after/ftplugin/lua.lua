--TODO add relevant paths to lua.
--vim.api.nvim_set_option_value('path', vim.o.path .. ',/usr/local/share/lua/**', {scope = 'local'})

vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'r', ''), {scope = 'local'})
vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'o', ''), {scope = 'local'})

-- Run lua with <leader>ti
vim.keymap.set('n', '<leader>ti', '<c-w>s:terminal<cr>ilua<cr><c-l>', {silent = true, buffer = true})
