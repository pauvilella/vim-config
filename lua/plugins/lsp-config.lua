return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local neodev = require("neodev")

    local keymap = vim.keymap -- for conciseness
    keymap.set('n', '<space>e', vim.diagnostic.open_float)
    keymap.set('n', '[d', vim.diagnostic.goto_prev)
    keymap.set('n', ']d', vim.diagnostic.goto_next)
    keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    local on_attach = function(_, bufnr)
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local opts = { buffer = bufnr }
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
      keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup Neodev
    neodev.setup()

    -- Lua
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        }
      }
    })

    -- Tailwind
    lspconfig.tailwindcss.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Yaml
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        yaml = {
          format = {
            enable = true,
            singleQuote = false,
            bracketSpacing = true,
          },
          validate = true,
          completion = true,
        }
      }
    })

    -- Golang
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" }
      }
    })

    -- Bash
    lspconfig.bashls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        filetypes = { "bash", "sh" }
      }
    })
  end
}
