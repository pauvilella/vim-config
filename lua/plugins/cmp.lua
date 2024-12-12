---@diagnostic disable: missing-fields
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  event = "VeryLazy",
  config = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    -- Load the snippets from friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "luasnip" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = 'λ',
            luasnip = '⋗',
            buffer = 'Ω',
            path = ''
          }

          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },
      mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.scroll_docs(-4),
        ['<C-n>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),

        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<C-f>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })


    -- Modify Diagnostics
    vim.diagnostic.config({
      virtual_text = true,
      update_in_insert = true,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = true,
      },
    })

    local sign = function(opts)
      vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
      })
    end
    sign({ name = 'DiagnosticSignError', text = '' })
    sign({ name = 'DiagnosticSignWarn', text = '' })
    sign({ name = 'DiagnosticSignHint', text = '' })
    sign({ name = 'DiagnosticSignInfo', text = '' })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded' }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded' }
    )
  end
}
