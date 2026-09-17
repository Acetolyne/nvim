local function pid_alive(pid)
  if not pid then
    return false
  end
  return vim.fn.system("kill -0 " .. pid .. " 2>/dev/null && echo alive"):match("alive") ~= nil
end

local paths = require("neovim-debugger.paths")

local M = {}

local function plugin_dir()
  return paths.plugin_dir()
end

local function state_dir()
  return vim.fn.stdpath("state") .. "/neovim-debugger"
end

function M.ensure_started()
  local script = plugin_dir() .. "/scripts/ensure-supervisor.sh"
  if vim.fn.filereadable(script) == 0 then
    vim.notify("neovim-debugger: ensure-supervisor.sh not found", vim.log.levels.ERROR)
    return false
  end

  vim.fn.jobstart({
    "bash",
    script,
    plugin_dir(),
    vim.fn.stdpath("config"),
  }, {
    detach = true,
  })
  return true
end

function M.request_force_scan()
  vim.fn.mkdir(state_dir(), "p")
  vim.fn.writefile({ os.date("!%Y-%m-%dT%H:%M:%SZ") }, state_dir() .. "/force-scan")
  M.ensure_started()
end

local function read_pid(path)
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  local lines = vim.fn.readfile(path)
  return tonumber(lines[1] or "")
end

function M.supervisor_pid()
  local pid = read_pid(state_dir() .. "/supervisor.pid")
  if pid_alive(pid) then
    return pid
  end
  return nil
end

function M.agent_pid()
  local pid = read_pid(state_dir() .. "/agent.pid")
  if pid_alive(pid) then
    return pid
  end
  return nil
end

function M.running()
  return M.supervisor_pid() ~= nil
end

return M
