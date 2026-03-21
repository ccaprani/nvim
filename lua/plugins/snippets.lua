return {
    "sirver/ultisnips",
    dependencies = { "honza/vim-snippets" },
    enabled = vim.fn.has("win32") == 0 or vim.fn.exepath("python") ~= "",
    config = function()
        vim.g.UltiSnipsSnippetDirectories = { "UltiSnips" }
        vim.g.UltiSnipsExpandTrigger = "<tab>"
        vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
        vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
        vim.g.UltiSnipsEditSplit = "vertical"

        -- Snippet directory (platform-dependent)
        if vim.fn.has("win32") == 1 then
            vim.g.UltiSnipsSnippetsDir = vim.fn.expand("%localappdata%/nvim/UltiSnips")
        else
            vim.g.UltiSnipsSnippetsDir = vim.fn.expand("~/.config/nvim/UltiSnips")
        end
    end,
}
