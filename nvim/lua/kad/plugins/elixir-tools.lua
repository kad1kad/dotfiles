return {
	"elixir-tools/elixir-tools.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local elixir = require("elixir")
		local elixirls = require("elixir.elixirls")

		elixir.setup({
			nextls = {
				enable = false, -- defaults to false
				port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
				cmd = "path/to/next-ls", -- path to the executable. mutually exclusive with `port`
				spitfire = true, -- defaults to false
				init_options = {
					mix_env = "dev",
					mix_target = "host",
					experimental = {
						completions = {
							enable = false, -- control if completions are enabled. defaults to false
						},
					},
				},
				on_attach = function(client, bufnr)
					-- Add custom keybinds here if needed
				end,
			},
			elixirls = {
				-- specify a repository and branch
				repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
				branch = "mh/all-workspace-symbols", -- defaults to nil, checks out the default branch, mutually exclusive with the `tag` option
				tag = "v0.14.6", -- defaults to nil, mutually exclusive with the `branch` option

				-- specify the path to an existing elixir-ls installation
				cmd = {
					"/Users/kadare/.cache/nvim/elixir-tools.nvim/installs/elixir-lsp/elixir-ls/tags_v0.22.0/1.17.3-27/language_server.sh",
				},

				-- default settings, override using `settings` function
				settings = elixirls.settings({
					dialyzerEnabled = true,
					fetchDeps = false,
					enableTestLenses = false,
					suggestSpecs = false,
				}),
				on_attach = function(client, bufnr)
					vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
					vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
					vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
				end,
			},
			projectionist = {
				enable = true,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
