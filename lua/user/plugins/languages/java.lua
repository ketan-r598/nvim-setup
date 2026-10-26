return {
    {
        "JavaHello/spring-boot.nvim",
        ft = { "java", "yaml", "jproperties" },
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {}, -- runs setup(), which enables the "spring-boot" server
    },
}
