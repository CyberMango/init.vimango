vim.api.nvim_set_option_value('cindent', true, {scope = 'local'})
vim.api.nvim_set_option_value('path', vim.o.path .. ',/usr/include', {scope = 'local'})

-- TODO change this to cmake when you learn how to use it!!!
vim.api.nvim_set_option_value('makeprg', 'make', {scope = 'local'})

vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'r', ''), {scope = 'local'})
vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'o', ''), {scope = 'local'})
