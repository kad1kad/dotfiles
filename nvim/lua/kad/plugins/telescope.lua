return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",  -- Ensure you're using the specified version if you encounter compatibility issues
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        path_display = { "relative" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,  -- Correct function name
            ["<C-j>"] = actions.move_selection_next,  -- Correct function name
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
          n = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      }
    })

    telescope.load_extension("fzf")

    -- Keymapping for Telescope
    local keymap = vim.api.nvim_set_keymap

    -- Find files
    keymap("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })

    -- Live grep (search in the current working directory)
    keymap("n", "<leader>st", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })

    -- Live grep (search in the current working directory)
    keymap("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })

    -- Find LSP references (requires LSP server)
    keymap("n", "<leader>sl", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true })

    -- Find diagnostics (requires LSP server)
    keymap("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })

    -- Open old files, limiting to the current working directory
    keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').oldfiles({ cwd = vim.fn.getcwd() })<CR>", { noremap = true, silent = true })

    -- Reopen the last search
    keymap("n", "<leader>sl", "<cmd>Telescope resume<CR>", { noremap = true, silent = true })

    keymap('n', '<leader>sb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
  end,
}
