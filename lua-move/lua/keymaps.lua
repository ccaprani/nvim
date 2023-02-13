vim.cmd([[
" -- g Leader key
let mapleader=" "   
let maplocalleader=" "
nnoremap <Space> <Nop>  
" -- avoid getting into ex mode accidently
nnoremap Q <nop> 
" -- let localleader=" "
tnoremap <Esc> <C-\><C-n>
" -- Wicked save and close bind
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>s :w!<CR>
nnoremap <Leader>c :bp\|bd #<CR>
" -- Session management in vim
nnoremap <leader>ss :mksession!<CR>
nnoremap <leader>so :source Session.vim<CR>
" -- Shorcuts to save and quit a session
nnoremap <C-s> :wall<cr>
nnoremap <C-q> :qall<CR>
" -- Shortcuts to edit and source init.vim in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" -- My own mapping for making sentences on One Line only
nnoremap <leader>ol :%s/\. \(\u\)/\.\r\1/g<cr>
" -- Move precentage way across screen line, [count]gm
nnoremap <silent> gm :<C-U>exe 'normal! ' . (v:count ? v:count : 49)*winwidth(0)/100 . '\|'<cr>


" -- ---- VIM-ONLY KEY BINDINGS ----

" -- nnoremap <space> za " Folding - open

" -- Count occurences of last search /
nnoremap <leader>n :%s///gn <CR>

" -- increment/decrement numbers
nnoremap + <C-a>
nnoremap - <C-x>

" -- Spellings on/off with F6
map <F2> :setlocal spell! spelllang=en<CR>
" -- <C-l> for auto-fix of 1st suggested spelling in INSERT mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" -- System Clipboard shortcuts
noremap <Leader>y "+y
noremap <Leader>p "+p

" -- Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -- Use alt + hjkl to resize windows
map <silent> <A-j>    :resize -2<CR>
map <silent> <A-k>    :resize +2<CR>
map <silent> <A-h>    :vertical resize -2<CR>
map <silent> <A-l>    :vertical resize +2<CR>

" -- Indent controls
" -- Reselect text ater indent/unindent.
vnoremap < <gv
vnoremap > >gv
" -- Tab to indent in visual mode.
vnoremap <tab> >gv
" -- Shift+Tab to unindent in visual mode.
vnoremap <S-tab> <gv

" -- Tab settings
" -- augroup tab_settings
" --         autocmd!
" --         autocmd FileType c,cpp,vim,sh,python setlocal expandtab shiftwidth=8 tabstop=8 softtabstop=8 smarttab
" --         autocmd FileType text,tex,latex,context,plaintex,make setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 smarttab
" -- augroup END

" -- Wrap lines settings
augroup wrap_settings
        autocmd!
        autocmd FileType c,cpp setlocal wrap textwidth=80
        autocmd FileType vim,sh,python,make,text setlocal nowrap
        autocmd FileType tex,latex,context,plaintex setlocal wrap
augroup END

" -- Autoindenting settings
" -- augroup indent_settings
" --         autocmd!
" --         autocmd FileType c,cpp,python,vim,sh setlocal autoindent cindent copyindent
" --         autocmd FileType tex,latex,context,plaintex,make setlocal autoindent copyindent
" --         autocmd FileType text setlocal noautoindent
" -- augroup END

" -- Remember folds of non-help files
set viewoptions-=options
augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* if &ft !=# 'help' | mkview | endif
    autocmd BufWinEnter *.* if &ft !=# 'help' | silent! loadview | endif
augroup END

" -- Turn the word under cursor to upper case
inoremap <silent> <C-u> <Esc>viwUea
" -- Turn the current word into title case
inoremap <silent> <C-t> <Esc>b~lea
" -- The Primeagen - Moving text lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv



" -- nvim-tree 
nnoremap <leader>f :NvimTreeToggle<CR>

" -- Find files using telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>



" -- Bibtex-tidy, install using:
" -- sudo npm install -g bibtex-tidy

nnoremap <localleader>bt :execute "!bibtex-tidy --align --space=4 --duplicates --merge=combine " -- . fnameescape(expand('%:p'))<cr>

" -- Pandoc mappings  
nnoremap <leader>pt :TOC<cr>
nnoremap <leader>pl :Pandoc! latex<cr>
nnoremap <leader>pb :Pandoc! beamer<cr>
nnoremap <leader>pd :!pandoc -s -o %:r.pdf % -V papersize:A4<cr>
nnoremap <leader>po :!zathura %:r.pdf&<cr><cr>

" --Tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>

]])


-- Mappings (just hit F5 to kick the whole thing off, <leader>dt to terminate)
vim.keymap.set('n', '<F5>', function() require"dap".continue() end)
vim.keymap.set('n', '<F6>', function() require"dap".step_over() end)
vim.keymap.set('n', '<F7>', function() require"dap".step_out() end)
vim.keymap.set('n', "<F8>", function() require"dap".step_into() end)
vim.keymap.set('n', '<leader>db', function() require"dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dt', function() require"dap".terminate() end)
vim.keymap.set('n', '<leader>dR', function() require"dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end)
vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end)
vim.keymap.set('n', '<leader>dA', function() require"debugHelper".attachToRemote() end)
vim.keymap.set('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
vim.keymap.set('n', '<leader>dp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
vim.keymap.set('n', '<leader>dl', ':lua require"dap".run_last()<CR>')
