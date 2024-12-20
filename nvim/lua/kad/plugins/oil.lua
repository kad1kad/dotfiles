return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    optional = true,
  },
  opts = {
    delete_to_trash = true,
    keymaps = {
      ["q"] = "actions.close",
    },
  },
  keys = {
    { "<leader>;", function() require("oil").open() end, desc = "Toggle Oil" },
  },
}
