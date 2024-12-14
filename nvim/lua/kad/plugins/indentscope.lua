return {
	"echasnovski/mini.indentscope",
	opts = function(_, opts)
		opts.symbol = "|" -- ▏│
		opts.options = { try_as_border = true }
		opts.draw = {
			delay = 0,
			animation = require("mini.indentscope").gen_animation.none(),
		}
	end,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"dashboard",
				"fzf",
				"help",
				"lazy",
				"lazyterm",
				"man",
				"mason",
				"neo-tree",
				"notify",
				"Outline",
				"toggleterm",
				"Trouble",
				"trouble",
				"alpha",
			},
			callback = function()
				if vim.bo.filetype == "alpha" then
					vim.b["miniindentscope_disable"] = true
				end
			end,
		})
	end,
}
