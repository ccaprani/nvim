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
set scrolloff=4
set noshowmode
set cmdheight=2     " Give more space for displaying messages.
set updatetime=50   " Shorter updatetime (default is 4000 ms = 4 s) 
set splitbelow      " Open new split below
set splitright
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

let mapleader=" "   " g Leader key
let maplocalleader=" "
nnoremap <Space> <Nop>  
" avoid getting into ex mode accidently
nnoremap Q <nop> 
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
"Shortcuts to edit and source init.vim in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

let g:python3_host_prog = expand('/usr/bin/python')

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" File explorer
Plug 'scrooloose/nerdtree'
" File search
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Latex support
Plug 'ludovicchabant/vim-gutentags'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
"Startify
Plug 'mhinz/vim-startify'
" Code completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hrsh7th/nvim-compe' 
" lspconfig
Plug 'neovim/nvim-lspconfig'
" The Tim Pope Collection
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
" Highlight the yanked region
Plug 'machakann/vim-highlightedyank'
" Markdown & Pandoc - tabular must come first
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Python support
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'psf/black' ", { 'branch': 'stable' }
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'savq/melange'
" Tagbar
Plug 'majutsushi/tagbar'
" REPL
" Plug 'urbainvaes/vim-ripple', { 'branch': 'testing' } 
Plug 'urbainvaes/vim-ripple'
" Plug 'sillybun/vim-repl'  " not supporting neovim yet
" Debugger and window maximize
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" CSV viewer
Plug 'chrisbra/csv.vim'
" The famous treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'mhartington/formatter.nvim'
Plug 'ray-x/lsp_signature.nvim' 
" Make escaping quicker - no lag
Plug 'jdhao/better-escape.vim'
" Code minimap
" Plug 'wfxr/minimap.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" ---- VIM-ONLY KEY BINDINGS ----

" nnoremap <space> za " Folding - open

" Spellings on/off with F6
map <F2> :setlocal spell! spelllang=en<CR>
" <C-l> for auto-fix of 1st suggested spelling in INSERT mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" System Clipboard shortcuts
noremap <Leader>y "+y
noremap <Leader>p "+p

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
vnoremap <tab> >gv
" Shift+Tab to unindent in visual mode.
vnoremap <S-tab> <gv

" Tab settings
" augroup tab_settings
"         autocmd!
"         autocmd FileType c,cpp,vim,sh,python setlocal expandtab shiftwidth=8 tabstop=8 softtabstop=8 smarttab
"         autocmd FileType text,tex,latex,context,plaintex,make setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 smarttab
" augroup END

" Wrap lines settings
augroup wrap_settings
        autocmd!
        autocmd FileType c,cpp setlocal wrap textwidth=80
        autocmd FileType vim,sh,python,make,text setlocal nowrap
        autocmd FileType tex,latex,context,plaintex setlocal wrap
augroup END

" Autoindenting settings
" augroup indent_settings
"         autocmd!
"         autocmd FileType c,cpp,python,vim,sh setlocal autoindent cindent copyindent
"         autocmd FileType tex,latex,context,plaintex,make setlocal autoindent copyindent
"         autocmd FileType text setlocal noautoindent
" augroup END

" Remember folds of non-help files
set viewoptions-=options
augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* if &ft !=# 'help' | mkview | endif
    autocmd BufWinEnter *.* if &ft !=# 'help' | silent! loadview | endif
augroup END

" Turn the word under cursor to upper case
inoremap <silent> <C-u> <Esc>viwUea
" Turn the current word into title case
inoremap <silent> <C-t> <Esc>b~lea
" The Primeagen - Moving text lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ---- Plugin Specific Settings

" Better escape
" let g:better_escape_shortcut = ['jk', 'jj', 'kj']

" Ripple
" let g:ripple_repls = { "python": ["ipython", "", "", 0] }
" let g:ripple_delay="500ms"
" let g:ripple_sleep_hack="500ms"
" let g:ripple_always_return = 1

" Minimap
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
nnoremap <leader>mm :MinimapToggle<cr>

" Colorscheme settings
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_guisp_fallback = "bg"     " For bad spellings to be highlighted
 colorscheme gruvbox
" colorscheme melange
set background=dark

" Tabs
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
nmap <leader>d :bd<CR>
 
" Startify
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
" let g:startify_bookmarks = [
"             \ { 'i': '~/.config/nvim/init.vim' },
"             " \ { 'p': '~/Google Drive/~Research/Code/Python' },
"             \ ]

" Tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>

" Nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap  <leader>f :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" next few ensure NT opens in current file folder
set autochdir
let NERDTreeChDirMode=2

" Completion
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

" Find files using telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Format files on save
lua << EOF
require("formatter").setup {
  filetype = {
    python = {
      function()
        return {exe = "black", args = {"-q", "-"}, stdin = true}
      end,
    },
  },
}
require "lsp_signature".setup()
EOF

" Run black on save
autocmd BufWritePre *.py execute ':Black'

" Latex Settings
function! PythonTexCompile()
    silent !clear
    call vimtex#compiler#compile_ss()
    " 1. Use single quotes unless you need escape sequences
    " 2. b:vimtex.tex expands to the filename of the main file, so this
    "    should work for multifile projects
    execute '!pythontex' fnameescape(b:vimtex.tex)
    call vimtex#compiler#compile_ss()
endfunction

" tex conceal
set conceallevel=1
hi Conceal ctermbg=none
let g:tex_conceal='abdmg'
let g:tex_flavor='latex'
" Vimtex settings
let g:vimtex_compiler_progname="nvr"
let g:vimtex_quickfix_mode=2
if has('win32')
    " use SumatraPDF if you are on Windows
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options 
                \ = '-reuse-instance -forward-search @tex @line @pdf'
else
    " Otherwise use Zathura on Linux
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

"Pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown", "rst"]
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#command#custom_open = "MyPandocOpen"
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#keyboard#use_default_mappings = 1
"letg:pandoc#command#prefer_pdf
function! MyPandocOpen(file)
    " return 'xdg-open '. a:file
    if has('win32')
       return 'SumatraPDF ' . shellescape(expand(a:file,':p'))
    else
       return 'zathura --synctex-forward'
                   \. line('.')
                   \. ':' . col('.')
                   \. ':' . shellescape(expand('%:p'))
                   \. shellescape(expand(a:file,':p'))
    endif
endfunction

nnoremap <leader>pt :TOC<cr>
nnoremap <leader>pl :Pandoc! latex<cr>
nnoremap <leader>pb :Pandoc! beamer<cr>

" Ultisnips
if has('win32')
    let g:UltiSnipsSnippetsDir='%localappdata%/nvim/UltiSnips'
else
    let g:UltiSnipsSnippetsDir='~/.config/nvim/UltiSnips'
endif
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" Python
autocmd BufNewFile,BufRead *.py set foldmethod=indent

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
" let g:vimspector_install_gadgets = ['debugpy']

" Maximizer
" nnoremap <leader>m :MaximizerToggle!<cr>
nnoremap <leader>m :MaximizerToggle<CR>

" Snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"LSP settings
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.texlab.setup{}
EOF
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>

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
