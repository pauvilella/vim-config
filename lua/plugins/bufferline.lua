return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup {
      options = {
        mode = "buffers",
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
        hover = {
          enabled = true,
          delay = 25,
          reveal = { 'close' }
        },
        color_icons = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
      },
    }
    local keymap = vim.keymap

    keymap.set("n", "<Tab>", ':BufferLineCycleNext<cr>', { noremap = true, silent = true })
    keymap.set("n", "<S-Tab>", ':BufferLineCyclePrev<cr>', { noremap = true, silent = true })
    -- Make <leader> number navigate to the tab (buffer) with that number
    for i = 1, 9 do
      keymap.set('n', '<Leader>' .. i, function()
        vim.cmd("BufferLineGoToBuffer " .. i)
      end, { noremap = true, silent = true })
    end
    keymap.set("n", "<leader>bdo", ":BufferLineCloseOthers<cr>", { noremap = true, silent = true })
    keymap.set("n", "<leader>bdp", ":BufferLinePickClose<cr>", { noremap = true, silent = true })
  end,
}
