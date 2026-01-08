return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",        -- required
    "sindrets/diffview.nvim",       --optional for diff view
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    {
      "<leader>go",
      function() require("neogit").open({ kind = "vsplit" }) end,
      desc = "Open Neogit UI"
    },
  },
  config = function()
    local neogit = require("neogit")
    require("neogit").setup({
    })
  end,
}
