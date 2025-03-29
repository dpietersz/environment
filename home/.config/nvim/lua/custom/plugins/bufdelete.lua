return {
  'famiu/bufdelete.nvim',
  config = function()
    require 'bufdelete'
    vim.keymap.set('n', 'bd', '<cmd>Bdelete<CR>')
  end,
}
