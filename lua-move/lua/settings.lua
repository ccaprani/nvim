vim.cmd([[
syntax on
set encoding=utf-8
" set guicursor=
set noshowmatch
set relativenumber
" set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
" Do not wrap over-length lines
set nowrap               
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=4
set noshowmode
" Give more space for displaying messages.
set cmdheight=2     
" Shorter updatetime (default is 4000 ms = 4 s) 
set updatetime=50   
" Open new split below
set splitbelow      
set splitright
set colorcolumn=80
set laststatus=3
highlight ColorColumn ctermbg=0 guibg=lightgrey


" -- Plugin Specific Settings

" -- Colorscheme settings
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
" -- For bad spellings to be highlighted
let g:gruvbox_guisp_fallback = "bg"
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" --Tabs
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
nmap <leader>d :bd<CR>
 
" --Startify
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

" --Nerdtree
" --let NERDTreeMinimalUI = 1
" --let NERDTreeDirArrows = 1
" --nnoremap  <leader>f :NERDTreeToggle<CR>
" --nmap <leader>nf :NERDTreeFind<CR>
" --autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" --" next few ensure NT opens in current file folder
" --set autochdir
" --let NERDTreeChDirMode=2

" --Completion
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

]])


-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                {key = "?", action = "toggle_help"},
                {key="<CR>", action = "edit_no_picker"},
            },
        },
    }
})

-- C++ LSP config
require("ccls").setup({
    lsp = {
        -- Check `:help vim.lsp.start` for config options.
        server = {
            name = "ccls",  -- String name.
            cmd = { "ccls" },  -- Point to your binary, has to be a table.
            args = {},
            autostart = false,  -- Does not seem to work here.
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

   win_config = {
       -- Sidebar configuration.
       sidebar = {
           size = 50,
           position = "topleft",
           split = "vnew",
           width = 50,
           height = 20,
       },

       -- Floating window configuration. check :help nvim_open_win for options.
       float = {
           style = "minimal",
           relative = "cursor",
           width = 50,
           height = 20,
           row = 0,
           col = 0,
           border = "rounded",
       },
   },

    filetypes = {"c", "cpp"},
})

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



-- pretty gutter icons
vim.fn.sign_define('DapStopped', { text='▶', texthl='WarningMsg',linehl='DapUIBreakpointsCurrentLine', numhl='ModeMsg'})
vim.fn.sign_define('DapBreakpoint', { text='●', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', { text='⊕', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', { text='!!', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', { text='⨷', texthl='ErrorMsg', linehl='', numhl=''})

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
 bufnr = bufnr or 0
 line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
 opts = opts or {['lnum'] = line_nr}
--
 local line_diagnostics = vim.diagnostic.get(bufnr, opts)
 if vim.tbl_isempty(line_diagnostics) then return end
--
 local diagnostic_message = ""
 for i, diagnostic in ipairs(line_diagnostics) do
   diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
   print(diagnostic_message)
   if i ~= #line_diagnostics then
     diagnostic_message = diagnostic_message .. "\n"
   end
 end
 vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
--end

vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]
