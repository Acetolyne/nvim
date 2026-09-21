-- Safe clipboard integration with timeout protection
-- This prevents Neovim from freezing when wl-clipboard hangs

local M = {}

-- Timeout in milliseconds for clipboard operations
local TIMEOUT = 500

-- Pick the first available clipboard backend (vim.system throws if the binary is missing)
local backends = {
  { copy = { "wl-copy", "--trim-newline" }, paste = { "wl-paste", "--no-newline" } },
  { copy = { "xclip", "-selection", "clipboard", "-in" }, paste = { "xclip", "-selection", "clipboard", "-out" } },
  { copy = { "xsel", "--clipboard", "--input" }, paste = { "xsel", "--clipboard", "--output" } },
}

local function get_backend()
  for _, b in ipairs(backends) do
    if vim.fn.executable(b.copy[1]) == 1 then
      return b
    end
  end
  vim.notify("No clipboard tool found (install wl-clipboard, xclip or xsel)", vim.log.levels.ERROR)
end

-- Function to copy to system clipboard with timeout
function M.copy_to_clipboard(text)
  if not text or text == "" then
    return
  end

  local backend = get_backend()
  if not backend then
    return
  end

  -- Use vim.system (async) instead of vim.fn.system (blocking)
  vim.system(
    backend.copy,
    {
      stdin = text,
      timeout = TIMEOUT,
    },
    function(obj)
      if obj.code ~= 0 then
        vim.schedule(function()
          vim.notify("Clipboard copy failed (timeout or error)", vim.log.levels.WARN)
        end)
      end
    end
  )
end

-- Function to paste from system clipboard with timeout
function M.paste_from_clipboard(callback)
  local backend = get_backend()
  if not backend then
    return
  end

  vim.system(
    backend.paste,
    {
      timeout = TIMEOUT,
      text = true,
    },
    function(obj)
      vim.schedule(function()
        if obj.code == 0 and obj.stdout then
          if callback then
            callback(obj.stdout)
          else
            -- Insert at cursor position
            local lines = vim.split(obj.stdout, "\n")
            vim.api.nvim_put(lines, "c", true, true)
          end
        else
          vim.notify("Clipboard paste failed (timeout or error)", vim.log.levels.WARN)
        end
      end)
    end
  )
end

return M
