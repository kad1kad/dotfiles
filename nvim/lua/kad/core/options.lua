local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- turn off line wrap
opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]],
	false
)

-- opt.list = true
-- opt.listchars:append("space:·,trail:•")

vim.o.hidden = false -- disable buffers

-- Save file when leaving a file
vim.api.nvim_create_autocmd("BufLeave", {
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent! w") -- Save the file silently without showing messages
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		if not vim.b.did_save_message then -- Check if the message hasn't been displayed yet
			vim.b.did_save_message = true
			-- vim.cmd("echo 'File saved'")  -- Show the save message
		end
	end,
})

-- Automatically save and restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local last_pos = vim.fn.line("'\"")
		-- Check if the last position is valid and within the file
		if last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

