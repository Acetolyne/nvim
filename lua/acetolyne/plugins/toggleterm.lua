return {"akinsho/toggleterm.nvim", config = function()
  require("toggleterm").setup({
    direction = 'horizontal',
    close_on_exit = false,
    start_in_insert = true,
    float_opts = {
    width = function()
      return math.floor(vim.o.columns * 0.9)
    end,
    height = function()
      return math.floor((vim.o.lines - vim.o.cmdheight) * 0.9)
     end,
    row = function()
      return math.floor(0.05 * (vim.o.lines - vim.o.cmdheight))
    end,
    },
  })
end}
-- TODO: if possible only open toggleterm if in fullscreen else hide until hotkey is used
