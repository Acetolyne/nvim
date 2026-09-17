return {
  dir = vim.fn.stdpath("config") .. "/packages/neovim-debugger",
  name = "neovim-debugger",
  lazy = false,
  dependencies = {
    {
      "yetone/avante.nvim",
      optional = true,
    },
  },
  config = function()
    require("neovim-debugger").setup({ hook_avante = true })
  end,
}
