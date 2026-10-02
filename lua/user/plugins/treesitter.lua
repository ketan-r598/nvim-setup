-- Save this as: C:/Users/ketan/AppData/Local/nvim/lua/user/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Modern 0.12+ Syntax: Configure through the root module
    require("nvim-treesitter").setup({
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
