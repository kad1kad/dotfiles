return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      local harpoon = require("harpoon")
      
      harpoon.setup({
        -- You can add any configuration options here
      })

      -- Set up key mappings for navigating Harpoon
      local keymap = vim.keymap
      keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { silent = true, noremap = true })
      keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", { silent = true, noremap = true })
      keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { silent = true, noremap = true })
      keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { silent = true, noremap = true })
      keymap.set('n', '<leader>h1', ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
      keymap.set('n', '<leader>h2', ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
      keymap.set('n', '<leader>h3', ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
      keymap.set('n', '<leader>h4', ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })
      keymap.set('n', '<leader>h5', ':lua require("harpoon.ui").nav_file(5)<CR>', { noremap = true, silent = true })
    end,
  },
}
