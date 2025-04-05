return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local fzfLua = require("fzf-lua")

    keymap.set("n", "<leader><leader>", fzfLua.files, { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fw", fzfLua.live_grep, { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    -- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
