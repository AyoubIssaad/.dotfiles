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
		})
	end,
}
