return {
	"kdheepak/monochrome.nvim",
	priority = 1000,
	config = function()
		require("monochrome")
		vim.cmd("colorscheme monochrome")
	end,
}
