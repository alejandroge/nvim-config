-- https://github.com/nvim-neo-tree/neo-tree.nvim
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>")
vim.keymap.set("n", "<leader>t", "<Cmd>Neotree toggle<CR>")

require("neo-tree").setup({
    -- A list of functions, each representing a global custom command
    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    -- see `:h neo-tree-custom-commands-global`
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            hide_gitignored = false,
            hide_dotfiles = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".git",
              ".DS_Store",
              ".bundle",
              ".idea",
              "node_modules",
            },
        },
        follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
    },
})
