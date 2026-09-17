local state = require("neovim-debugger.state")

local M = {}

local function config_dir()
  return vim.fn.stdpath("config")
end

local function tail_file(path, max_lines)
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  local lines = vim.fn.readfile(path)
  if #lines == 0 then
    return ""
  end
  if #lines > max_lines then
    local start = #lines - max_lines + 1
    local sliced = {}
    for i = start, #lines do
      sliced[#sliced + 1] = lines[i]
    end
    lines = sliced
  end
  return table.concat(lines, "\n")
end

local function collect_log_excerpt()
  local parts = {}
  local log_dir = vim.fn.stdpath("log")
  local candidates = {
    log_dir .. "/log",
    log_dir .. "/avante.log",
    vim.fn.stdpath("state") .. "/avante.log",
  }

  for _, path in ipairs(candidates) do
    local excerpt = tail_file(path, 200)
    if excerpt and excerpt ~= "" then
      parts[#parts + 1] = ("--- %s ---\n%s"):format(path, excerpt)
    end
  end

  if #parts == 0 then
    return ""
  end
  return table.concat(parts, "\n\n")
end

local function collect_messages()
  local ok, output = pcall(vim.fn.execute, "messages")
  if not ok or type(output) ~= "string" then
    return ""
  end
  return output
end

local function collect_checkhealth_headless()
  local script = require("neovim-debugger.paths").plugin_dir() .. "/scripts/headless-checkhealth.sh"
  if vim.fn.filereadable(script) == 0 then
    return "headless-checkhealth.sh not found"
  end

  local result = vim.fn.system({ "bash", script, config_dir() })
  return result or ""
end

local function filter_config_diagnostics()
  local warnings = {}
  local config_prefix = config_dir()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name:find(config_prefix, 1, true) then
        local diags = vim.diagnostic.get(bufnr)
        for _, d in ipairs(diags) do
          warnings[#warnings + 1] = {
            file = name,
            lnum = d.lnum + 1,
            message = d.message,
            severity = d.severity,
          }
        end
      end
    end
  end

  return warnings
end

function M.collect()
  state.ensure_dir()

  local bundle = {
    collected_at = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    nvim_server = vim.env.NVIM or vim.v.servername,
    nvim_version = vim.fn.execute("version"),
    config_dir = config_dir(),
    messages = collect_messages(),
    checkhealth_headless = collect_checkhealth_headless(),
    log_excerpt = collect_log_excerpt(),
    config_buffer_diagnostics = filter_config_diagnostics(),
    known_issues = state.load().issues,
  }

  local encoded = vim.fn.json_encode(bundle)
  vim.fn.writefile({ encoded }, state.bundle_path())

  return bundle
end

return M
