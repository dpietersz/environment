return {
  'phdah/nvim-databricks',
  dependencies = {
    'mfussenegger/nvim-dap', -- Optional dependency
  },
  config = function()
    require('nvim-databricks').setup {
      DBConfigFile = '~/.databrickscfg', -- Set path to Databricks connect config file
      python = 'python3', -- Set Python version for DBRun
      dap = 'true', -- Toggle to enable setting nvim-dap python environmental variables for cluster selection
    }
  end,
}
