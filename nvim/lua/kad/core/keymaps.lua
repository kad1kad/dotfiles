vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Copy file path to clipboard
keymap("n", "<leader>o", [[:lua print("Copied file path to clipboard: " .. vim.fn.expand("%")) vim.fn.setreg("+", vim.fn.expand("%"))<CR>]], opts)

-- Change without yanking
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("v", "c", '"_c', opts)
keymap("v", "C", '"_C', opts)

-- Yank entire file to system clipboard
keymap("n", "<leader>y", ":%y+<CR>", { noremap = true, silent = false })

-- Move line up
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- Move line down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)

-- Visual mode: Move selected lines up
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
-- Visual mode: Move selected lines down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)

-- Change inner word (shortcut for `ciw`)
keymap("n", "<leader>s", "ciw", opts)

-- Select all (like `ggVG`)
keymap("n", "<leader>a", "ggVG", opts)

-- Go back a word (shortcut for `b`)
keymap("n", "<BS>", "b", opts)

-- Write file with leader w
keymap("n", "<leader>w", ":w<CR>", opts)

-- Quit with leader q
keymap("n", "<leader>q", ":q<CR>", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohl<CR>", opts)

-- Window management
keymap("n", "<leader>sv", "<C-w>v", opts) -- Split vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- Split horizontally

-- Fugitive
keymap('n', '<leader>gb', ':Git blame<CR>', opts)
keymap('n', '<leader>gi', ':Git<CR>', opts)

-- Resize panes with Alt + hjkl
vim.api.nvim_set_keymap("n", "<M-h>", ":vertical resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<M-l>", ":vertical resize +2<CR>", opts)
vim.api.nvim_set_keymap("n", "<M-k>", ":resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<M-j>", ":resize +2<CR>", opts)

vim.keymap.set("n", "<leader>dh", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostics on hover" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
