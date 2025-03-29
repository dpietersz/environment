return {
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-dotenv',
      'MunifTanjim/nui.nvim',
      'nvimtools/none-ls.nvim',
      'kevinhwang91/promise-async',
    },
    cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
    keys = {
      { '<leader>pla', ':Laravel artisan<cr>' },
      { '<leader>plr', ':Laravel routes<cr>' },
      { '<leader>plm', ':Laravel related<cr>' },
    },
    event = { 'BufReadPre *.php', 'BufReadPre *.blade.php' },
    config = true,
    opts = {
      lsp_server = 'intelephense',
      features = { null_ls = { enable = false } },
    },
  },
  {
    'ricardoramirezr/blade-nav.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    ft = { 'blade', 'php' },
  },
  {
    'phpactor/phpactor',
    ft = 'php',
    build = 'composer install --no-dev --optimize-autoloader',
    config = function()
      vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>', { desc = '[P]HP actor Context [M]enu', silent = true, noremap = true })
      vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>', { desc = '[P]HP actor [N]ew Class', silent = true, noremap = true })
    end,
  },
  {
    'tpope/vim-projectionist',
    dependencies = {
      'tpope/vim-dispatch',
    },
    config = function()
      vim.g.projectionist_ask = 'builtin'

      vim.g.projectionist_heuristics = {
        artisan = {
          ['*'] = {
            start = 'php artisan serve',
            console = 'php artisan tinker',
          },
          ['app/*.php'] = {
            type = 'source',
            alternate = {
              'tests/Unit/{}Test.php',
              'tests/Feature/{}Test.php',
            },
          },
          ['tests/Feature/*Test.php'] = {
            type = 'test',
            alternate = 'app/{}.php',
          },
          ['tests/Unit/*Test.php'] = {
            type = 'test',
            alternate = 'app/{}.php',
          },
          ['app/Models/*.php'] = {
            type = 'model',
          },
          ['app/Http/Controllers/*.php'] = {
            type = 'controller',
          },
          ['routes/*.php'] = {
            type = 'route',
          },
          ['database/migrations/*.php'] = {
            type = 'migration',
          },
        },
      }
    end,
  },
}
