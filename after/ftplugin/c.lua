--TODO ask in a forum if this is the best way to replicate vims' setlocal. 
vim.api.nvim_set_option_value('cindent', true, {scope = 'local'})
vim.api.nvim_set_option_value('path', vim.o.path .. ',/usr/include/**', {scope = 'local'})

vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'r', ''), {scope = 'local'})
vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'o', ''), {scope = 'local'})

-- Hacky solution for server switching. See cpp.lua.
UseCcls()
UseClangd()
UseClangd()
