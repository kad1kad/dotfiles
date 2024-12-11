return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      -- "windwp/nvim-autopairs",
    },
    config = function()
      -- Configure Treesitter
      local ts = require("nvim-treesitter.configs")
      ts.setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
        ensure_installed = {
          "json", "javascript", "typescript", "tsx", "yaml", "html", "htmldjango", "css", "scss", "markdown",
          "markdown_inline", "bash", "lua", "vim", "dockerfile", "gitignore", "python", "elixir"
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })

      -- Configure nvim-autopairs
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true, -- Enable Treesitter integration
      })
    end,
  },
}
