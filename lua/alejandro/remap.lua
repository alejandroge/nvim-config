vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without replacing register" })

-- do not work, when using nvim inside an ssh machine
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank to system clipboard (line)" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete without replacing register" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete without replacing register" })

vim.keymap.set("n", "<leader>cfp", function()
  local filename = vim.fn.expand("%")
  vim.fn.setreg("+", filename)
  vim.notify("Copied: " .. filename)
end, { noremap = true, silent = true, desc = "Copy filename to clipboard" })
