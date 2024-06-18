return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      require("harpoon"):setup()
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

            vim.keymap.set("n","<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n","<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n","<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n","<leader>4", function() harpoon:list():select(4) end)
            vim.keymap.set("n","<leader>5", function() harpoon:list():select(5) end)
    end,
    -- keys = {
    --   { "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file", },
    --   -- { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
    --   { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
    --   { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
    --   { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
    --   { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    --   { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
    -- },
}

