--[[Plugin management using packer.nvim
]]

-- Run PackerCompile everytime this file changes.
local packer_config = vim.api.nvim_create_augroup("packer_config", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
	group = packer_config,
})

local function get_config(name)
    return string.format("require('plugin_config/%s')", name)
end

return require("packer").startup(function(use)
    --[[Plugin manager:
        :PackerInstall - Clean, then install missing plugins.
        :PackerCompile - Run this whenever you make changes to your plugin
                         configurations. Regenerate compiled loader file.
        :PackerUpdate - Clean, then update and install plugins.
    ]]
    use("wbthomason/packer.nvim")

    -- Basic LSP configurations
    use({"neovim/nvim-lspconfig", config = get_config("lsp")})

    --[[treesitter - Better syntax highlighting, folding, indentation, and node selection features.
        Also, other plugins cna use this as well for more advanced features.
        :TSInstall <language_name> to get new parsers.
        :TSDisable if this does any problems.
    ]]
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_config("treesitter")})

    -- File explorer.
    --TODO understand why the config command doenst work for this plugin.
    use({"Shougo/defx.nvim", run = ":UpdateRemotePlugins",
        config = function () vim.cmd("source $VIMD/lua/plugin_config/defx.vim") end})
    --TODO remove when issue fixed.
    vim.cmd("source $VIMD/lua/plugin_config/defx.vim")

    -- Smart way to remove trailing whitespace.
    use("axelf4/vim-strip-trailing-whitespace")

    --[[Enable editting files as root after openning them. use :SudaRead to edit
        and :SudaWrite to save.
    ]]
    use("lambdalisue/suda.vim")

    -- Auto Doxygen doc with :Dox.
    use({"vim-scripts/DoxygenToolkit.vim",
        config = function () vim.cmd("source $VIMD/lua/plugin_config/DoxygenToolkit.vim") end})

    -- Command mode readline shortcuts (like c-a and c-e).
    use({"linty-org/readline.nvim", config = get_config("readline")})

    -- Colorschemes with treesitter support!
    use("sainnhe/gruvbox-material")
    use("luisiacc/gruvbox-baby")
    use({"Mofiqul/vscode.nvim", config = get_config("vscode")})

    --    " Snippets
    --    Plug 'sirver/UltiSnips'

    --    " Statusline/Tabline manager.
    --    Plug 'vim-airline/vim-airline'
    --    Plug 'vim-airline/vim-airline-themes'

    --    " Auto close pairs. This is the best one, but it still doesnt suffice.
    --    "Plug 'cohama/lexima.vim'
end)

