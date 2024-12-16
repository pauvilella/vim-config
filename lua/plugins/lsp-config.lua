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


    local on_attach = function(_, bufnr)
      local keymap = vim.keymap

      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local opts = { buffer = bufnr }

      -- Displays hover information about the symbol under the cursor
      keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      -- Jump to the definition
      keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

      -- Jump to the declaration
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

      -- Lists all the implementations for the symbol under the cursor
      keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

      -- Jumps to the definition of the type symbol
      keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)

      -- Lists all the references
      keymap.set('n', 'gr', vim.lsp.buf.references, opts)

      -- Displays a function's signature information
      keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)

      -- Renames all references to the symbol under the cursor
      keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

      -- Selects a code action available at the current cursor position
      keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

      -- Formats de buffer
      keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)

      -- Move to the next diagnostic
      keymap.set('n', 'ñ', vim.diagnostic.goto_next)

      -- Move to the previous diagnostic
      keymap.set('n', 'Ñ', vim.diagnostic.goto_prev)
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

    -- Setup Neodev
    neodev.setup()

    -- Lua
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = lsp_capabilities,
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
      capabilities = lsp_capabilities,
    })

    -- Yaml
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = lsp_capabilities,
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
      capabilities = lsp_capabilities,
      settings = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" }
      }
    })

    -- Bash
    lspconfig.bashls.setup({
      on_attach = on_attach,
      capabilities = lsp_capabilities,
      settings = {
        filetypes = { "bash", "sh" }
      }
    })

    -- Terraform
    lspconfig.terraformls.setup({
      on_attach = on_attach,
      capabilities = lsp_capabilities,
      settings = {
        filetypes = { "terraform", "terraform-vars" }
      }
    })
  end
}
