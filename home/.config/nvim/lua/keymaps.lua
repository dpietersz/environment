-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in norml mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- CUSTOM KEYMAPS
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<Localleader>o', '<cmd>only<CR>', { desc = '[O]nly current buffer' })
-- Move selected lines up (K) or down (J) in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Join the line below with the current line, keeping the cursor in its original position
vim.keymap.set('n', 'J', 'mzJ`z')

-- Scroll half-page down (C-d) or up (C-u) and center the cursor line on the screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Center the cursor on the screen when moving to next (n) or previous (N) search match
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Restart the Language Server Protocol (LSP) server with <leader>zig in normal mode
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<cr>', { desc = 'LSP: [R]estart' })
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP: [I]nfo' })
vim.keymap.set('n', '<leader>ls', '<cmd>LspStrart<cr>', { desc = 'LSP: [S]tart' })
vim.keymap.set('n', '<leader>lS', '<cmd>LspStop<cr>', { desc = 'LSP: [S]top' })

-- -- In visual mode, replace selected text with clipboard content without overwriting the clipboard
vim.keymap.set('x', '<leader>r', [["_dP]], { desc = '[R]eplace selected text with clipboard' })

-- Copy to system clipboard in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Cop[Y] to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Cop[Y] to system clipboard' })

-- Delete to black hole register in normal and visual modes (delete without changing clipboard)
vim.keymap.set({ 'n', 'v' }, '<M-d>', [["_d]], { desc = '[D]elete to black hole' })

-- paste selection without copying it
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertian of trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- This is going to get me cancelled
vim.keymap.set('i', 'jj', '<Esc>')

-- Start a search and replace command for the word under the cursor
vim.keymap.set('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[S]earch & [R]eplace' })

-- Open file in OS
vim.keymap.set('n', '<leader>O', ':!open %<CR><CR>', { desc = '[O]pen file in OS' })

-- Insert Go error handling boilerplate
vim.keymap.set('n', '<Localleader>ge', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>', { desc = '[G]o [E]error handling' })

vim.keymap.set('n', '<leader>L', '<CMD>Lazy<CR>', { desc = '[L]azy' })

-- Buffers
vim.keymap.set('n', 'bh', ':bprev<enter>', opts)
vim.keymap.set('n', 'bl', ':bnext<enter>', opts)
-- vim.keymap.set('n', 'bd', ':Bdelete<enter>', opts)
vim.keymap.set('n', 'bdd', ':bdelete!<enter>', opts)
vim.keymap.set('n', 'bf', vim.lsp.buf.format, { desc = '[f]ormat buffer' })

vim.keymap.set('n', '<LocalLeader>q', ':q!<enter>', opts)
vim.keymap.set('n', '<LocalLeader>Q', ':qa!<enter>', opts)
vim.keymap.set('n', '<LocalLeader>w', ':w!<enter>', opts)
vim.keymap.set('n', '<LocalLeader>W', ':wq!<enter>', opts)

-- Indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- disable annoying commandline type
vim.keymap.set('n', 'q:', ':q')

-- Put cursor at and of selection after yank
vim.keymap.set('v', 'y', 'myy`y')

-- Quick movements
vim.keymap.set({ 'n', 'o', 'x' }, '<s-h>', '^', opts)
vim.keymap.set({ 'n', 'o', 'x' }, '<s-l>', 'g_', opts)

-- Splits
vim.keymap.set('n', '<LocalLeader>h', '<CMD>split<CR>', { desc = '[h]orizontal split' })
vim.keymap.set('n', '<LocalLeader>v', '<CMD>vsplit<CR>', { desc = '[v]ertical split' })
vim.keymap.set('n', '<M-,>', '<c-w>5<')
vim.keymap.set('n', '<M-.>', '<c-w>5>')
vim.keymap.set('n', '<M-t>', '<C-W>+')
vim.keymap.set('n', '<M-s>', '<C-W>-')
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})
