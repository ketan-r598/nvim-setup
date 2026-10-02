return {
  -- 1. Install the spring-boot.nvim plugin to handle Spring integration
  {
    "JavaHello/spring-boot.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Keeps load order clean
    },
  },

  -- 2. Treesitter & Native LSP configurations
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Fetch Spring Boot jar paths automatically from the plugin
      local springboot_bundles = require("spring-boot").init_lsp_bundles()

      -- Configure Neovim's native jdtls configuration layer with Spring bundles
      vim.lsp.config("jdtls", {
        init_options = {
          bundles = springboot_bundles,
        },
      })
      vim.lsp.enable("jdtls")

      -- Register and enable the Spring Boot LSP for property/yaml autocompletion
      vim.lsp.config("spring_boot", {
        filetypes = { "groovy", "java", "properties", "yaml", "yml" },
        settings = {
          spring_boot = {
            ls = {
              java = {
                home = os.getenv("JAVA_HOME"), -- Grabs system JAVA_HOME automatically
              },
            },
          },
        },
      })
      vim.lsp.enable("spring_boot")

      -- Ensure syntax highlighting is active for Java files
      require("nvim-treesitter").setup({
        ensure_installed = { "java" },
      })
    end,
  },
}
