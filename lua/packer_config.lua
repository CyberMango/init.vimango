--[[Plugin management using packer.nvim
]]

local lua_utils = require("lua_utils")

-- Install packer if its not already installed.
local packer_path
local is_bootstrap = false

if vim.fn.has("win32") == 1 then
    packer_path = vim.fn.stdpath("data") .. "\\site\\pack\\packer\\start\\packer.nvim"
else
    packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
end

if not lua_utils.is_file_exist(packer_path) then
    local ret = os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim " ..
        packer_path)
    if 0 ~= ret then
        return {}
    end

    vim.cmd("packadd packer.nvim")
    is_bootstrap = true
end

-- Run PackerCompile everytime this file changes.
local packer_config_aus = vim.api.nvim_create_augroup("packer_config_aus", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer_config.lua",
    command = "source <afile> | PackerSync",
    group = packer_config_aus,
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

    --[[LSP configurations and auto install.
        :LspInstall <server> - Install new language servers.
        :LspUninstall <server> - Uninstall the language server name.
        :Mason - See status of the mason plugin that manages installed language servers.
    ]]
    use({ "williamboman/mason.nvim", config = get_config("mason") })
    use({ "williamboman/mason-lspconfig.nvim", config = get_config("mason-lspconfig"),
        requires = { { "williamboman/mason.nvim" } } })
    use({ "neovim/nvim-lspconfig", config = get_config("lsp"),
        requires = { { "williamboman/mason.nvim" }, { "williamboman/mason-lspconfig.nvim" } } })

    --[[treesitter - Better syntax highlighting, folding, indentation, and node selection features.
        Also, other plugins cna use this as well for more advanced features.
        :TSInstall <language_name> to get new parsers.
        :TSDisable if this does any problems.
    ]]
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_config("treesitter") })

    -- File explorer.
    --TODO understand why the config command doenst work for this plugin.
    use({ "Shougo/defx.nvim", run = ":UpdateRemotePlugins",
        config = function() vim.cmd("source $VIMD/lua/plugin_config/defx.vim") end })
    --TODO remove when issue fixed.
    vim.cmd("source $VIMD/lua/plugin_config/defx.vim")

    -- Smart way to remove trailing whitespace.
    use("axelf4/vim-strip-trailing-whitespace")

    --[[Enable editting files as root after openning them. use :SudaRead to edit
        and :SudaWrite to save.
    ]]
    use("lambdalisue/suda.vim")

    -- Auto Doxygen doc with :Dox.
    use({ "vim-scripts/DoxygenToolkit.vim",
        config = function() vim.cmd("source $VIMD/lua/plugin_config/DoxygenToolkit.vim") end })

    -- Command mode readline shortcuts (like c-a and c-e).
    use({ "linty-org/readline.nvim", config = get_config("readline") })

    -- Colorschemes with treesitter support!
    use("sainnhe/gruvbox-material")
    use("luisiacc/gruvbox-baby")
    use({ "Mofiqul/vscode.nvim", config = get_config("vscode") })

    -- Autocompletion plugin. TODO configure it right.
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use({ "hrsh7th/nvim-cmp", config = get_config("nvim_cmp") })

	-- Snippets plugin. TODO actually configure it. Its currently just to make nvm-cmp not crush.
	use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})

    --    " Snippets
    --    Plug 'sirver/UltiSnips'

    --    " Statusline/Tabline manager.
    --    Plug 'vim-airline/vim-airline'
    --    Plug 'vim-airline/vim-airline-themes'

    --    " Auto close pairs. This is the best one, but it still doesnt suffice.
    --    "Plug 'cohama/lexima.vim'

    if is_bootstrap then
        require("packer").sync()

        print "=================================="
        print "    Plugins are being installed"
        print "    Wait until Packer completes,"
        print "       then restart nvim"
        print "=================================="
        return {}
    end
end)
