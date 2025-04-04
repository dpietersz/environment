return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- Harpoon setup
    harpoon:setup {}

    -- vim.keymap.set('n', '<leader>a', function()
    --   harpoon:list():add()
    -- end, { desc = '[A]dd file to Harpoon', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[A]dd file to Harpoon' })
    vim.keymap.set('n', '<leader>hh', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H] Toggle [H]arpoon' })

    vim.keymap.set('n', '<leader>hs', function()
      harpoon:list():select(1)
    end, { desc = '[H]arpoon 1 [S]' })
    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():select(2)
    end, { desc = '[H]arpoon 2 [D]' })
    vim.keymap.set('n', '<leader>hf', function()
      harpoon:list():select(3)
    end, { desc = '[H]arpoon 3 [F]' })
    vim.keymap.set('n', '<leader>hg', function()
      harpoon:list():select(4)
    end, { desc = '[H]arpoon 4 [G]' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = '[H]arpoon [P]revious' })
    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = '[H]arpoon [N]ext' })

    -- Telescope integration for Harpoon
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>sh', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[S]earch [H]arpoon', noremap = true, silent = true })
  end,
}
