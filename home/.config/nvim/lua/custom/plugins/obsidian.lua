return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  -- lazy = true,
  -- ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('obsidian').setup {
      workspaces = {
        {
          name = 'personal',
          path = '$HOME/Obsidian/My Second Brain',
        },
      },
      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = '+ Encounters',

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        -- name = 'fzf-lua',
        name = 'telescope.nvim',
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
          -- Create a new note from your query.
          new = '<C-x>',
          -- Insert a link to the selected note.
          insert_link = '<C-l>',
        },
      },

      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'Calendar/Logs/Journal',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },

      -- Optional, for templates (see below).
      templates = {
        subdir = 'Extras/Templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      ui = {
        enable = false,
      },
      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>oh'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = '+ Encounters',

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = 'markdown',

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart { 'open', url } -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = 'vsplit',

      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = 'Extras/images', -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },
    }
    vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>', { desc = '[O]bsidian [N]ew note' })
    vim.keymap.set('n', '<leader>otd', ':ObsidianToday<CR>', { desc = '[O]bsidian Journal [T]o[d]ay' })
    vim.keymap.set('n', '<leader>otm', ':ObsidianTomorrow<CR>', { desc = '[O]bsidian Journal [T]o[m]orrow' })
    vim.keymap.set('n', '<leader>oty', ':ObsidianYesterday<CR>', { desc = '[O]bsidian Journal [Y]esterday' })
    vim.keymap.set('n', '<leader>sj', ':ObsidianDailies<CR>', { desc = 'Search Obsidian [J]ournal' })
    vim.keymap.set('n', '<leader>so', ':ObsidianSearch<CR>', { desc = 'Search [O]bsidian' })
    vim.keymap.set('n', '<leader>oT', ':ObsidianTemplate<CR>', { desc = 'New [O]bsidian note with [T]emplate' })
  end,
}
