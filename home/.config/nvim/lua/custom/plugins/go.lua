return {
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    'crusj/structrue-go.nvim',
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  config = function()
    require('structrue-go').setup()
    require('go').setup()
    vim.keymap.set('n', '<Localleader>gs', "<CMD>lua require'structrue-go'.toggle()<CR>", { desc = '[G]o [S]tructure' })
  end,
}
