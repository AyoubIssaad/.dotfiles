return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import indent_blankline plugin safely
		local indent_blankline = require("indent_blankline")

		-- enable indent_blankline
		indent_blankline.setup({
			char = "┊",
			show_trailing_blankline_indent = false,
		})
	end,
}
