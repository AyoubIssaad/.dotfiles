return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import gitsigns plugin safely
		local gitsigns = require("gitsigns")

		-- enable gitsigns
		gitsigns.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})
	end,
}
