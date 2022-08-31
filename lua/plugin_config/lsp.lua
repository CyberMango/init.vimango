---- LSP configurations
-- Toogle diagnostics.
local diagnostics_active = true
local function toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
        vim.diagnostic.enable()
    else
        vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
        vim.diagnostic.disable()
    end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>ss", toggle_diagnostics, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o> .
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("i", "<c-n>", "<c-x><c-o>", bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<m-s-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
        -- disable virtual text.
        virtual_text = false,

        -- show signs.
        signs = true,

        -- delay update diagnostics.
        update_in_insert = false,
    }
    )
end

-- Server Configurations.
local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

--[[Both servers require compile_commands.json. Generate it with:
    1) bear -- <your compile command>
    2) pass -DCMAKE_EXPORT_COMPILE_COMMANDS=ON to cmake when building.

    For driver libs add something like:
        cmd = {
            "clangd",
            "–query-driver=/path/to/my-custom/**/arm-none-eabi*"
        }
        For a complete solution read: https://github.com/espressif/esp-idf/issues/6721#issuecomment-997150632 .
]]

local function clangd_attach()
    require("lspconfig")["clangd"].setup({
        on_attach = on_attach,
        flags = lsp_flags,
    })
end

local function ccls_attach()
    require("lspconfig")["ccls"].setup({
        on_attach = on_attach,
        flags = lsp_flags,
    })
end
clangd_attach()

function UseClangd()
    vim.cmd("LspStop")
    clangd_attach()
end

-- For simple projects all you need is `printf "clangd\n%%cpp\n%%h -x\n%%h c++-header" > .ccls`
function UseCcls()
    -- For some reason this needs to be called twice if clangd is the first to run.
    vim.cmd("LspStop")
    ccls_attach()
    ccls_attach()
end

require("lspconfig")["pylsp"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false
                },
                pydocstyle = {
                    enabled = true
                },
                black = {
                    enabled = true
                }
            }
        }
    }
})

require("lspconfig")["sumneko_lua"].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
