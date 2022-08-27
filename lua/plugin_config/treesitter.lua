local lua_utils = require("lua_utils")

require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "cpp", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    -- sync_install = false,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    -- Visual select the current scope/node, and gradually higher nodes/scopes.
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<leader><tab>",
            -- node_incremental just seems to be better.
            scope_incremental = "v",
            node_incremental = "<tab>",
            node_decremental = "<s-tab>",
        },
    },

    -- Treesitter based auto indentation. Experimental and currently worse than default.
    -- indent = {
    --     enable = true
    -- }
})

lua_utils.set.foldmethod = "expr"
lua_utils.set.foldexpr = vim.fn["nvim_treesitter#foldexpr"]()
