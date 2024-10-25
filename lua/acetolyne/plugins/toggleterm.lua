return {"akinsho/toggleterm.nvim", config = function()
  require("toggleterm").setup({
    direction = 'horizontal',
    close_on_exit = false,
    size = 40,
  })
end}
-- TODO: update settings to the terminal only opens on bottom of screen
-- TODO: look thru all setting to customize the plugin
-- TODO: assign a hotkey to open and close the visibility of the buffer
