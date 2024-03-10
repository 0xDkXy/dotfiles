
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.compatible = false
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.encoding = "utf-8"
vim.cmd("set t_Co=256")

vim.opt.autoindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.cursorcolumn = true
vim.opt.cursorline = true

vim.opt.wrap = true
vim.opt.textwidth = 80

vim.opt.scrolloff = 10
vim.opt.laststatus = 2
vim.opt.ruler = true

vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.autochdir = true
vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.wildmenu = true
vim.opt.wildmode = {"longest:list", "full"}

vim.opt.backspace = {"indent", "eol", "start"}

vim.cmd.highlight({"cursorline", "cterm=NONE", "ctermbg=darkgrey"})
vim.cmd.highlight({"cursorcolumn", "cterm=NONE", "ctermbg=darkgrey"})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.opt.expandtab = false
    end
})

vim.g.python3_host_prog = '/usr/bin/python3'

-- require('plugins')
-- require('settings')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")
require("settings")
