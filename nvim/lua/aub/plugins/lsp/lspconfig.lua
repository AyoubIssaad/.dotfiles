return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "hrsh7th/cmp-nvim-lsp",
    -- { "antosha417/nvim-lsp-file-operations", config = true },
    -- { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition") -- show lsp definitions
        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<leader>D", require("telescope.builtin").diagnostics, "Show buffer diagnostics")
        map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        map("K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
        map("<leader>rs", ":LspRestart<CR>", "Restart LSP")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end
        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
              unusedwrite = true,
              useany = true,
            },
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            experimentalPostfixCompletions = true,
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            semanticTokens = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            importShortcut = "Definition",
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
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

      emmet_ls = {
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "svelte",
        },
      },

      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- is this line ever needed here ??
    require("mason").setup()

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    -- Add this configuration for hover windows
    -- Set up custom colors for floating windows
    -- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
    -- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

    -- Configure border characters and style
    local border = {
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }

    -- Configure specific handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = border,
      max_width = 80,
      max_height = 25,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = border,
      -- max_width = 80,
      -- max_height = 25,
    })

    vim.diagnostic.config({
      virtual_text = {
        source = "if_many", -- Or "if_many"
        prefix = "●", -- Could be '■', '▎', 'x'
      },
      severity_sort = true,
      float = {
        source = "if_many", -- Or "if_many"
        -- border = "rounded",
        header = "",
        prefix = "",
      },
      update_in_insert = false,
      signs = true,
      underline = true,
    })

    -- -- Show line diagnostics automatically in hover window
    -- vim.o.updatetime = 250
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   pattern = "*",
    --   callback = function()
    --     vim.diagnostic.open_float(nil, {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = border,
    --       source = "always",
    --       prefix = " ",
    --       scope = "cursor",
    --     })
    --   end,
    -- })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
