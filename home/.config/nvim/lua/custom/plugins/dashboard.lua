return {
  'goolord/alpha-nvim',
  dependencies = {
    -- 'nvim-tree/nvim-web-devicons'
    'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim',
  }, -- For icons in the dashboard
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.startify'

    -- Set the header art
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    -- Setup the dashboard with the modified configuration
    alpha.setup(dashboard.opts)
  end,
}
