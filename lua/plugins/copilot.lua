return {
  -- Other plugin configurations...
  {
    "github/copilot.vim",
    config = function()
      -- Optional: Configure Copilot keybindings or settings
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-n>", '<Plug>(copilot-next)', { silent = true })
      vim.api.nvim_set_keymap("i", "<C-p>", '<Plug>(copilot-previous)', { silent = true })
    end
  }
}

