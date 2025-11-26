return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
  {
    'williamboman/mason.nvim',
    version = "^1.0.0",
    lazy = false,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0.0",
    lazy = false,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ["<C-p>"] = cmp.mapping.select_prev_item({behavior = "select"}),
          ["<C-n>"] = cmp.mapping.select_next_item({behavior = "select"}),

          -- `Enter` key to confirm completion
          ["<CR>"] = cmp.mapping.confirm({select = false}),

          -- Ctrl+Space to trigger completion menu
          ["<C-Space>"] = cmp.mapping.complete(),

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
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      -- Add cmp_nvim_lsp capabilities to all servers
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      -- RubyLSP only works for Ruby ^3
      -- vim.lsp.config('ruby_lsp', {})
      vim.lsp.config('solargraph', {
          cmd = {
            'docker',
            'run',
            '-i',
            '--rm',
            '-v',
            '/Users/alejandro/Code/demodesk/backend',
            'registry.gitlab.com/demodesk/demodesk/demodesk-app',
            'solargraph',
            'bundle',
            '&&',
            'solargraph',
            'stdio',
          },
          settings = {
              solargraph = {
                  diagnostics = true
              }
          },

      })
      -- docker run -i --rm --name solargraph -v /Users/alejandro/Code/demodesk/backend registry.gitlab.com/demodesk/demodesk/demodesk-app:review-9511 solargraph
      -- vim.lsp.config('rubocop', {})
      vim.lsp.enable('solargraph')

      -- Make vtsls handle Vue files by loading the Vue TS plugin (if installed via mason)
      local vue_plugin = nil
      local ok, registry = pcall(require, 'mason-registry')
      if ok and registry.is_installed('vue-language-server') then
        local vue_path = registry.get_package('vue-language-server'):get_install_path()
        vue_plugin = {
          name = '@vue/typescript-plugin',
          location = vue_path .. '/node_modules/@vue/language-server',
          languages = { 'vue' },
          configNamespace = 'typescript',
        }
      end

      vim.lsp.config('vtsls', vim.tbl_extend('force', vim.lsp.config.vtsls or {}, {
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'vue',
        },
        settings = vue_plugin and {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        } or nil,
      }))

      require('mason-lspconfig').setup({
        ensure_installed = { 'vtsls' },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            if server_name == 'solargraph' then
              return
            end

            -- nvim-lspconfig renamed volar -> vue_ls
            local normalized = server_name == 'volar' and 'vue_ls' or server_name
            vim.lsp.enable(normalized)
          end,
        }
      })
    end
  }
}
