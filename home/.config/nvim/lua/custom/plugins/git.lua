return {
  'tpope/vim-fugitive',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        current_line_blame = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Next hunk' })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Previous hunk' })

          -- Actions
          map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = '[G]it [S]tage hunk' })
          map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = '[G]it [R]eset hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = '[G]it Stage buffer' })
          map('n', '<leader>ga', gs.stage_hunk, { desc = '[G]it Stage hunk (alias)' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[G]it [U]ndo stage hunk' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = '[G]it [R]eset buffer' })
          map('n', '<leader>gv', gs.preview_hunk, { desc = '[G]it Pre[V]iew hunk' })
          map('n', '<leader>gB', function()
            gs.blame_line { full = false }
          end, { desc = '[G]it [B]lame line' })
          map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = '[G]it [T]oggle [B]lame line' })
          map('n', '<leader>gd', gs.diffthis, { desc = '[G]it [D]iff' })
          map('n', '<leader>gD', function()
            gs.diffthis '~'
          end, { desc = '[G]it Diff against HEAD' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
        end,
      }
    end,
  },
  {
    'NeogitOrg/neogit',
    lazy = false,
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      -- Neogit-specific keymaps
      vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = '[G]it Neo[G]it' })
      vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { desc = '[G]it [C]ommit' })
      vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { desc = '[G]it [P]ull' })
      vim.keymap.set('n', '<leader>gP', ':Neogit push<CR>', { desc = '[G]it [P]ush' })
    end,
  },
}
