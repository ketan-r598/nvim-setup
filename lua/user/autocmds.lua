-- Create a grouping for our custom automation to prevent duplicate listeners on reload
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local user_group = augroup("UserAutomation", { clear = true })

-- --- 1. Highlight Text on Yank (Copy) ---
-- This flashes the copied lines briefly so you know exactly what went to your clipboard.
autocmd("TextYankPost", {
  group = user_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- The highlight style (uses your theme's search color)
      timeout = 150,         -- Flashes for 150 milliseconds
    })
  end,
})

-- --- 2. Auto-Format Code on Save ---
-- Whenever you write/save a buffer (:w), Neovim will cleanly format the code structure.
autocmd("BufWritePre", {
  group = user_group,
  pattern = "*",
  callback = function()
    -- Only run formatting if a Language Server (LSP) is actively attached to the file
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    if next(clients) ~= nil then
      vim.lsp.buf.format({ async = false })
    end
  end,
})
