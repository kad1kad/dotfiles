
lvim.colorscheme = "nordic"
-- overrides nvim bg color theme with wezterm bg color
lvim.transparent_window = true

-- install plugins
lvim.plugins = {
  "AlexvZyl/nordic.nvim", 
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "casonadams/simple-diagnostics.nvim",
    config = function()
      require("simple-diagnostics").setup({
        virtual_text = true,
        message_area = false,
        signs = false,
      })
    end,
  },
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end

vim.opt.wrap = true

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- turn off virtual text
vim.diagnostic.config({
  virtual_text = false
})

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup { { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "scss", "css", "heex", "elixir", "html"},
  },
  {
    name = "djlint",
    filetypes = { "htmldjango" }
  }
}
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.js", ".ts", ".scss" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } },
  { command = "djlint", filetypes = { "htmldjango" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
lvim.keys.normal_mode["<TAB>"] = ":bnext<CR>"
lvim.keys.normal_mode["<leader>E"] = ":NvimTreeFocus<CR>"
lvim.keys.normal_mode["<CR>"] = ":noh<CR><CR>"
lvim.keys.normal_mode["c"] = '"_c'
lvim.keys.normal_mode["C"] = '"_C'

-- disable change of root dir
lvim.builtin.project.manual_mode = true

require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}

