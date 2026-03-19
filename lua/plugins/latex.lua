return {
    -- Vimtex
    {
        "lervag/vimtex",
        ft = { "tex", "latex" },
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.tex_conceal = "abdmg"
            vim.g.vimtex_compiler_progname = "nvr"
            vim.g.vimtex_quickfix_mode = 2

            -- PDF viewer: platform-dependent
            if vim.fn.has("win32") == 1 then
                vim.g.vimtex_view_general_viewer = "SumatraPDF"
                vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            else
                vim.g.vimtex_view_general_viewer = "zathura"
                vim.g.vimtex_view_method = "zathura"
            end

            vim.g.vimtex_compiler_latexmk = {
                options = {
                    "-pdf",
                    "-shell-escape",
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }
            vim.g.vimtex_toc_config = {
                split_pos = ":vert :botright",
                split_width = 50,
            }

            -- PythonTeX compile function
            vim.api.nvim_create_user_command("PythonTexCompile", function()
                vim.cmd("silent !clear")
                vim.fn["vimtex#compiler#compile_ss"]()
                vim.cmd("!pythontex " .. vim.fn.fnameescape(vim.b.vimtex.tex))
                vim.fn["vimtex#compiler#compile_ss"]()
            end, {})
        end,
    },
    -- TeX conceal
    {
        "KeitaNakamura/tex-conceal.vim",
        ft = { "tex", "latex" },
    },
    -- Pandoc
    {
        "vim-pandoc/vim-pandoc",
        dependencies = { "vim-pandoc/vim-pandoc-syntax" },
        ft = { "pandoc", "markdown", "rst" },
        config = function()
            vim.g["pandoc#filetypes#handled"] = { "pandoc", "markdown", "rst" }
            vim.g["pandoc#modules#disabled"] = { "folding" }
            vim.g["pandoc#command#custom_open"] = "MyPandocOpen"
            vim.g["pandoc#command#autoexec_command"] = "Pandoc! pdf"
            vim.g["pandoc#keyboard#use_default_mappings"] = 1

            -- Custom Pandoc open function
            vim.cmd([[
                function! MyPandocOpen(file)
                    if has('win32')
                        return 'SumatraPDF ' . shellescape(expand(a:file,':p'))
                    else
                        let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
                        return "zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"md$","pdf", "")
                    endif
                endfunction
            ]])
        end,
    },
    -- Tabular (must come before vim-markdown)
    { "godlygeek/tabular" },
}
