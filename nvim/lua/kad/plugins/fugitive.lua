return {
	"tpope/vim-fugitive",
	event = "User InGitRepo",
	config = function()
		require("config.fugitive")
	end,
}
