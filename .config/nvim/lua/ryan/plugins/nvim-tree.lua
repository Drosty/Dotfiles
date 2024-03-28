return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})

    local api = require("nvim-tree.api")

    -- vim.keymap.set('n', '<C-e>', ":NvimTreeToggle<cr>")
    vim.keymap.set('n', '<C-o>', api.tree.toggle, {})
  end,
}
