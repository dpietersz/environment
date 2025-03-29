return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
    'b0o/SchemaStore.nvim',

    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Don't do LSP stuff if we're in Obsidian Edit mode
    if vim.g.obsidian then
      return
    end

    local extend = function(name, key, values)
      local mod = require(string.format('lspconfig.configs.%s', name))
      local default = mod.default_config
      local keys = vim.split(key, '.', { plain = true })
      while #keys > 0 do
        local item = table.remove(keys, 1)
        default = default[item]
      end

      if vim.islist(default) then
        for _, value in ipairs(default) do
          table.insert(values, value)
        end
      else
        for item, value in pairs(default) do
          if not vim.tbl_contains(values, item) then
            values[item] = value
          end
        end
      end
      return values
    end

    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('<leader>ld', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('<leader>sR', require('telescope.builtin').lsp_references, '[S]earch [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('<leader>si', require('telescope.builtin').lsp_implementations, '[S]earch [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        -- map('<leader>ld', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Show [D]iagnostics')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'document [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>cr', vim.lsp.buf.rename, '[R]ename variable under cursor')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('<leader>lD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        vim.diagnostic.config {
          virtual_text = false,
          float = {
            source = true,
          },
        }

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>lh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, 'LSP: Inlay [H]ints')
        end
      end,
    })

    -- Change diagnostic symbols in the sign column (gutter)
    -- if vim.g.have_nerd_font then
    --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
    --   local diagnostic_signs = {}
    --   for type, icon in pairs(signs) do
    --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
    --   end
    --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
    -- end

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      bashls = {},
      gopls = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
      svelte = {},
      templ = {},
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },

      sqlfluff = {
        filetypes = { 'sql', 'mysql', 'pgsql', 'postgres' },
        settings = {
          sqlfluff = {
            connections = {}, -- Allow dynamic connections
          },
        },
      },
      volar = {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
          vue = {
            -- disable hybrid mode
            hybridMode = false,
          },
        },
      },
      intelephense = {
        init_options = {
          licenceKey = '/Users/pietersz/license.txt', -- Optional licence key or absolute path to a text file containing the licence key.
        },
        -- See https://github.com/bmewburn/intelephense-docs
        settings = {
          intelephense = {
            diagnostics = {
              enable = true,
              undefinedTypes = true,
              undefinedFunctions = true,
              undefinedParameters = true,
            },
            files = {
              maxSize = 1000000,
            },
          },
        },
      },

      pyright = {},
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = '',
            },
            -- schemas = require("schemastore").yaml.schemas(),
          },
        },
      },
      tailwindcss = {
        init_options = {
          userLanguages = {
            elixir = 'phoenix-heex',
            eruby = 'erb',
            heex = 'phoenix-heex',
          },
        },
        filetypes = extend('tailwindcss', 'filetypes', { 'ocaml.mlx' }),
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                [[class: "([^"]*)]],
                [[className="([^"]*)]],
              },
            },
            includeLanguages = extend('tailwindcss', 'settings.tailwindCSS.includeLanguages', {
              ['ocaml.mlx'] = 'html',
            }),
          },
        },
      },

      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`ts_ls`) will work just fine
      -- ts_ls = {},
      --

      lua_ls = {
        -- cmd = { ... },
        -- filetypes = { ... },
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --
    -- To check the current status of installed tools and/or manually install
    -- other tools, you can run
    --    :Mason
    --
    -- You can press `g?` for help in this menu.
    --
    -- `mason` had to be setup earlier: to configure its options see the
    -- `dependencies` table for `nvim-lspconfig` above.
    --
    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = servers,
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
    vim.api.nvim_create_user_command('Format', function()
      vim.lsp.buf.format { async = true }
    end, {})

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*.sql',
      callback = function()
        if vim.fn.exists '*db#url' == 0 then
          return -- Avoid errors if Dadbod is not available
        end

        local db_url = vim.fn.eval 'db#url()'

        if not db_url or db_url == '' then
          return
        end

        local driver = 'mysql'
        if db_url:match '^postgres' then
          driver = 'postgresql'
        elseif db_url:match '^sqlite' then
          driver = 'sqlite3'
        end

        vim.lsp.buf_notify(0, 'workspace/didChangeConfiguration', {
          settings = { sqls = { connections = { { driver = driver, dataSourceName = db_url } } } },
        })
      end,
    })
    local active_php_lsp = 'intelephense' -- Default to Intelephense

    local function toggle_php_lsp()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients { bufnr = bufnr }

      -- Stop both PHP LSPs before switching
      for _, client in ipairs(clients) do
        if client.name == 'intelephense' or client.name == 'phpactor' then
          vim.lsp.stop_client(client.id, true)
        end
      end

      -- Switch to the other LSP
      if active_php_lsp == 'intelephense' then
        active_php_lsp = 'phpactor'
      else
        active_php_lsp = 'intelephense'
      end

      -- Start the new LSP
      require('lspconfig')[active_php_lsp].setup {}
      vim.cmd 'e' -- Reload buffer to trigger new LSP

      -- Notify user
      vim.notify('Switched to ' .. active_php_lsp .. ' LSP', vim.log.levels.INFO)
    end

    -- Keymap to toggle LSP
    vim.keymap.set('n', '<leader>lt', toggle_php_lsp, { desc = 'Toggle PHP LSP (Intelephense/Phpactor)' })
  end,
}
