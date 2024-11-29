return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
      require("bufferline").setup{
        options = {
          mode = "buffers",
          separator_style = "slant",
          diagnostics = "nvim_lsp",
          hover = {
              enabled = true,
              delay = 25,
              reveal = {'close'}
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
    end,
}

