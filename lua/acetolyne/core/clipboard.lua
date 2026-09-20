-- Safe clipboard integration with timeout protection
-- This prevents Neovim from freezing when wl-clipboard hangs

local M = {}

-- Timeout in milliseconds for clipboard operations
local TIMEOUT = 500

-- Function to copy to system clipboard with timeout
function M.copy_to_clipboard(text)
  if not text or text == "" then
    return
  end

  -- Use vim.system (async) instead of vim.fn.system (blocking)
  vim.system(
    { "wl-copy", "--trim-newline" },
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
  vim.system(
    { "wl-paste", "--no-newline" },
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

-- Setup keybindings for safe clipboard operations
function M.setup()
  -- Visual mode: copy selection to system clipboard
  vim.keymap.set("v", "<leader>y", function()
    -- Yank to unnamed register first
    vim.cmd('normal! "yy')
    local text = vim.fn.getreg("y")
    M.copy_to_clipboard(text)
    vim.notify("Copied to system clipboard", vim.log.levels.INFO)
  end, { desc = "Copy to system clipboard", silent = true })

  -- Normal mode: copy line to system clipboard
  vim.keymap.set("n", "<leader>y", function()
    local line = vim.api.nvim_get_current_line()
    M.copy_to_clipboard(line .. "\n")
    vim.notify("Copied line to system clipboard", vim.log.levels.INFO)
  end, { desc = "Copy line to system clipboard", silent = true })

  -- Normal mode: paste from system clipboard
  vim.keymap.set("n", "<leader>p", function()
    M.paste_from_clipboard()
  end, { desc = "Paste from system clipboard", silent = true })

  -- Visual mode: paste from system clipboard (replace selection)
  vim.keymap.set("v", "<leader>p", function()
    M.paste_from_clipboard(function(text)
      -- Delete selection and paste
      vim.cmd('normal! gv"_d')
      local lines = vim.split(text, "\n")
      vim.api.nvim_put(lines, "c", false, true)
    end)
  end, { desc = "Paste from system clipboard", silent = true })

  -- Use standard y/p for internal clipboard (no system interaction)
  -- This keeps normal vim yank/paste fast and non-blocking
end

return M
