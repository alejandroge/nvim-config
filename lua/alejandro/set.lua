vim.g.mapleader = " "

vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "121"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Large-file guard (disable folding for big files, e.g. >500KB)
local LARGE_FILE = 500 * 1024 -- bytes
local LARGE_FILE = 500 * 1024
local group = vim.api.nvim_create_augroup("LargeFileFolds", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = group,
    callback = function(ev)
        local f = ev.file
        if not f or f == "" then return end
        local ok, stat = pcall(vim.loop.fs_stat, f)
        if ok and stat and stat.size > LARGE_FILE then
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.foldenable = false
        end
    end,
})
