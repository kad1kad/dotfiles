return {
	"slugbyte/lackluster.nvim",
	priority = 1000,
	config = function()
		require("lackluster").setup({
		})
		vim.cmd("colorscheme lackluster-mint")

		-- -- Set a more prominent background color for Visual mode
		-- vim.cmd([[
  --     highlight Visual guibg=#0f1114 guifg=NONE
  --   ]])
	end,
}
