-- Save this file as: nvim/lua/user/options.lua
local opt = vim.opt

-- --- 1. Visuals & Interface ---
opt.number = true            -- Show line numbers
opt.relativenumber = true    -- Relative line numbers (makes jumping lines faster)
opt.signcolumn = "yes"       -- Always show the left column (prevents git signs from shaking the screen)
opt.cursorline = true        -- Highlight the screen line under the cursor
opt.termguicolors = true     -- Enable 24-bit RGB colors (required for Onedark)
opt.scrolloff = 8            -- Keep at least 8 lines visible above/below the cursor when scrolling
opt.wrap = false             -- Display long lines as one long line (no text wrapping)

-- --- 2. Tabs & Indentation ---
opt.tabstop = 4              -- Insert 4 spaces for a tab
opt.shiftwidth = 4           -- Number of spaces spaces used for each step of (auto)indent
opt.expandtab = true         -- Convert tabs into spaces
opt.smartindent = true       -- Make indenting smart (adds indentation after opening brackets, etc.)

-- --- 3. Search Performance ---
opt.ignorecase = true        -- Ignore case in search patterns
opt.smartcase = true         -- If you use a capital letter in search, it becomes case-sensitive
opt.hlsearch = false         -- Clear highlights after search is done (stops the screen from staying yellow)
opt.incsearch = true         -- Show search matches dynamically as you type

-- --- 4. System & Files ---
opt.mouse = "a"              -- Enable mouse support (helpful when you are starting out)
opt.clipboard = "unnamedplus" -- Sync Neovim clipboard with system clipboard (allows Windows Ctrl+C / Ctrl+V)
opt.swapfile = false         -- Do not create swap files
opt.backup = false           -- Do not create backup files
opt.undofile = true          -- Save undo history to a file (lets you undo changes even after closing Neovim)
opt.updatetime = 300         -- Faster completion and diagnostic messages (default is 4000ms)

-- --- 5. Windows Specific Tweaks ---
-- Fixes slow copy/paste lag that sometimes happens on Windows
if vim.fn.has("win32") == 1 then
  vim.g.clipboard = {
    name = "win32anankir",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

-- --- Telescope Fuzzy Finder Shortcuts ---

-- 1. Find Files by Name
vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Fuzzy find files" })

-- 2. Live Grep (Search text inside files)
vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Find text across project" })

-- 3. Search Open Buffers
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Find open buffers" })

-- 4. Search Help Tags
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Find help documentation" })

-- 5. Search Recent Files
vim.keymap.set("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Find recent files" })

-- 6. Resume Last Search
vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").resume() end, { desc = "Resume last search state" })

-- --- Integrated Terminal Setup ---

local term_buf = nil
local term_win = nil

local function toggle_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  vim.cmd([[botright 15split]])
  term_win = vim.api.nvim_get_current_win()

  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(term_win, term_buf)
  else
    vim.cmd([[terminal]])
    term_buf = vim.api.nvim_get_current_buf()
    
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end

  vim.cmd([[startinsert]])
end

-- 1. Normal Mode Toggle Shortcut
vim.keymap.set("n", "<C-t>", toggle_terminal, { desc = "Toggle integrated terminal" })

-- 2. CRITICAL: Terminal Mode Toggle Shortcut
-- This catches Ctrl+t while typing inside PowerShell and closes the panel instantly!
vim.keymap.set("t", "<C-t>", function()
  toggle_terminal()
end, { desc = "Toggle terminal from within terminal" })

-- 3. CRITICAL: Jump straight out of the terminal window using Ctrl+k
-- This allows you to leap out of PowerShell and focus back on your code window in one stroke.
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Jump to code window above" })

-- 4. Escape fallback mapping 
-- Pressing Esc still puts the terminal window into navigation mode if you want to look at history.
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal insert mode" })
