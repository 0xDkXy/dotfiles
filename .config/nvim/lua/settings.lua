-- config for treesitter
require 'nvim-treesitter.configs'.setup{
    ensure_installed = {"c", "cpp", "python", "lua", "vim"},
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
require("mason-lspconfig").setup()


require 'lspconfig'.pyright.setup{}
require 'lspconfig'.clangd.setup{}
require 'lspconfig'.verible.setup{}

-- config for treesitter
require("nvim-treesitter.install").command_extra_args = {
    curl = {"--proxy", "http://127.0.0.1:7893"},
}


-- nvim-cmp
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })

})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!'}
            }
        }
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['clangd'].setup {
    capabilities = capabilities
}
require('lspconfig')['verible'].setup {
    capabilities = capabilities
}

-- buffer line config
vim.opt.termguicolors = true
require("bufferline").setup({
    options = {
        mode = "buffers"
    }
})

-- marks config
require("marks").setup()

-- flash.nvim 
require("flash").setup()

-- config for minimap
vim.g.minimap_width = 10
vim.g.minimap_auto_start = 1
vim.g.minimap_auto_start_win_enter = 1
