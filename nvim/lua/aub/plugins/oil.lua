return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- config = function()
	-- 	local oil = require("oil")
	-- 	oil.setup()
	-- end,
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
}
