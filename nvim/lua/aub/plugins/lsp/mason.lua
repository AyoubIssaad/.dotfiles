return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- "jayp0521/mason-null-ls.nvim",
	},
	config = function()
		-- import mason plugin safely
		local mason = require("mason")

		-- import mason-lspconfig plugin safely
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- import mason-null-ls plugin safely
		-- local mason_null_ls = require("mason-null-ls")

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
				"tsserver",
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"pyright",
				-- "prismals",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"flake8",
			},
		})
		-- mason_null_ls.setup({
		-- 	-- list of formatters & linters for mason to install
		-- 	ensure_installed = {
		-- 		"prettier", -- ts/js formatter
		-- 		"stylua", -- lua formatter
		-- 		"eslint_d", -- ts/js linter
		-- 		"flake8",
		-- 	},
		-- 	-- auto-install configured servers (with lspconfig)
		-- 	automatic_installation = true,
		-- })
	end,
}
