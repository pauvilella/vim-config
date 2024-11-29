return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = 1
    vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<cr>', { desc="Toogle Markdown Preview in a broser tab" })
  end,
  ft = { "markdown" },
}

