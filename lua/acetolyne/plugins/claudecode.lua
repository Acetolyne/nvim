return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = "claude", -- command used to launch Claude Code
    terminal = {
      split_side = "right",
      split_width_percentage = 0.30,
    },
  },
  -- keymaps live in core/keymaps.lua; these stubs load the plugin on first use
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeStatus",
  },
}
