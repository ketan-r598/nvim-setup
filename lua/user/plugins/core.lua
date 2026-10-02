return {
  -- 1. Modern Onedark Colorscheme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000, -- Make sure it loads first
    config = function()
      -- Configure the style before loading (options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer')
      require('onedark').setup({
        style = 'dark' 
      })
      -- Run your requested colorscheme command
      vim.cmd([[colorscheme onedark]])
    end,
  },

  -- 2. Vim-Airline & Airline Themes
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      -- This translates let g:airline_theme='onedark' into Lua syntax
      vim.g.airline_theme = 'onedark'
    end,
  },

  -- Sidebar File Tree (Neo-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", { desc = "Toggle File Explorer" })
    end,
  },

  -- Fuzzy Finder (Telescope)
  {
    "nvim-telescope/telescope.nvim",
--    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep (Search Text)" })
    end,
  },

  -- Git signs in the margin
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
