return {
  "basola21/PDFview",
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim" },
  vim.keymap.set('n', '<leader>jj', "<cmd>:lua require('pdfview.renderer').next_page()<CR>", { noremap = true, silent = true}),
  vim.keymap.set('n', '<leader>kk', "<cmd>:lua require('pdfview.renderer').previous_page()<CR>", { noremap = true, silent = true})

}
