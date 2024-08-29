return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()
    require("mini.trailspace").setup()
    require("mini.cursorword").setup()
  end,
  version = false,
}
