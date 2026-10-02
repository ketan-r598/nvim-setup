return {
  -- Core Package Manager
  {
    "williamboman/mason.nvim",
    lazy = false, -- Boot immediately so language servers can hook into it
    priority = 1000,
    config = function()
      require("mason").setup()
      
      -- Native Neovim 0.12+ configuration for the baseline Lua environment
      vim.lsp.config("lua_ls", {})
      vim.lsp.enable("lua_ls")
    end,
  },

  -- Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim-lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
