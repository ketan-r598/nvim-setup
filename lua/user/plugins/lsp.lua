return {
    -- CHANGED: added. Gives Neovim the start command for each server.
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },

    -- Core Package Manager & Native LSP Config
    {
        "williamboman/mason.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("mason").setup()

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            local signs = { Error = "  ", Warn = "  ", Hint = "  ", Info = "  " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    prefix = "●",
                },
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })
        end,
    },

    -- Autocompletion Engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "echasnovski/mini.icons",
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
                    { name = "nvim_lsp" }, -- CHANGED: was "nvim-lsp" (wrong name)
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, vim_item)
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
