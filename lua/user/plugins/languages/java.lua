-- The real server jar, next to its lib/ folder (Mason's share/ copy has no lib/).
-- glob() finds it by pattern, so a version change after a Mason update still works.
local ls_jar = vim.fn.glob(vim.fn.stdpath("data")
    .. "/mason/packages/vscode-spring-boot-tools/extension/language-server/spring-boot-language-server-*-exec.jar")

return {
    {
        "JavaHello/spring-boot.nvim",
        ft = { "java", "yaml", "jproperties" },
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {
            ls_path = ls_jar ~= "" and ls_jar or nil,
        },
    },
}
