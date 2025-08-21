return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope", -- Lazy load on command
  keys = {
    {"<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find files"},
    {"<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files"},
    {"<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Live grep"},
    {"<leader>sc", "<cmd>Telescope grep_string<cr>", desc = "Grep string"},
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" }, -- More efficient than "smart"
        file_ignore_patterns = {
          "node_modules/.*",
          "%.git/.*",
          "%.DS_Store",
          "target/.*",
          "build/.*",
          "dist/.*",
        },
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })

    telescope.load_extension("fzf")

  end,
}
