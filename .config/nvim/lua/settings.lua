-- config for treesitter
require 'nvim-treesitter.configs'.setup{
    ensure_installed = {"c", "cpp", "python", "lua", "vim", "help"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = true,
}

require("mason").setup({
    pip = {
        install_args = {"--proxy", "http://127.0.0.1:7893"},
    },
})


require 'lspconfig'.pyright.setup{}
require 'lspconfig'.clangd.setup{}
