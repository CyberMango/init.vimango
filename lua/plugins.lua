---- Plugin management using packer.nvim

-- Run PackerCompile everytime this file changes.
local packer_config = vim.api.nvim_create_augroup('packer_config', {})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = 'plugins.lua',
	command = 'source <afile> | PackerCompile',
	group = packer_config,
})

return require('packer').startup(function()
    --[[ Plugin manager:
        :PackerInstall - Clean, then install missing plugins.
        :PackerCompile - Run this whenever you make changes to your plugin
                         configurations. Regenerate compiled loader file.
        :PackerUpdate - Clean, then update and install plugins.
    ]]
    use 'wbthomason/packer.nvim'

    -- File explorer.
    use {'Shougo/defx.nvim', run = function() vim.fn['UpdateRemotePlugins']() end  }

    -- Smart way to remove trailing whitespace.
    use 'axelf4/vim-strip-trailing-whitespace'

    -- Enable editting files as root after openning them. use :SudaRead to edit
    -- and :SudaWrite to save.
    use 'lambdalisue/suda.vim'

    -- Auto Doxygen doc with :Dox.
    use 'vim-scripts/DoxygenToolkit.vim'

    -- Command mode readline shortcuts (like c-a and c-e).
    use 'linty-org/readline.nvim'

    --    " Snippets
    --    Plug 'sirver/UltiSnips'

    --    " Statusline/Tabline manager.
    --    Plug 'vim-airline/vim-airline'
    --    Plug 'vim-airline/vim-airline-themes'

    --    " Auto close pairs. This is the best one, but it still doesnt suffice.
    --    "Plug 'cohama/lexima.vim'
end)

