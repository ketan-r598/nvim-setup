return {
  -- 0. High-Speed, Modern Icon Provider (Replaces nvim-web-devicons seamlessly)
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
      -- CRITICAL: Mocks the old devicons system so Neo-tree and Telescope use it instantly
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  -- 1. Modern Onedark Colorscheme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000, -- Make sure it loads first
    config = function()
      require('onedark').setup({
        style = 'dark'
      })
      vim.cmd([[colorscheme onedark]])
    end,
  },

  -- 2. Vim-Airline & Airline Themes (Fixed for Native Neovim 0.12+ LSP)
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_theme = 'onedark'

      -- Enable powerline fonts styling (adds smooth arrows for CaskaydiaMono)
      vim.g.airline_powerline_fonts = 1

      -- Modern Fix: Tells Airline to use Neovim's native Diagnostic API instead of old CoC
      vim.g.airline_section_warning = '%{airline#util#wrap(airline#extensions#nvimlsp#get_warning(),0)}'
      vim.g.airline_section_error = '%{airline#util#wrap(airline#extensions#nvimlsp#get_error(),0)}'
    end,
  },

  -- 3. Sidebar File Tree (Neo-tree) - Optimized for speed and sleek icons
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.icons", -- Swapped out the old provider
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", { desc = "Toggle File Explorer" })

      require("neo-tree").setup({
        -- Makes directory tree rendering snappy inside giant codebases like spring-core
        git = {
          enable = true,
          non_git_clean = false,
        },
        default_component_configs = {
          indent = {
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
          },
          icon = {
            with_text = true,
            default = "  ",
          },
          git_status = {
            symbols = {
              -- Minimalist, blazing-fast Git symbols instead of heavy text blocks
              added     = "•",
              modified  = "•",
              deleted   = "×",
              renamed   = "→",
              untracked = "?",
              ignored   = "◌",
              unstaged  = "▪",
              staged    = "✓",
              conflict  = "",
            }
          }
        }
      })
    end,
  },

  -- 4. Fuzzy Finder (Telescope - Optimized to show Nerd Font file icons)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.icons" -- Hooked up to the new high-performance system
    },
    config = function()
      -- Configure Telescope to explicitly enable icons inside search views
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
          -- This guarantees your CaskaydiaMono icons display cleanly next to files
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        }
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep (Search Text)" })
    end,
  },

  -- 5. Git signs in the margin
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
