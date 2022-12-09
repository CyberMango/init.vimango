local cmp = require("cmp")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "buffer", keyword_length = 4 },
        --{ name = "luasnip", keyword_length = 2 },
    },
    --window = {
    --    documentation = cmp.config.window.bordered()
    --},
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "L",
                luasnip = "S",
                buffer = "B",
                path = "P",
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(select_opts),

        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

        ["<C-u>"] = cmp.mapping.scroll_docs(-3),
        ["<C-f>"] = cmp.mapping.scroll_docs(3),

        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        --["<C-d>"] = cmp.mapping(function(fallback)
        --    if luasnip.jumpable(1) then
        --        luasnip.jump(1)
        --    else
        --        fallback()
        --    end
        --end, { "i", "s" }),

        --["<C-b>"] = cmp.mapping(function(fallback)
        --    if luasnip.jumpable(-1) then
        --        luasnip.jump(-1)
        --    else
        --        fallback()
        --    end
        --end, { "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                fallback()
            else
                cmp.complete()
            end
        end, { "i", "s" }
        ),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { "i", "s" }
        ),
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer", keyword_length = 2 }
    }
})

-- Set up lspconfig.
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)
