local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
  sources = {
    {name = "nvim_lsp"},
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ["<C-p>"] = cmp.mapping.select_prev_item({behavior = "select"}),
    ["<C-n>"] = cmp.mapping.select_next_item({behavior = "select"}),

    -- `Enter` key to confirm completion
    ["<CR>"] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ["<C-f>"] = cmp_action.vim_snippet_jump_forward(),
    ["<C-b>"] = cmp_action.vim_snippet_jump_backward(),

    -- Scroll up and down in the completion documentation
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})
