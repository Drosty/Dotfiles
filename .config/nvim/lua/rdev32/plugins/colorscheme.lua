return {
  "EdenEast/nightfox.nvim",
  priority = 10000,
  config = function()
    require('nightfox').setup({
      options = {
        transparent = false,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        }
      }
    })

    vim.cmd("colorscheme carbonfox")
  end,
}
