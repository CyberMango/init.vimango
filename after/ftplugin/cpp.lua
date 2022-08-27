local lua_utils = require("lua_utils")

lua_utils.setlocal.cindent = true

-- TODO change this to cmake when you learn how to use it!!!
vim.api.nvim_set_option_value('makeprg', 'make', {scope = 'local'})

--TODO change this when local path appending bug is solved.
lua_utils.setlocal.path:append(lua_utils.set.path._value)
lua_utils.setlocal.path:append("/usr/include/**")
-- lua_utils.setlocal.path:append("/usr/include/**")

lua_utils.setlocal.formatoptions:remove({ "r", "o" })

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
