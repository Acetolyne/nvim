return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim", "akinsho/toggleterm.nvim" },
    opts = {
      terminal_cmd = "~/.local/bin/claude", -- Point to local installation
      terminal = {
        provider = function()
          local Terminal = require('toggleterm.terminal').Terminal
          local claude_term = Terminal:new({
            cmd = "~/.local/bin/claude",
            direction = "horizontal",
            close_on_exit = false,
            start_in_insert = true,
            on_stdout = function(_, _, data)
              -- Let claudecode handle output display in its buffer
              -- This terminal is just for input
            end,
          })
          
          return {
            open = function() 
              -- Open both: claudecode output buffer + toggleterm input
              vim.cmd('ClaudeCodeFocus')  -- Opens output buffer
              claude_term:open()          -- Opens input terminal
            end,
            close = function() claude_term:close() end,
            toggle = function() claude_term:toggle() end,
            send = function(data) claude_term:send(data) end,
          }
        end
      }
    },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
