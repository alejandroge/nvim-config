vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "/Users/alejandro/Code/demodesk/*",
  callback = function()
    vim.fn.jobstart({"/Users/alejandro/Code/demodesk/sync_to_dev_server.sh"}, {detach = true})
  end,
})

