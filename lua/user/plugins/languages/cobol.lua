return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      -- 1. Create a dynamic detector for extensionless COBOL files
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("CobolExtensionlessDetector", { clear = true }),
        pattern = "*",
        callback = function()
          -- Get the current file extension
          local ext = vim.fn.expand("%:e")
          -- If the file has no extension at all
          if ext == "" then
            -- Read the first 5 lines of the file to scan for COBOL keywords
            local lines = vim.api.nvim_buf_get_lines(0, 0, 5, false)
            local content = table.concat(lines, "\n"):upper()
            
            -- If it contains traditional COBOL markers, force Neovim to treat it as COBOL
            if content:find("IDENTIFICATION DIVISION") or content:find("PROGRAM-ID") or content:find("PROCEDURE DIVISION") then
              vim.bo.filetype = "cobol"
            end
          end
        end,
      })

      -- 2. Auto-install the COBOL Language Server via Mason
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "cobol_ls" }, 
      })

      -- 3. Modern Neovim 0.12+ API: Bind COBOL server
      vim.lsp.config("cobol_ls", {})
      vim.lsp.enable("cobol_ls")

      -- 4. Download structural COBOL highlighting rules
      require("nvim-treesitter").setup({
        ensure_installed = { "cobol" },
      })
    end,
  }
}
