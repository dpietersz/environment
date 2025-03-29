return {
  'voldikss/vim-floaterm',
  lazy = false,
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.cmd [[
    highlight link Floaterm Cursorline
    highlight link FloatermBorder CursorlineSign
    ]]

    vim.keymap.set('n', '<C-t>', '<CMD>FloatermToggle<CR>', { desc = 'Open [T]erminal' })
    vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>')
  end,
}
