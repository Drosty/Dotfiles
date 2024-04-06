return {
  "Selyss/mind.nvim",
  branch = 'v2.2',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, used for icons
  },
  opts = {
    -- your configuration comes here
    persistence = {
      -- path where the global mind tree is stored
      state_path = '~/code/mind/mind.json',

      -- directory where to create global data files
      data_dir = '~/code/mind/data',
    },
  }
}
