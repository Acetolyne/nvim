local activity = require("neovim-debugger.activity")
local supervisor = require("neovim-debugger.supervisor")
local state = require("neovim-debugger.state")

local M = {}

local hooked = false

function M.on_avante_opened()
  activity.start()
  activity.set_avante_open(true)
  supervisor.ensure_started()
end

function M.hook_avante()
  local ok, Sidebar = pcall(require, "avante.sidebar")
  if not ok or not Sidebar or not Sidebar.open then
    return false
  end

  if hooked or Sidebar._neovim_debugger_hooked then
    hooked = true
    return true
  end

  local original_open = Sidebar.open
  function Sidebar:open(opts)
    local result = original_open(self, opts)
    vim.schedule(function()
      if self:is_open() then
        M.on_avante_opened()
      end
    end)
    return result
  end

  local original_close = Sidebar.close
  if original_close then
    function Sidebar:close(...)
      activity.set_avante_open(false)
      return original_close(self, ...)
    end
  end

  hooked = true
  Sidebar._neovim_debugger_hooked = true
  return true
end

function M.run(opts)
  opts = opts or {}
  activity.start()
  if opts.force then
    supervisor.request_force_scan()
    vim.notify("neovim-debugger: force scan requested", vim.log.levels.INFO)
  else
    supervisor.ensure_started()
  end
  return true
end

function M.status()
  local s = state.load()
  local sup_pid = supervisor.supervisor_pid()
  local agent_pid = supervisor.agent_pid()
  local lines = {
    "neovim-debugger status",
    "  supervisor: "
      .. (sup_pid and ("running (pid " .. sup_pid .. ")") or "not running"),
    "  agent: "
      .. (agent_pid and ("running (pid " .. agent_pid .. ")") or "not running"),
    "  activity tracking: " .. tostring(activity.is_tracking()),
    "  user active (this machine): "
      .. (function()
        local script = require("neovim-debugger.paths").plugin_dir() .. "/scripts/is-active.sh"
        if vim.fn.filereadable(script) == 0 then
          return "unknown"
        end
        vim.fn.system({ "bash", script, vim.fn.stdpath("state") .. "/neovim-debugger", "600" })
        return vim.v.shell_error == 0 and "yes" or "no"
      end)(),
    "  last_scan_at: " .. tostring(s.last_scan_at or "never"),
    "  last_report_at: " .. tostring(s.last_report_at or "never"),
    "  pending_report: " .. tostring(s.pending_report),
    "  scan interval: 30 minutes (while active)",
    "  idle threshold: 10 minutes",
    "  bundle: " .. state.bundle_path(),
    "  logs: " .. vim.fn.stdpath("state") .. "/neovim-debugger/supervisor.log",
  }
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

function M.reset()
  local pid = supervisor.supervisor_pid()
  if pid then
    vim.fn.system({ "kill", tostring(pid) })
  end
  local agent_pid = supervisor.agent_pid()
  if agent_pid then
    vim.fn.system({ "kill", tostring(agent_pid) })
  end
  state.reset()
  vim.notify(
    "neovim-debugger: supervisor reset; open Cursor (avante) to start again",
    vim.log.levels.INFO
  )
end

return M
