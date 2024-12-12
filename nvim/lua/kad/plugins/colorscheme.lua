return {
	"AlexvZyl/nordic.nvim",
	priority = 1000,
	config = function()
		require("nordic").setup({
			-- Add nordic.nvim-specific configurations here
		})
		vim.cmd("colorscheme nordic")

		-- Set a more prominent background color for Visual mode
		vim.cmd([[
      highlight Visual guibg=#0f1114 guifg=NONE
    ]])
	end,
}
