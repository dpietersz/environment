return {
  'ahmedkhalf/project.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Add Telescope as a dependency
  },
  config = function()
    require('project_nvim').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    -- Load the Telescope extension for project.nvim
    require('telescope').load_extension 'projects'
  end,
}
