require('catppuccin').setup({
    flavour = 'frappe',
    transparent_background = false, -- disables setting the background color.
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
    },
    integrations = {
        harpoon = true,
    },
})

function SetupAppareance(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetupAppareance()
