vim.cmd([[
let g:python3_host_prog = expand('/usr/bin/python')

" -- Run black on save
autocmd BufWritePre *.py execute ':Black'

" -- Latex Settings
function! PythonTexCompile()
    silent !clear
    call vimtex#compiler#compile_ss()
    -- 1. Use single quotes unless you need escape sequences
    -- 2. b:vimtex.tex expands to the filename of the main file, so this
    --    should work for multifile projects
    execute '!pythontex' fnameescape(b:vimtex.tex)
    call vimtex#compiler#compile_ss()
endfunction

" -- tex conceal
set conceallevel=1
hi Conceal ctermbg=none
let g:tex_conceal='abdmg'
let g:tex_flavor='latex'
" -- Vimtex settings
let g:vimtex_compiler_progname="nvr"
let g:vimtex_quickfix_mode=2
if has('win32')
    " -- use SumatraPDF if you are on Windows
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options 
                \ = '-reuse-instance -forward-search @tex @line @pdf'
else
    " -- Otherwise use Zathura on Linux
    let g:vimtex_view_general_viewer  = 'zathura'
    let g:vimtex_view_method='zathura'
endif
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
let g:vimtex_toc_config = {
    \'split_pos'   : ':vert :botright',
    \'split_width':  50,
    \}

" -- Pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown", "rst"]
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#command#custom_open = "MyPandocOpen"
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#keyboard#use_default_mappings = 1
" -- letg:pandoc#command#prefer_pdf
function! MyPandocOpen(file)
    if has('win32')
        return 'SumatraPDF ' . shellescape(expand(a:file,':p'))
    else
        let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
        return "zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"md$","pdf", "")
        -- return 'xdg-open '. a:file
   endif
endfunction

" -- Ultisnips
if has('win32')
    let g:UltiSnipsSnippetsDir='%localappdata%/nvim/UltiSnips'
else
    let g:UltiSnipsSnippetsDir='~/.config/nvim/UltiSnips'
endif
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" -- let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" -- Python
autocmd BufNewFile,BufRead *.py set foldmethod=indent

" -- Snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


" Add support for markdown files in tagbar.
if has('win32')
    let g:md_ctags_bin=fnamemodify(stdpath('config')."\\tools\\markdown2ctags.exe", ":p")
else
    let g:md_ctags_bin=fnamemodify(stdpath('config')."/tools/markdown2ctags.py", ":p")
endif
let g:tagbar_type_pandoc = {
    \ 'ctagstype': 'pandoc', 
    \ 'ctagsbin' : g:md_ctags_bin,
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
    \ }
]])
