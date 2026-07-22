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
        args = { "acp" },
        env = {
          HOME = os.getenv("HOME"),
          NODE_NO_WARNINGS = "1",
        },
      },
    },
    windows = {
      position = "right",
      width = 30,
    },
  },
}
