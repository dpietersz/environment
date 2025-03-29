return {
  'folke/trouble.nvim',
  lazy = false,
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('trouble').setup {
      height = 10,
    }
    vim.keymap.set('n', '<leader>xx', '<cmd>Trouble<cr>', { desc = '[T]oggle Trouble' })
    vim.keymap.set('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', { desc = 'Trouble [W]orkspace' })
    vim.keymap.set('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', { desc = 'Trouble [D]iagnostics' })
    vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { desc = 'Trouble [L]oclist' })
    vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { desc = 'Trouble [Q]uickfix' })
    vim.keymap.set('n', '<leader>lR', '<cmd>Trouble lsp_references<cr>', { desc = 'LSP: [R]eferences' })
    vim.keymap.set(
      'n',
      ']t',
      '<cmd>Trouble diagnostics next modes.diagnostics=workspace<CR><CMD>Trouble diagnostics jump modes.diagnostics=workspace focus=true<CR>',
      { desc = 'next diagnostic item' }
    )

    vim.keymap.set(
      'n',
      '[t',
      '<cmd>Trouble diagnostics prev modes.diagnostics=workspace<CR><CMD>Trouble diagnostics jump modes.diagnostics=workspace focus=true<CR>',
      { desc = 'next diagnostic item' }
    )
    -- Diagnostic signs
    -- https://github.com/folke/trouble.nvim/issues/52
    local signs = {
      Error = ' ',
      Warning = ' ',
      Hint = ' ',
      Information = ' ',
      other = '﫠',
    }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
