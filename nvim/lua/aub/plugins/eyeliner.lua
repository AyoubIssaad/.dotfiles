return {
	"jinh0/eyeliner.nvim",
	enabled = false,
	config = function()
		require("eyeliner").setup({
			highlight_on_key = false, -- show highlights only after keypress
			dim = false, -- dim all other characters if set to true (recommended!)
		})
	end,
}
