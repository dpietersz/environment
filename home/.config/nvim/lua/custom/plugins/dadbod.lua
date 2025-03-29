local sql_ft = { 'sql', 'mysql', 'plsql' }

return {
  'tpope/vim-dadbod',
  lazy = false,
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
    ft = sql_ft,
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = sql_ft,
        callback = function()
          local cmp = require 'cmp'

          -- global sources
          ---@param source cmp.SourceConfig
          local sources = vim.tbl_map(function(source)
            return { name = source.name }
          end, cmp.get_config().sources)

          -- add vim-dadbod-completion source
          table.insert(sources, { name = 'vim-dadbod-completion' })

          -- update sources for the current buffer
          cmp.setup.buffer { sources = sources }
        end,
      })
    end,
  },
  'kristijanhusak/vim-dadbod-ui',
  cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
  dependencies = 'vim-dadbod',
  init = function()
    local data_path = vim.fn.stdpath 'data'

    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
    vim.g.db_ui_show_database_icon = true
    vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
    vim.g.db_ui_use_nerd_fonts = true
    vim.g.db_ui_use_nvim_notify = true

    -- NOTE: The default behavior of auto-execution of queries on save is disabled
    -- this is useful when you have a big query that you don't want to run every time
    -- you save the file running those queries can crash neovim to run use the
    -- default keymap: <leader>S
    vim.g.db_ui_execute_on_save = false
  end,
  vim.keymap.set('n', '<leader>dbt', '<CMD>DBUIToggle<CR>', { desc = '[T]oggle DBUI' }),
  vim.keymap.set('n', '<leader>dba', '<CMD>DBUIAddConenction<CR>', { desc = '[A]dd connection' }),
  vim.keymap.set('n', '<leader>dbl', '<CMD>DBUILastQueryInfo<CR>', { desc = '[L]ast query info' }),

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dbout',
    callback = function()
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.foldenable = false
    end,
  }),
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'sql', 'mysql', 'pgsql', 'postgres' },
    callback = function()
      vim.cmd [[ setlocal omnifunc=vim_dadbod_completion#omni ]]
    end,
  }),
}
