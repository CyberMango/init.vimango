require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "clangd", "pylsp" },
    automatic_installation = true,
})
