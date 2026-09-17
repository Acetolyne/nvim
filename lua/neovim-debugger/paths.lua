local M = {}

--- Cursor plugin root (agent, skill, scripts) lives under ~/.cursor/, not in the Neovim config.
function M.plugin_dir()
  return vim.fn.expand("~/.cursor/plugins/neovim-debugger")
end

return M
