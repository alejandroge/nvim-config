local function macos_is_dark()
  if vim.fn.has("mac") == 0 then
    return true
  end

  local out = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  return vim.v.shell_error == 0 and out:match("Dark") ~= nil
end

local dark = macos_is_dark()

vim.o.termguicolors = true
vim.o.background = dark and "dark" or "light"

require("catppuccin").setup({
  flavour = dark and "mocha" or "latte",
  transparent_background = true,
  dim_inactive = {
    enabled = false,
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    harpoon = true,
    nvimtree = true,
  },
})

function SetupAppareance(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetupAppareance()
