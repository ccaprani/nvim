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
set scrolloff=4
set noshowmode
set cmdheight=2     " Give more space for displaying messages.
set updatetime=50   " Shorter updatetime (default is 4000 ms = 4 s) 
set splitbelow      " Open new split below
set splitright
set colorcolumn=80
set laststatus=3
highlight ColorColumn ctermbg=0 guibg=lightgrey

let g:python3_host_prog = expand('/usr/bin/python')

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" File explorer
" Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" File search
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
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
Plug 'hrsh7th/nvim-compe' 
" lspconfig
Plug 'neovim/nvim-lspconfig'
Plug 'ranjithshegde/ccls.nvim'
"Plug 'm-pilia/vim-ccls'
" UI stuff
" Plug 'folke/noice.nvim'
" Plug 'MunifTanjim/nui.nvim'
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
Plug 'morhetz/gruvbox'
" Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Tagbar
Plug 'majutsushi/tagbar'
" REPL
Plug 'urbainvaes/vim-ripple'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
" CSV viewer
Plug 'chrisbra/csv.vim'
" The famous treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'ray-x/lsp_signature.nvim' 
" Whichkey
Plug 'folke/which-key.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" ---- VIM-ONLY KEY BINDINGS ----

let mapleader=" "
let maplocalleader=" "

lua << EOF

vim.opt.termguicolors = true
local bufferline = require('bufferline')
bufferline.setup{
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = "buffer_id",
        close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        -- name_formatter = function(buf)  -- buf contains:
              -- name                | str        | the basename of the active file
              -- path                | str        | the full path of the active file
              -- bufnr (buffer only) | int        | the number of the active buffer
              -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
              -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        --end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
--        custom_filter = function(buf_number, buf_numbers)
--            -- filter out filetypes you don't want to see
--            if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
--                return true
--            end
--            -- filter out by buffer name
--            if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
--                return true
--            end
--            -- filter out based on arbitrary rules
--            -- e.g. filter out vim wiki buffer from tabline in your work repo
--            if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
--                return true
--            end
--            -- filter out by it's index number in list (don't show first buffer)
--            if buf_numbers[1] ~= buf_number then
--                return true
--            end
--        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        },
        color_icons = true, -- whether or not to add the filetype icon highlights
        get_element_icon = function(element)
          -- element consists of {filetype: string, path: string, extension: string, directory: string}
          -- This can be used to change how bufferline fetches the icon
          -- for an element e.g. a buffer or a tab.
          -- e.g.
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "slant",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        sort_by = 'insert_at_end'
    }
}

require("which-key").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
}

local wk = require("which-key")

wk.register({
    -- Save and close binds
    q = { ":q!<CR>", "Quit" },
    s = {":w!<CR>", "Save"},
    c = {":bdelete<CR>", "Close"},
    -- c = {":bp\\|bd #<CR>", "Close"},

    -- Session management
    S = {
        name = "+Session",
        s = {":mksession!<CR>", "Make session"},
        o = {":sourse Session.vim<CR>", "Source session"},
        },

    -- Init editing
    v = {
        name = "+Vim",
        e = {":vsplit $MYVIMRC<CR>", "Edit vimrc" },
        s = {":source $MYVIMRC<CR>", "Source vimrc" },
        },

    -- Pandoc
    p = {
        name = "+Pandoc",
        t = {":TOC<cr>", "Open TOC"},
        l = {":Pandoc! latex<cr>", "LaTeX compilation"},
        b = {":Pandoc! beamer<cr>","Beamer compilation"},
        d = {":!pandoc -s -o %:r.pdf % -V papersize:A4<cr>", "Compile A4 document"},
        o = {":!zathura %:r.pdf&<cr><cr>","Open in Zathura"},
        },

    -- My own mapping for making sentences on One Line only
    ["ol"] = {":%s/\\. \\(\\u\\)/\\.\\r\\1/g<cr>", "One sentence per line" },
    -- For surrounding latex equations with comments so they are in paragraph
    ["ep"] = {":%s/\\(^[^%].*\\n\\)\\(\\\\begin{equation}\\(\\n.*\\)\\{-}\\n\\\\end{equation}\\)/\\1%\\r\\2\\r%/g<cr>","Surround equation with comment"},

    -- Change visual highlight to title case
    --["tc"] = {":s/\\%V\\<\\(\\w\\)\\(\\S*\\)/\\u\\1\\L\\2/g","Visual selection to Title Case"},
    --["tc"] = {":%s/item/mine/g<cr>","Visual selection to Title Case", mode='v'},

    -- Count occurences of last search /
    n = { ":%s///gn <CR>", "Count last search" },

    -- Increment/decrement numbers
    ["+"] = {"<C-a>", "Increment number"},
    ["-"] = {"<C-x>", "Decrement number"},

}, { prefix = "<leader>" })

