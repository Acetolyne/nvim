local M = {}

local state = require("neovim-debugger.state")

local function state_dir()
  return vim.fn.stdpath("state") .. "/neovim-debugger"
end

local function sessions_dir()
  return state_dir() .. "/sessions"
end

local function session_key()
  local server = vim.env.NVIM or vim.v.servername or ("pid-" .. tostring(vim.fn.getpid()))
  return server:gsub("/", "_")
end

local function session_path()
  return sessions_dir() .. "/" .. session_key() .. ".json"
end

local tracking = false
local avante_open = false
local heartbeat_timer = nil

local function write_session()
  state.ensure_dir()
  vim.fn.mkdir(sessions_dir(), "p")

  local payload = {
    server = vim.env.NVIM or vim.v.servername,
    pid = vim.fn.getpid(),
    last_active = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    avante_open = avante_open,
  }

  vim.fn.writefile({ vim.fn.json_encode(payload) }, session_path())
end

local function remove_session()
  local path = session_path()
  if vim.fn.filereadable(path) == 1 then
    vim.fn.delete(path)
  end
end

function M.touch()
  if not tracking then
    return
  end
  write_session()
end

function M.set_avante_open(open)
  avante_open = open
  M.touch()
end

function M.start()
  if tracking then
    return
  end
  tracking = true
  M.touch()

  local group = vim.api.nvim_create_augroup("NeovimDebuggerActivity", { clear = true })
  local events = { "CursorMoved", "CursorMovedI", "InsertEnter", "BufEnter", "WinEnter", "TextChanged", "TextChangedI" }

  for _, event in ipairs(events) do
    vim.api.nvim_create_autocmd(event, {
      group = group,
      callback = function()
        M.touch()
      end,
    })
  end

  vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = group,
    callback = function()
      M.touch()
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      remove_session()
    end,
  })

  if heartbeat_timer then
    heartbeat_timer:close()
  end
  heartbeat_timer = vim.uv.new_timer()
  heartbeat_timer:start(0, 60000, vim.schedule_wrap(function()
    if tracking then
      write_session()
    end
  end))
end

function M.stop()
  tracking = false
  avante_open = false
  if heartbeat_timer then
    heartbeat_timer:close()
    heartbeat_timer = nil
  end
  remove_session()
end

function M.is_tracking()
  return tracking
end

return M
