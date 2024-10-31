return {
  "williamboman/mason.nvim",
  enabled = true,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    -- "jayp0521/mason-null-ls.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason plugin safely
    local mason = require("mason")

    -- import mason-lspconfig plugin safely
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls plugin safely
    -- local mason_null_ls = require("mason-null-ls")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- "tsserver",
        "html",
        -- "cssls",
        "gopls",
        "lua_ls",
        "emmet_ls",
        "pyright",
        -- "ruff_lsp",
        -- "prismals",
      },
      -- auto-install configured servers (with lspconfig)
      -- automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "gofumpt",
        "eslint_d",
        "flake8",
        "golangci-lint",
        "golangci-lint-langserver",
      },
    })
    -- mason_null_ls.setup({
    -- 	-- list of formatters & linters for mason to install
    -- 	ensure_installed = {
    -- 		"prettier", -- ts/js formatter
    -- 		"stylua", -- lua formatter
    -- 		"black",
    -- 		"isort",
    -- 		"gofumpt",
    -- 		"eslint_d", -- ts/js linter
    -- 		"flake8",
    -- 		-- "ruff",
    -- 	},
    -- 	-- auto-install configured servers (with lspconfig)
    -- 	automatic_installation = true,
    -- })
  end,
}
