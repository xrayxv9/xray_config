return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = { "css", "scss", "html", "javascript", "typescript", "typescriptreact", "javascriptreact" }
    })
  end
}
