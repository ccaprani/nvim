
require("telescope").setup()
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension(  "file_browser" )

-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')
