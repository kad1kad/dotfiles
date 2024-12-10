 return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_supress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
    })

    local keymap = vim.keymap

    -- Correcting the keymap definitions
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>")
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>")
  end,
}
