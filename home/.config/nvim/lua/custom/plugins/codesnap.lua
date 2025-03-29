return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  keys = {
    { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = '[C]ode snapshot to [C]lipboard' },
    { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = '[C]ode snapshot to ~/Downloads' },
  },
  opts = {
    save_path = '~/Downloads',
    has_breadcrumbs = true,
    bg_theme = 'sea',
    show_workspace = true,
    has_line_number = true,
    watermark = 'Made By Dimitri Pietersz',
  },
}
