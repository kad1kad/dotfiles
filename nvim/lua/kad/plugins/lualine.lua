return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- ensure the icons are loaded
		config = function()
			local function lsp_clients()
				local buf_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
				local client_names = {}
				for _, client in ipairs(buf_clients) do
					table.insert(client_names, client.name)
				end
				return table.concat(client_names, ", ")
			end

			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "auto",
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					section_separators = "", -- remove section separators
					component_separators = "", -- remove component separators
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = true,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1, -- 1 for relative path
						},
					},
					lualine_x = { lsp_clients }, -- Use the function here
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							path = 1, -- 1 for relative path
						},
					},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
}
