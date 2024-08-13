return {
  "jakobkhansen/journal.nvim",
  config = function()
    require("journal").setup({
      filetype = "md",
      root = "~/journal/",
    })
  end,
}
