local lua_utils = require("lua_utils")

lua_utils.setlocal.cindent = true

-- TODO find a better solution to this. Just appending to setlocal makes this the only value in path
-- (probably because the local path is empty, and this means we are using it now instead of the
-- global one).
lua_utils.setlocal.path:append(lua_utils.set.path._value)
lua_utils.setlocal.path:append("/usr/include/**")
-- lua_utils.setlocal.path:append("/usr/include/**")

lua_utils.setlocal.formatoptions:remove({ "r", "o" })

-- Hacky solution for server switching. See cpp.lua.
UseCcls()
UseClangd()
UseClangd()
