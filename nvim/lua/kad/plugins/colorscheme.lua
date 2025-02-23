-- return {
-- 	"kdheepak/monochrome.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("monochrome")
-- 		vim.cmd("colorscheme monochrome")
-- 	end,
-- }

return {
	"zenbones-theme/zenbones.nvim",
	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	dependencies = "rktjmp/lush.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.zenbones_darken_comments = 45
		vim.cmd.colorscheme("zenwritten")
	end,
}
