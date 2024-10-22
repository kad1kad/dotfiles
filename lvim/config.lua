lvim.colorscheme = "nordic"
lvim.transparent_window = true

-- install plugins
lvim.plugins = {
  "AlexvZyl/nordic.nvim",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
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
  {
  "f-person/git-blame.nvim",
  event = "BufRead",
  config = function()
    vim.cmd "highlight default link gitblame SpecialComment"
    require("gitblame").setup { enabled = true }
  end,
},
{
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup()
  end,
},
{
  "mrjones2014/nvim-ts-rainbow",
},
{
  "karb94/neoscroll.nvim",
  event = "WinScrolled",
  config = function()
  require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = true,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,        -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,              -- Function to run after the scrolling animation ends
        })
  end
},
{
  "andymass/vim-matchup",
  event = "CursorMoved",
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
},
}

-- enable treesitter integration for matchup
lvim.builtin.treesitter.matchup.enable = true

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end

vim.opt.relativenumber = true
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
    filetypes = { "typescript", "typescriptreact", "scss", "css" },
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
lvim.keys.normal_mode["<leader>o"] = ":let @+ = expand('%')<CR>"
lvim.keys.normal_mode["<leader>i"] = ":let @+ = 'npx stylelint ' . expand('%') . ' --fix'<CR>"
lvim.keys.normal_mode["<A-3>"] = nil
lvim.keys.insert_mode["<A-3>"] = nil
lvim.keys.normal_mode["c"] = '"_c'
lvim.keys.normal_mode["C"] = '"_C'

-- disable change of root dir
lvim.builtin.project.manual_mode = true

require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}

lvim.builtin.alpha.dashboard.section.header.val = {
[[]],
[[ ██ ▄█▀▄▄▄      ▓█████▄      ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
[[ ██▄█▒▒████▄     ▒██▀ ██▌   ▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
[[ ▓███▄░▒██  ▀█▄  ░██   █▌    ▓██  █▒░▒██▒▓██    ▓██░ ]],
[[ ▓██ █▄░██▄▄▄▄██ ░▓█▄   ▌     ▒██ █░░░██░▒██    ▒██  ]],
[[ ▒██▒ █▄▓█   ▓██▒░▒████▓       ▒▀█░  ░██░▒██▒   ░██▒ ]],
[[ ▒ ▒▒ ▓▒▒▒   ▓▒█░ ▒▒▓  ▒       ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
[[ ░ ░▒ ▒░ ▒   ▒▒ ░ ░ ▒  ▒       ░ ░░   ▒ ░░  ░      ░ ]],
[[ ░ ░░ ░  ░   ▒    ░ ░  ░         ░░   ▒ ░░      ░    ]],
[[ ░  ░        ░  ░   ░             ░   ░         ░    ]],
[[                  ░              ░                   ]],
[[]],

}
-- turn off line wrap
-- vim.opt.wrap = false
