local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- List your plugins here
Plug("tpope/vim-sensible")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate"})

Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["bramch"] = "0.1.x" })
-- or                                , { "tag": "0.1.8" }

Plug("https://github.com/rose-pine/neovim.git", { ["as"] = "rose-pine" })
Plug("ThePrimeagen/harpoon")

Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("VonHeikemen/lsp-zero.nvim", { ["branch"] = "v4.x"})

Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

vim.call("plug#end")

-- Color schemes should be loaded after plug#end().
-- We prepend it with "silent!" to ignore errors when it"s not yet installed.
vim.cmd("silent! colorscheme rose-pine")
