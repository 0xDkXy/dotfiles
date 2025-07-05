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
    -- pip = {
    --     install_args = {"--proxy", "http://127.0.0.1:7893"},
    -- },
})
require("mason-lspconfig").setup()


require 'lspconfig'.pyright.setup{}
require 'lspconfig'.clangd.setup{}
require 'lspconfig'.verible.setup{}

-- config for treesitter
require("nvim-treesitter.install").command_extra_args = {
    -- curl = {"--proxy", "http://127.0.0.1:7893"},
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
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        -- "--clang-tidy",
        -- "--header-insertion=never",
        "--pch-storage=memory",
        "--completion-style=detailed",
        "--function-arg-placeholders"
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
        semanticHighlighting = true
    },
    on_attach = function(client, bufnr)
        vim.lsp.set_log_level("debug")
    end,
}
require('lspconfig')['verible'].setup {
    capabilities = capabilities
}

-- set colorscheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- buffer line config
-- this must be after the the colorscheme
vim.opt.termguicolors = true 
require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers = "buffer_id",
        indicator = {
            icon = '▎', 
            style = 'underline',
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
                separator = true,
            },
            {
                filetype = "neo-tree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
                separator = true,
            },
        },
        separator_style = "slant",
    }
})

-- marks config
require("marks").setup()

-- flash.nvim 
require("flash").setup()

require("im_select").setup({
    default_im_select = "keyboard-us",
    default_command = 'fcitx5-remote',
    set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
    set_previous_events = { "InsertEnter" },
    keep_quiet_on_no_binary = false,
    async_switch_im = true
})

require("scope").setup({})

require("telescope").load_extension("scope")

-- config for minimap
vim.g.minimap_width = 10
vim.g.minimap_auto_start = 1
vim.g.minimap_auto_start_win_enter = 1

-- vim.lsp.enable('clangd')
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { noremap = true, silent = true })
vim.keymap.set('n', 'grr', vim.lsp.buf.references, { noremap = true, silent = true })
--vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
-- vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)

