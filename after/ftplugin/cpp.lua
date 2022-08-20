vim.api.nvim_set_option_value('cindent', true, {scope = 'local'})
vim.api.nvim_set_option_value('path', vim.o.path .. ',/usr/include/**', {scope = 'local'})

-- TODO change this to cmake when you learn how to use it!!!
vim.api.nvim_set_option_value('makeprg', 'make', {scope = 'local'})

vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'r', ''), {scope = 'local'})
vim.api.nvim_set_option_value('formatoptions', string.gsub(vim.o.formatoptions, 'o', ''), {scope = 'local'})

--[[Hacky solution to be able to switch between ccls and clangd.
    For some unknown reason this function needs to be called twice in order for the server to run.
    By default cpp files will use clangd. To switch to ccls run :lua UseCcls() .
    Clangd is a little bit better, and even the only maintainer of ccls works on llvm.
    Ccls is easier to setup for small projects and is better at understanding badly written code
    bases (like, clangd shits itself on #include "file.cpp").
]]
UseCcls()
UseClangd()
UseClangd()
