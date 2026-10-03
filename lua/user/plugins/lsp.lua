return {
  -- Core Package Manager & Native LSP Config
  {
    "williamboman/mason.nvim",
    lazy = false, -- Boot immediately so language servers can hook into it
    priority = 1000,
    config = function()
      require("mason").setup()

      -- Native Neovim 0.12+ configuration for the baseline Lua environment
      vim.lsp.config("lua_ls", {})
      vim.lsp.enable("lua_ls")

      -- 1. Setup modern Nerd Font symbols in the left gutter (Fixed for strict cell widths)
      local signs = { Error = "  ", Warn = "  ", Hint = "  ", Info = "  " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- 2. Fine-tune diagnostic layout behaviors
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = "●", -- Elegant minimal dot for inline error text
        },
        severity_sort = true,
        float = {
          border = "rounded", -- Smooth rounded windows for error popups
          source = "always",
        },
      })
    end,
  },

  -- Autocompletion Engine (Enhanced with mini.icons)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "echasnovski/mini.icons", -- Hooked to look up completion symbols
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
        -- 3. Format autocompletion item types (Function, Variable, Class) using mini.icons
        formatting = {
          format = function(entry, vim_item)
            -- Fetch the completion item icon using mini.icons
            local kind = vim_item.kind
            local icon, _, _ = require("mini.icons").get("lsp", kind)
            if icon then
              vim_item.kind = icon .. " " .. kind
            end
            return vim_item
          end,
        },
      })
    end,
  },
}
