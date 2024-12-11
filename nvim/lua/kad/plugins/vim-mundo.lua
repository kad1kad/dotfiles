return {
  "simnalamburt/vim-mundo",
  keys = {
    {
      "<leader>u",
      function()
        vim.cmd("MundoToggle")
      end,
      desc = "Open Mundo Undo Tree",
    },
  },
  config = function()
    -- Enable persistent undo
    vim.o.undofile = true
    vim.o.undodir = vim.fn.stdpath("state") .. "/undo"
  end,
}
