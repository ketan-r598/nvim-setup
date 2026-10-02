-- Save this as: C:/Users/ketan/AppData/Local/nvim/lua/user/plugins/lsp.lua
return {
  -- Native LSP Server Installer for Neovim 0.12+
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- 1. Boot up Mason package manager
      require("mason").setup()
      
      -- 2. Define auto-install array
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls" }, -- Add servers like "pyright" or "ts_ls" here later
      })

      -- 3. Native Neovim 0.12+ API Loop: Setup servers without 'lspconfig'
      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        -- Register server configuration cleanly inside Neovim core
        vim.lsp.config(server, {})
        vim.lsp.enable(server)
      end

      -- 4. Native Shortcuts for LSP features
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
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
