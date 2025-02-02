return {
	"kad1kad/darkvoid.nvim",
	priority = 1000,
	config = function()
		require("darkvoid").setup({
		})
		vim.cmd("colorscheme darkvoid")
	end,
}
