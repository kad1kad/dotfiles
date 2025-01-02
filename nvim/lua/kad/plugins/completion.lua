return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"roobert/tailwindcss-colorizer-cmp.nvim",
		"hrsh7th/cmp-cmdline",
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			opts = function()
				return {
					-- ...
					formatting = {
						format = require("lspkind").cmp_format({
							before = require("tailwind-tools.cmp").lspkind_format,
						}),
					},
				}
			end,

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}

-- Disabled for now
-- return {
--     "saghen/blink.cmp",
--     dependencies = {
--         "rafamadriz/friendly-snippets",
--         "onsails/lspkind.nvim",
--     },
--     version = "*",
--
--     ---@module 'blink.cmp'
--     ---@type blink.cmp.Config
--     opts = {
--
--         appearance = {
--             use_nvim_cmp_as_default = false,
--             nerd_font_variant = "mono",
--         },
--
--         completion = {
--             accept = { auto_brackets = { enabled = true } },
--
--             documentation = {
--                 auto_show = true,
--                 auto_show_delay_ms = 250,
--                 treesitter_highlighting = true,
--                 window = { border = "rounded" },
--             },
--
--             list = {
--                 selection = function(ctx)
--                     return ctx.mode == "cmdline" and "auto_insert" or "preselect"
--                 end,
--             },
--
--             menu = {
--                 border = "rounded",
--
--                 cmdline_position = function()
--                     if vim.g.ui_cmdline_pos ~= nil then
--                         local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
--                         return { pos[1] - 1, pos[2] }
--                     end
--                     local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
--                     return { vim.o.lines - height, 0 }
--                 end,
--
--                 draw = {
--                     columns = {
--                         { "kind_icon", "label", gap = 1 },
--                         { "kind" },
--                     },
--                     components = {
--                         kind_icon = {
--                             text = function(item)
--                                 local kind = require("lspkind").symbol_map[item.kind] or ""
--                                 return kind .. " "
--                             end,
--                             highlight = "CmpItemKind",
--                         },
--                         label = {
--                             text = function(item)
--                                 return item.label
--                             end,
--                             highlight = "CmpItemAbbr",
--                         },
--                         kind = {
--                             text = function(item)
--                                 return item.kind
--                             end,
--                             highlight = "CmpItemKind",
--                         },
--                     },
--                 },
--             },
--         },
--
--         -- My super-TAB configuration
--         keymap = {
--             ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
--             ["<C-e>"] = { "hide", "fallback" },
--             ["<CR>"] = { "accept", "fallback" },
--
--             ["<Tab>"] = {
--                 function(cmp)
--                     return cmp.select_next()
--                 end,
--                 "snippet_forward",
--                 "fallback",
--             },
--             ["<S-Tab>"] = {
--                 function(cmp)
--                     return cmp.select_prev()
--                 end,
--                 "snippet_backward",
--                 "fallback",
--             },
--
--             ["<Up>"] = { "select_prev", "fallback" },
--             ["<Down>"] = { "select_next", "fallback" },
--             ["<C-p>"] = { "select_prev", "fallback" },
--             ["<C-n>"] = { "select_next", "fallback" },
--             ["<C-up>"] = { "scroll_documentation_up", "fallback" },
--             ["<C-down>"] = { "scroll_documentation_down", "fallback" },
--         },
--
--         -- Experimental signature help support
--         signature = {
--             enabled = true,
--             window = { border = "rounded" },
--         },
--
--         sources = {
--             default = { "lsp", "path", "snippets", "buffer" },
--             cmdline = {}, -- Disable sources for command-line mode
--             providers = {
--                 lsp = {
--                     min_keyword_length = 2, -- Number of characters to trigger porvider
--                     score_offset = 0, -- Boost/penalize the score of the items
--                 },
--                 path = {
--                     min_keyword_length = 0,
--                 },
--                 snippets = {
--                     min_keyword_length = 2,
--                 },
--                 buffer = {
--                     min_keyword_length = 5,
--                     max_items = 5,
--                 },
--             },
--         },
--     },
-- }
