local M = {}

local function state_dir()
  return vim.fn.stdpath("state") .. "/neovim-debugger"
end

local function state_path()
  return state_dir() .. "/state.json"
end

function M.bundle_path()
  return state_dir() .. "/latest-diagnostic-bundle.json"
end

function M.ensure_dir()
  vim.fn.mkdir(state_dir(), "p")
end

local function default_state()
  return {
    version = 2,
    issues = {},
    last_scan_at = nil,
    last_report_at = nil,
    pending_report = false,
    supervisor_started_at = nil,
  }
end

function M.load()
  M.ensure_dir()
  local path = state_path()
  if vim.fn.filereadable(path) == 0 then
    return default_state()
  end
  local ok, decoded = pcall(vim.fn.json_decode, vim.fn.readfile(path))
  if not ok or type(decoded) ~= "table" then
    return default_state()
  end
  decoded.version = 2
  decoded.issues = decoded.issues or {}
  return decoded
end

function M.save(state)
  M.ensure_dir()
  local lines = vim.fn.json_encode(state)
  vim.fn.writefile({ lines }, state_path())
end

function M.reset()
  local state = default_state()
  M.save(state)

  local flags = {
    state_dir() .. "/force-scan",
    state_dir() .. "/pending-report",
    state_dir() .. "/supervisor.pid",
    state_dir() .. "/agent.pid",
  }
  for _, flag in ipairs(flags) do
    if vim.fn.filereadable(flag) == 1 then
      vim.fn.delete(flag)
    end
  end

  local sessions = state_dir() .. "/sessions"
  if vim.fn.isdirectory(sessions) == 1 then
    vim.fn.delete(sessions, "rf")
  end
end

---@param message string
function M.issue_id(message)
  local normalized = message:gsub("%s+", " "):lower():gsub("^%s+", ""):gsub("%s+$", "")
  return vim.fn.sha256(normalized):sub(1, 16)
end

---@param id string
---@return table|nil
function M.find_issue(id)
  for _, issue in ipairs(M.load().issues) do
    if issue.id == id then
      return issue
    end
  end
  return nil
end

return M
