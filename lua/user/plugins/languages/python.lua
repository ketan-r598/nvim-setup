return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Modern Neovim 0.12+ Native Server Hooks
      vim.lsp.config("basedpyright", {})
      vim.lsp.enable("basedpyright")

      require("nvim-treesitter").setup({
        ensure_installed = { "python" },
      })
    end,
  }
}
