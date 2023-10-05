return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import indent_blankline plugin safely
		local ibl = require("ibl")

		-- enable indent_blankline
		ibl.setup({
			indent = { char = "┊" },
			-- show_trailing_blankline_indent = false,
			whitespace = {
				remove_blankline_trail = false,
			},
			scope = { enabled = true },
		})
		-- ibl.setup({
		-- 	indent = {
		-- 		tab_char = "▎",
		-- 		highlight = "IndentBlanklineChar",
		-- 	},
		-- 	whitespace = {
		-- 		highlight = "IndentBlanklineSpaceChar",
		-- 	},
		-- 	scope = {
		-- 		char = "▎",
		-- 		show_end = false,
		-- 		-- highlight = "IndentBlanklineContextChar",
		-- 		include = {
		-- 			node_type = {
		-- 				["*"] = { "*" },
		-- 			},
		-- 		},
		-- 	},
		-- 	exclude = {
		-- 		filetypes = {
		-- 			"FTerm",
		-- 			"alpha",
		-- 			"packer",
		-- 			"NvimTree",
		-- 			"conf",
		-- 			"alpha",
		-- 		},
		-- 	},
		-- })
	end,
}
