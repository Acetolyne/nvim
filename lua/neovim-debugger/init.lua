local M = {}

---@return string
function M.plugin_dir()
  return require("neovim-debugger.paths").plugin_dir()
end

local trigger = require("neovim-debugger.trigger")

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_create_user_command("NeovimDebuggerRun", function()
    trigger.run({ force = true })
  end, { desc = "Force a neovim-debugger diagnostic scan" })

  vim.api.nvim_create_user_command("NeovimDebuggerReset", function()
    trigger.reset()
  end, { desc = "Stop supervisor and reset neovim-debugger state" })

  vim.api.nvim_create_user_command("NeovimDebuggerStatus", function()
    trigger.status()
  end, { desc = "Show neovim-debugger supervisor status" })

  if opts.hook_avante ~= false then
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        vim.defer_fn(function()
          trigger.hook_avante()
        end, 100)
      end,
    })
  end
end

return M
