local lua_utils = require("lua_utils")

lua_utils.setlocal.cindent = true

--TODO change this when local path appending bug is solved.
lua_utils.setlocal.path = (lua_utils.set.path + "/usr/include/**"):get()
-- lua_utils.setlocal.path:append("/usr/include/**")

lua_utils.setlocal.formatoptions:remove({ "r", "o" })

-- Hacky solution for server switching. See cpp.lua.
UseCcls()
UseClangd()
UseClangd()