-- These do not have <leader>
wk.register({

    -- Avoid getting into Ex mode accidently
    Q = {"<nop>", "Avoid accidental Ex mode"},

    -- Shorcuts to save and quit a session
    ["<C-s>"] = {":wall<CR>", "Save all"},
    ["<C-q>"] = {":qall<CR>", "Quit all"},

    -- Move percentage
    ["gm"] = {"<silent> gm :<C-U>exe 'normal! ' . (v:count ? v:count : 49)*winwidth(0)/100 . '\\|'<cr>", "Move percentage across screen line"},

    -- Bufferlinepick
    ["gb"] = {"<silent> gb :BufferLinePick<CR>", "Buffer pick"},
    ["gD"] = {"<silent> gb :BufferLinePickClose<CR>", "Buffer pick close"},

}, {})

-- The function is called `t` for `termcodes`.
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Terminal mode
wk.register({
    ["<Esc>"] = { t("<C-\\><C-N>"),  "Escape terminal mode" },
},{mode='t'})

EOF

" nnoremap <space> za " Folding - open
"
" nnoremap <Space> <Nop>  
" avoid getting into ex mode accidently
" nnoremap Q <nop> 
" let localleader=" "
" tnoremap <Esc> <C-\><C-n>
" Wicked save and close bind
" nnoremap <Leader>q :q!<CR>
" nnoremap <Leader>s :w!<CR>
" nnoremap <Leader>c :bp\|bd #<CR>
" Session management in vim
" nnoremap <leader>ss :mksession!<CR>
" nnoremap <leader>so :source Session.vim<CR>
" Shorcuts to save and quit a session
" nnoremap <C-s> :wall<cr>
" nnoremap <C-q> :qall<CR>
"Shortcuts to edit and source init.vim in vertical split
" nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr>
" My own mapping for making sentences on One Line only
" nnoremap <leader>ol :%s/\. \(\u\)/\.\r\1/g<cr>
" Move precentage way across screen line, [count]gm
" nnoremap <silent> gm :<C-U>exe 'normal! ' . (v:count ? v:count : 49)*winwidth(0)/100 . '\|'<cr>

" Count occurences of last search /
" nnoremap <leader>n :%s///gn <CR>

" increment/decrement numbers
" nnoremap + <C-a>
" nnoremap - <C-x>

" Spellings on/off with F6
map <F2> :setlocal spell! spelllang=en<CR>
" <C-l> for auto-fix of 1st suggested spelling in INSERT mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" System Clipboard shortcuts
noremap <Leader>y "+y
noremap <Leader>x "+x
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

" Colorscheme settings
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_guisp_fallback = "bg"     " For bad spellings to be highlighted
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" Tabs
let g:airline_theme='gruvbox'
" let g:airline_powerline_fonts = 1
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

" Tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>

" Nerdtree
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" nnoremap  <leader>f :NERDTreeToggle<CR>
" nmap <leader>nf :NERDTreeFind<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " next few ensure NT opens in current file folder
" set autochdir
" let NERDTreeChDirMode=2

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

lua << EOF
require("telescope").setup()
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension(  "file_browser" )

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', '<CR>', api.node.open.no_window_picker, opts('Open: No Window Picker'))
end

-- empty setup using defaults
require("nvim-tree").setup({
    on_attach = on_attach,
    view = {
        adaptive_size = false,
        },
--    mappings = {
--            list = {
--                { key = "u", action = "dir_up" },
--                {key = "?", action = "toggle_help"},
--                {key="<CR>", action = "edit_no_picker"},
--            }
--        },
})


local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })


