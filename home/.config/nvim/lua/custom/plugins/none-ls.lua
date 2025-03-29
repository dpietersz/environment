return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    
    null_ls.setup {
      sources = {
        -- Formatting
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,      -- Lua formatting
        null_ls.builtins.formatting.gofmt,       -- Go formatting
        null_ls.builtins.formatting.phpcsfixer,  -- PHP formatting
        null_ls.builtins.formatting.black,       -- Python formatting
        
        -- Diagnostics
        null_ls.builtins.diagnostics.trail_space.with {
          disabled_filetypes = { 'NvimTree' },
        },
        null_ls.builtins.diagnostics.sqlfluff.with {
          extra_args = { "--dialect", "postgres" }, -- or your preferred SQL dialect
        },
        
        -- Code Actions
        null_ls.builtins.code_actions.gitsigns,  -- Git signs integration
        
        -- Completion
        null_ls.builtins.completion.spell,       -- Spell suggestions
      },
      
      -- You can reuse the "Format" command that is already defined in your LSP config
      -- on_attach = function(client, bufnr)
      --   if client.supports_method("textDocument/formatting") then
      --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format({ bufnr = bufnr })
      --       end,
      --     })
      --   end
      -- end,
    }
  end,
}
