return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        { "bezhermoso/todos-lualine.nvim" },
        { "folke/todo-comments.nvim" } -- REQUIRED!
    },

    config = function ()
        -- Create the todos-lualine component:
        local conf = {
          -- The todo-comments types to show & in what order:
          order = { "TODO", "FIX" },
          keywords = {
            -- The icon to show, as well as the keywords to classify under each todo-comments types.
            -- Identical to how you'd configure folke/todos-comments.nvim, actually.
            TODO = { icon = " " },
            FIX = { icon = " ", alt = {"FIXME", "BUG", "FIXIT", "ISSUE"} },
            HACK = { icon =  " " },
            WARN = { icon = "", alt = {"WARNING"} },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", alt = {"INFO"} },
            TEST = { icon =  "⏲ ", alt = {"TESTING", "PASSED", "FAILED"} },
          },
          when_empty = "",
        }
        local todos_component = require("todos-lualine").component(conf)
        require('lualine').setup({
            sections = {
                -- Add it to whichever section you'd like e.g. right next to "progress" on the right:
                lualine_y = {todos_component },
            }
        })
    end,
}
