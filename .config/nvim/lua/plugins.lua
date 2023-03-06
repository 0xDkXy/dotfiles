

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'


    use {'wfxr/minimap.vim', run = 'paru -S code-minimap-git'}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() 
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true})
            ts_update()
        end,
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
end)

