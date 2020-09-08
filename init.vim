syntax on
set encoding=utf-8
"set guicursor=
set noshowmatch
set relativenumber
"set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap                " Do not wrap over-length lines
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set cmdheight=2     " Give more space for displaying messages.
set updatetime=50   " Shorter updatetime (default is 4000 ms = 4 s) 
set splitbelow      " Open new split below
set splitright
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

let mapleader=" "   " g Leader key
nnoremap <Space> <Nop>  
" let localleader=" "
tnoremap <Esc> <C-\><C-n>
" Wicked save and close bind
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>s :w!<CR>
" Session management in vim
nnoremap <leader>ss :mksession!<CR>
nnoremap <leader>so :source Session.vim<CR>
" Shorcuts to save and quit a session
nnoremap <C-s> :wall<cr>
nnoremap <C-q> :qall<CR>

call plug#begin('~/AppData/Local/nvim/plugged')

" File explorer
Plug 'scrooloose/nerdtree'
" File search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Latex support
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
" Snippets
Plug 'sirver/ultisnips'
"Startify
Plug 'mhinz/vim-startify'
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Surround.vim
Plug 'tpope/vim-surround'
" Commenting
Plug 'tpope/vim-commentary' 
" Markdown & Pandoc - tabular must come first
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Python support
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
" REPL
Plug 'sillybun/vim-repl'
call plug#end()


" ---- VIM-ONLY KEY BINDINGS ----


" Spellings on/off with F6
map <F6> :setlocal spell! spelllang=en<CR>
" <C-l> for auto-fix of 1st suggested spelling in INSERT mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" System Clipboard shortcuts
noremap <Leader>y "*y
noremap <Leader>p "*p

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use alt + hjkl to resize windows
map <silent> <A-j>    :resize -2<CR>
map <silent> <A-k>    :resize +2<CR>
map <silent> <A-h>    :vertical resize -2<CR>
map <silent> <A-l>    :vertical resize +2<CR>

" Indent controls
" Reselect text ater indent/unindent.
vnoremap < <gv
vnoremap > >gv
" Tab to indent in visual mode.
vnoremap <Tab> >gv
" Shift+Tab to unindent in visual mode.
vnoremap <S-Tab> <gv

"Faster ESC.
inoremap jk <ESC>
inoremap kj <ESC>

" Turn the word under cursor to upper case
inoremap <silent> <C-u> <Esc>viwUea
" Turn the current word into title case
inoremap <silent> <C-t> <Esc>b~lea
" The Primeagen - Moving text lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" ---- Plugin Specific Settings


" Colorscheme settings
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_guisp_fallback = "bg"     " For bad spellings to be highlighted
colorscheme gruvbox
set background=dark

" Tabs
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
nmap <leader>n :bd<CR>
" Open Starify on new tab - confuses other windows though
"" autocmd TabNewEntered * Startify

" Nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap  <leader>f :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" next few ensure NT opens in current file folder
set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

" Latex Settings
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_latexmk_continuous = 1
hi Conceal ctermbg=none
" let g:vimtex_compiler_progname = 'nvr'
" use SumatraPDF if you are on Windows
let g:vimtex_view_general_viewer = 'SumatraPDF'
" Otherwise, on Linux
"let g:vimtex_view_method='zathura'
let g:vimtex_view_general_options 
            \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_toc_config = {
    \'split_pos'   : ':vert :botright',
    \'split_width':  50,
    \}
function! PythonTexCompile()
    " Why do you need to do :clearjumps here?
    silent !clear
    call vimtex#compiler#compile_ss()
    " 1. Use single quotes unless you need escape sequences
    " 2. b:vimtex.tex expands to the filename of the main file, so this
    "    should work for multifile projects
    " execute '!pythontex ' . b:vimtex.tex
    execute '!pythontex' fnameescape(b:vimtex.tex)
    call vimtex#compiler#compile_ss()
endfunction
nnoremap <f5> :call PythonTexCompile()<cr>
nnoremap <silent> <leader>lc :VimtexCompile<cr>
nnoremap <silent> <leader>lv :VimtexView<cr>
vnoremap <silent> <leader>ls :VimtexCompileSelected<cr>
nnoremap <silent> <leader>li :VimtexInfo<cr>
nnoremap <silent> <leader>lt :VimtexTocToggle<cr>

"Pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown", "rst"]
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#command#custom_open = "MyPandocOpen"
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
"letg:pandoc#command#prefer_pdf
function! MyPandocOpen(file)
   return 'SumatraPDF ' . shellescape(expand(a:file,':p'))
endfunction

" Python
autocmd BufNewFile,BufRead *.py set foldmethod=indent
"Folding - open
nnoremap <space> za 

" Snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" COC Settings
"command! -nargs=0 Prettier :CocCommand prettier.formatFile
" inoremap <silent><expr> <C-space> coc#refresh()
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart
