return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"terraform",
					"hcl",
					-- "tsx",
					"yaml",
					"html",
					"c",
					"cpp",
					"http",
					"css",
					"rust",
					"comment",
					"go",
					-- "prisma",
					"markdown",
					"markdown_inline",
					-- "svelte",
					-- "graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"php",
					"regex",
					"python",
				},
				-- -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
				-- require("ts_context_commentstring").setup({
				-- 	enable = true,
				-- 	enable_autocmd = false,
				-- }),
				-- auto install above language parsers
				auto_install = true,
			})
		end,
	},
}
