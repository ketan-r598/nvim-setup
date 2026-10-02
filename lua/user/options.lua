local opt = vim.opt

opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Relative line numbers
opt.tabstop = 4            -- 1 tab = 4 spaces
opt.shiftwidth = 4         -- Indentation amount
opt.expandtab = true       -- Turn tabs into spaces
opt.smartindent = true     -- Good code indentation
opt.termguicolors = true   -- True color support

-- --- 6. Native Auto-pairs (Neovim 0.12+ Configuration) ---
-- Configures the built-in auto-pair triggers natively supported by the editor core.
if vim.pairs then
  vim.pairs.setup({
    -- Automatically inserts matching closing pairs
    enable = true,
    -- The characters that should trigger an automatic closing pair
    pairs = {
      ["("] = ")",
      ["{"] = "}",
      ["["] = "]",
      ['"'] = '"',
      ["'"] = "'",
      ["`"] = "`",
    },
    -- Prevents adding a duplicate closing character if you type it manually
    skip_next = [=[%w%%%'%"%]%)%}]=],
  })
end
-- --- 7. Force PowerShell as the Default Embedded Shell ---
if vim.fn.has("win32") == 1 then
  -- Tells Neovim to use powershell.exe as its execution shell
  vim.opt.shell = "powershell.exe"
  
  -- Configures command switches so Neovim passes arguments safely to PowerShell
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; stop"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; stop"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
