return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
  preset = "simple",
	config = function()
		vim.diagnostic.config({ virtual_text = false })
		require("tiny-inline-diagnostic").setup({
			options = {
				show_source = true,
				overflow = {
					mode = "wrap",
				},
			},
		})
	end,
}
