-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
    -- File explorer
    -- Plug 'scrooloose/nerdtree'
    use 'nvim-tree/nvim-web-devicons' -- optional, for file icons
    use 'nvim-tree/nvim-tree.lua'
    -- File search
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Latex support
    use 'ludovicchabant/vim-gutentags'
    use 'lervag/vimtex'
    use 'KeitaNakamura/tex-conceal.vim'
    -- Snippets
    use 'sirver/ultisnips'
    use 'honza/vim-snippets'
    -- Startify
    use 'mhinz/vim-startify'
    -- Code completion
    use 'hrsh7th/nvim-compe' 
    -- lspconfig
    use 'neovim/nvim-lspconfig'
    use 'ranjithshegde/ccls.nvim'
    --use 'm-pilia/vim-ccls'
    -- UI stuff
	use {
	    'folke/noice.nvim',
	    event = 'VimEnter',
	    config = function()
		require 'plugins.noice'
	    end,
	    requires = { 'MunifTanjim/nui.nvim', module = 'nui' },
	}

    -- The Tim Pope Collection
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary' 
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    -- Highlight the yanked region
    use 'machakann/vim-highlightedyank'
    -- Markdown & Pandoc - tabular must come first
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
    --use 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    use 'vim-pandoc/vim-pandoc'
    use 'vim-pandoc/vim-pandoc-syntax'
    -- Python support
    use 'jiangmiao/auto-pairs'
    use 'Vimjas/vim-python-pep8-indent'
    use 'psf/black' --", { 'branch': 'stable' }
    -- Git
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    -- Themes
    use 'morhetz/gruvbox'
    -- use 'gruvbox-community/gruvbox'
    -- use 'sainnhe/gruvbox-material'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    -- Tagbar
    use 'majutsushi/tagbar'
    -- REPL
    use 'urbainvaes/vim-ripple'
        -- Debugger adapter protocol
        use {
            'mfussenegger/nvim-dap',
            config = function()
                require('plugins.dapui').setup()
            end,
            opt = true,
            requires = 'rcarriga/nvim-dap-ui',
        }
        
    use {'mfussenegger/nvim-dap-python', requires = 'mfussenegger/nvim-dap'}
    
	-- WhichKey
	use {
	    'folke/which-key.nvim',
	    config = function()
		require('which-key').setup {
		    show_help = false,
		    show_keys = false,
		    layout = { layout = { spacing = 15 } },
		    window = { border = 'single' },
		}
	    end,
	}
   
    
    -- CSV viewer
    use 'chrisbra/csv.vim'
    -- The famous treesitter
    -- use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}  -- We recommend updating the parsers on update
         -- TreeSitter
        use {
            { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
            { 'p00f/nvim-ts-rainbow', event = 'BufReadPre' },
            { 'nvim-treesitter/nvim-treesitter-textobjects', module = 'nvim-treesitter.textobjects' },
            { 'nvim-treesitter/playground', module = 'nvim-treesitter-playground' },
            { 'Badhi/nvim-treesitter-cpp-tools', ft = { 'c', 'cpp', 'opencl' } },
            {
                'ThePrimeagen/refactoring.nvim',
                module = 'refactoring',
                config = function()
                    require('plugins.treesitter').refactoring()
                end,
            },
        }

    
    
    -- use 'nvim-telescope/telescope-file-browser.nvim'    
    -- use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-dap.nvim'
        -- Telescope
        use {
            {
                'nvim-telescope/telescope.nvim',
                module = 'telescope',
                cmd = 'Telescope',
                config = function()
                    require('plugins.telescope').telescope()
                end,
                requires = 'nvim-lua/plenary.nvim',
            },
            { 'nvim-telescope/telescope-fzf-native.nvim', opt = true, run = 'make' },
            { 'nvim-telescope/telescope-project.nvim', after = 'telescope.nvim' },
            { 'nvim-telescope/telescope-file-browser.nvim', module_pattern = '.*.extensions.file_browser.*' },
        }

    
    
    
    use 'mhartington/formatter.nvim'
    use 'ray-x/lsp_signature.nvim' 

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
