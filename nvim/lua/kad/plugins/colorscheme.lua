return {
	"darkvoid-theme/darkvoid.nvim",
	priority = 1000,
	config = function()
		require("darkvoid").setup({
		})
		vim.cmd("colorscheme darkvoid")

		-- -- Set a more prominent background color for Visual mode
		-- vim.cmd([[
  --     highlight Visual guibg=#0f1114 guifg=NONE
  --   ]])
	end,
}
