local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomasom/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- config for treesitter
require("nvim-treesitter.install").command_extra_args = {
    curl = {"--proxy", "http://127.0.0.1:7893"},
}


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'wfxr/minimap.vim'

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