-- C++ LSP config
require("ccls").setup({
    lsp = {
        -- Check `:help vim.lsp.start` for config options.
        server = {
            name = "ccls",  -- String name.
            cmd = { "ccls" },  -- Point to your binary, has to be a table.
            args = {},
            -- autostart = false,  -- Does not seem to work here.
            offset_encoding = "utf-32",  -- Default value set by plugin.
            root_dir = vim.fs.dirname(vim.fs.find({ "compile_commands.json", ".git" }, { upward = true })[1]),
            init_options = {
                index = {
                    threads = 0;
                };

                clang = {
                    excludeArgs = { "-frounding-math" };
                };
            },
            -- |> Fix diagnostics.
            flags = lsp_flags,
            -- |> Attach LSP keybindings & other crap.
            on_attach = aum_general_on_attach,
            -- |> Add nvim-cmp or snippet completion capabilities.
            capabilities = completion_capabilities,
            -- |> Activate custom handlers.
            handlers = aum_handler_config,
        },
    },

--    win_config = {
--        -- Sidebar configuration.
--        sidebar = {
--            size = 50,
--            position = "topleft",
--            split = "vnew",
--            width = 50,
--            height = 20,
--        },
--
--        -- Floating window configuration. check :help nvim_open_win for options.
--        float = {
--            style = "minimal",
--            relative = "cursor",
--            width = 50,
--            height = 20,
--            row = 0,
--            col = 0,
--            border = "rounded",
--        },
--    },

    filetypes = {"c", "cpp"},
})

-- require("noice").setup({lsp = { signature = { enabled = false }}})
EOF

" nvim-tree 
nnoremap <leader>f :NvimTreeToggle<CR>

" Find files using telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>

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
" Bibtex-tidy, install using:
" sudo npm install -g bibtex-tidy

nnoremap <localleader>bt :execute "!bibtex-tidy --align --space=4 --duplicates --merge=combine " . fnameescape(expand('%:p'))<cr>

" See vimtex--faq-treesitter
lua << EOF
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "python", "lua", "help", "vim", "cmake", "markdown" },
    highlight = {
           enable = true,
           disable = { "latex" },
           additional_vim_regex_highlighting = { "latex", "markdown" },
    },
    --other treesitter settings
}
EOF

"Pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown", "rst"]
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#command#custom_open = "MyPandocOpen"
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#keyboard#use_default_mappings = 1
"letg:pandoc#command#prefer_pdf
function! MyPandocOpen(file)
    if has('win32')
        return 'SumatraPDF ' . shellescape(expand(a:file,':p'))
    else
        let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
        return "zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"md$","pdf", "")
        "" return 'xdg-open '. a:file
   endif
endfunction

" nnoremap <leader>pt :TOC<cr>
" nnoremap <leader>pl :Pandoc! latex<cr>
" nnoremap <leader>pb :Pandoc! beamer<cr>
" nnoremap <leader>pd :!pandoc -s -o %:r.pdf % -V papersize:A4<cr>
" nnoremap <leader>po :!zathura %:r.pdf&<cr><cr>

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

" Snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" nvim-dap
lua << EOF
-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

require('dap-python').setup('~/anaconda3/bin/python')
require('dap-python').test_runner = 'pytest'
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position.
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.5 },
        --"breakpoints",
        "stacks",
        "watches",
      },
      size = 50,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})
-- 

-- dap gui auto listenting to dap events
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- pretty gutter icons
vim.fn.sign_define('DapStopped', { text='▶', texthl='WarningMsg',linehl='DapUIBreakpointsCurrentLine', numhl='ModeMsg'})
vim.fn.sign_define('DapBreakpoint', { text='●', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', { text='⊕', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', { text='!!', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', { text='⨷', texthl='ErrorMsg', linehl='', numhl=''})

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
EOF

lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.texlab.setup{}
-- sudo snap install ccls --classic
require'lspconfig'.ccls.setup{}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>i', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>F', '<cmd>lua vim.lsp.buf.format{async=true}<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'texlab', 'ccls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

--function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--  bufnr = bufnr or 0
--  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--  opts = opts or {['lnum'] = line_nr}
--
--  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--  if vim.tbl_isempty(line_diagnostics) then return end
--
--  local diagnostic_message = ""
--  for i, diagnostic in ipairs(line_diagnostics) do
--    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--    print(diagnostic_message)
--    if i ~= #line_diagnostics then
--      diagnostic_message = diagnostic_message .. "\n"
--    end
--  end
--  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
--end

-- vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]
EOF



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
