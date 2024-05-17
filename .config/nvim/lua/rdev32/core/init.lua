require("rdev32.core.options")
require("rdev32.core.keymaps")

vim.filetype = on
vim.filetype.add({
  extension = {
    cls = "apex",
    apex = "apex",
    trigger = "apex",
    soql = "soql",
    sosl = "sosl",
    page = "html",
    component = "html",
  },
})
