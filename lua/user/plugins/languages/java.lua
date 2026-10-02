return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.lsp.config("jdtls", {})
      vim.lsp.enable("jdtls")

      require("nvim-treesitter").setup({
        ensure_installed = { "java" },
      })
    end,
  }
}
