lvim.colorscheme = "nordic"

-- Set a more prominent background color for Visual mode to improve visibility
vim.cmd([[
  highlight Visual guibg=#14151a guifg=NONE
]])

-- Toggle between nordic and onenord-light themes
lvim.keys.normal_mode["<leader>tt"] = function()
  local current_theme = vim.g.colors_name
  if current_theme == "nordic" then
    lvim.colorscheme = "onenord-light"
    vim.cmd("colorscheme onenord-light")
  else
    lvim.colorscheme = "nordic"
    vim.cmd("colorscheme nordic")
  end
  print("Switched to " .. lvim.colorscheme .. " theme")
end

-- lualine options
lvim.builtin.lualine.sections.lualine_c = {
  { "filename", path = 1 }  -- Using `path = 1` to show the relative path
}
lvim.builtin.lualine.sections.lualine_b = { "mode" }
lvim.builtin.lualine.sections.lualine_z = { "space" }
lvim.builtin.lualine.sections.lualine_y = { "space" }

-- require('lspconfig').cssls.setup({
--   capabilities = capabilities,
-- })

require('lspconfig').cssls.setup({
    filetypes = { "css", "scss", "sass" },
    settings = {
        css = {
            validate = true,
        },
        scss = {
            validate = true,
        },
        less = {
            validate = true,
        },
    },
})

require('lspconfig').stylelint_lsp.setup({
  filetypes = { "scss", "css", "sass" }, -- Ensure it attaches to SCSS files
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
    },
  },
})
-- install plugins
lvim.plugins = {
  {
    "rmehri01/onenord.nvim"
  },
  {
    "folke/tokyonight.nvim",
  },
  {
    "AlexvZyl/nordic.nvim",
  },
  {
    "mlaursen/vim-react-snippets"
  },
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
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
    require("nvim-ts-autotag").setup()
  end,
  },
  {
    "tpope/vim-surround"
  },
  {
    "mg979/vim-visual-multi"
  },
}

-- enable treesitter integration for matchup
-- lvim.builtin.treesitter.matchup.enable = true

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

vim.diagnostic.config({
  virtual_text = true
})

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "scss", "css", "html" },
  },
  {
    name = "djlint",
    filetypes = { "htmldjango" }
  }
}
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.scss" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } },
  { command = "djlint", filetypes = { "htmldjango" } } }

-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
-- use jedi_language_server as python lsp
return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
lvim.keys.normal_mode["<TAB>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-TAB>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<leader>E"] = ":NvimTreeFocus<CR>"
lvim.keys.normal_mode["<leader>o"] = ":let @+ = expand('%')<CR>" -- copy file path in to clipboard
lvim.keys.normal_mode["c"] = '"_c'
lvim.keys.normal_mode["C"] = '"_C'
lvim.keys.normal_mode["<leader>y"] = ":%y+<CR>" --yank complete file to system clipboard
-- Move line up
lvim.keys.normal_mode["<A-k>"] = ":m .-2<CR>=="
-- Move line down
lvim.keys.normal_mode["<A-j>"] = ":m .+1<CR>=="

-- Visual mode: Move selected lines up
lvim.keys.visual_mode["<A-k>"] = ":m '<-2<CR>gv=gv"
-- Visual mode: Move selected lines down
lvim.keys.visual_mode["<A-j>"] = ":m '>+1<CR>gv=gv"

lvim.keys.normal_mode["<leader>a"] = "ciw"
lvim.keys.normal_mode["<leader>s"] = "ci\""

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=45 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=45 direction=horizontal<cr>", "Split horizontal" },
}

lvim.keys.normal_mode["<leader>r"] = ":luafile ~/.config/lvim/config.lua<CR>"

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
  pattern = "*",
  command = "checktime",
})

lvim.builtin.treesitter.indent = { enable = false }

require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}

vim.opt.list = true
vim.opt.listchars:append("space:·,trail:•")

-- disable change of root dir
lvim.builtin.project.manual_mode = true

lvim.builtin.telescope.defaults.vimgrep_arguments = {
  "rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--no-ignore-vcs", -- respects .gitignore settings
  "--glob", "!*.min.*" -- exclude files with `.min.` in their names
}

lvim.builtin.telescope.defaults.path_display = { "relative" }

lvim.builtin.telescope.defaults.layout_strategy = "vertical"
lvim.builtin.telescope.defaults.layout_config = {
  width = 0.99, -- almost full screen width
  height = 0.99, -- almost full screen height
  preview_cutoff = 0, -- always show the preview
  vertical = {
    preview_height = 0.7, -- Make the preview window take up 70% of the height
    results_height = 0.3, -- Reduce the height of the results section to 30%
  },
}

lvim.builtin.telescope.pickers.find_files = {
  find_command = { "rg", "--files", "--hidden", "--iglob", "!.git/*", "--glob", "!*.min.*" }, -- exclude the .git directory and minified files
  show_untracked = false -- don't show untracked files or branches
}

vim.o.termguicolors = true
