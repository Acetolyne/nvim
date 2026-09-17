return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "cursor-acp",
    mode = "agentic",
    acp_providers = {
      ["cursor-acp"] = {
        command = vim.fn.expand("~/.local/bin/agent"),
        args = {
          "acp",
          "--plugin-dir",
          vim.fn.expand("~/.cursor/plugins/neovim-debugger"),
        },
        env = {
          HOME = os.getenv("HOME"),
          PATH = os.getenv("PATH"),
          NODE_NO_WARNINGS = "1",
        },
      },
    },
    behaviour = {
      -- Resumed ACP sessions replay tool calls; this stops jumping to the last
      -- edited file (e.g. ~/.cursor/cli-config.json) and overwriting NvimTree.
      acp_follow_agent_locations = false,
    },
    selector = {
      exclude_auto_select = { "NvimTree" },
    },
    windows = {
      position = "right",
      width = 30,
      ask = {
        start_insert = true,
      },
    },
    mappings = {
      sidebar = {
        -- Default <Tab> cycles sidebar panels; remap so Tab can focus the input instead.
        switch_windows = "<C-w>w",
        reverse_switch_windows = "<C-S-w>w",
      },
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)

    -- If NvimTree (or another non-editor window) is focused when avante opens,
    -- point the code window at a real file buffer so the tree is not hijacked.
    local Sidebar = require("avante.sidebar")
    local excluded_filetypes = { NvimTree = true, toggleterm = true, alpha = true, dashboard = true }
    local original_initialize = Sidebar.initialize

    function Sidebar:initialize()
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
      local is_editor = vim.bo[buf].buftype == "" and not excluded_filetypes[ft]

      if not is_editor then
        for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local candidate_buf = vim.api.nvim_win_get_buf(winid)
          local candidate_ft = vim.api.nvim_get_option_value("filetype", { buf = candidate_buf })
          if vim.bo[candidate_buf].buftype == "" and not excluded_filetypes[candidate_ft] then
            vim.api.nvim_set_current_win(winid)
            break
          end
        end
      end

      return original_initialize(self)
    end

    -- In the sidebar, Tab focuses the chat input (insert mode) instead of jumping
    -- back to the code window (e.g. cursor.lua).
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "AvanteInput", "Avante", "AvanteSelectedFiles", "AvanteTodos" },
      callback = function(event)
        vim.keymap.set("n", "<Tab>", function()
          local sidebar = require("avante").get()
          if not sidebar or not sidebar:is_open() then
            return
          end
          sidebar:focus_input()
          vim.defer_fn(function()
            vim.cmd("startinsert!")
          end, 50)
        end, { buffer = event.buf, nowait = true, desc = "avante: focus input" })
      end,
    })
  end,
}
