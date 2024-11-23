return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  -- "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  vim.treesitter.language.register('template', { 'htmldjango' })
}
