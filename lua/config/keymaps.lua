local map = vim.keymap.set

-- Save and close
map("n", "<leader>q", ":q!<CR>", { desc = "Quit" })
map("n", "<leader>s", ":w!<CR>", { desc = "Save" })
map("n", "<leader>c", ":bdelete<CR>", { desc = "Close buffer" })

-- Session management
map("n", "<leader>Ss", ":mksession!<CR>", { desc = "Make session" })
map("n", "<leader>So", ":source Session.vim<CR>", { desc = "Source session" })

-- Config editing
map("n", "<leader>ve", ":vsplit $MYVIMRC<CR>", { desc = "Edit vimrc" })
map("n", "<leader>vs", ":source $MYVIMRC<CR>", { desc = "Source vimrc" })

-- Pandoc
map("n", "<leader>pt", ":TOC<CR>", { desc = "Open TOC" })
map("n", "<leader>pl", ":Pandoc! latex<CR>", { desc = "LaTeX compilation" })
map("n", "<leader>pb", ":Pandoc! beamer<CR>", { desc = "Beamer compilation" })
map("n", "<leader>pd", ":!pandoc -s -o %:r.pdf % -V papersize:A4<CR>", { desc = "Compile A4 document" })
map("n", "<leader>po", ":!zathura %:r.pdf&<CR><CR>", { desc = "Open in Zathura" })

-- Text operations
map("n", "<leader>ol", [[:%s/\. \(\u\)/\.\r\1/g<CR>]], { desc = "One sentence per line" })
map("n", "<leader>ep", [[:%s/\(^[^%].*\n\)\(\\begin{equation}\(\n.*\)\{-}\n\\end{equation}\)/\1%\r\2\r%/g<CR>]], { desc = "Surround equation with comment" })
map("n", "<leader>n", ":%s///gn <CR>", { desc = "Count last search" })

-- Increment/decrement
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>x", '"+x', { desc = "Cut to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Buffer navigation
map("n", "<leader>1", ":bp<CR>", { desc = "Previous buffer" })
map("n", "<leader>2", ":bn<CR>", { desc = "Next buffer" })
map("n", "<leader>d", ":bd<CR>", { desc = "Delete buffer" })

-- Avoid accidental Ex mode
map("n", "Q", "<nop>")

-- Save all / quit all
map("n", "<C-s>", ":wall<CR>", { desc = "Save all" })
map("n", "<C-q>", ":qall<CR>", { desc = "Quit all" })

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Window resize
map("n", "<A-j>", ":resize -2<CR>", { silent = true })
map("n", "<A-k>", ":resize +2<CR>", { silent = true })
map("n", "<A-h>", ":vertical resize -2<CR>", { silent = true })
map("n", "<A-l>", ":vertical resize +2<CR>", { silent = true })

-- Move percentage across screen line
map("n", "gm", function()
    local count = vim.v.count
    if count == 0 then count = 49 end
    local col = count * vim.fn.winwidth(0) / 100
    vim.cmd("normal! " .. col .. "|")
end, { silent = true, desc = "Move percentage across screen line" })

-- Bufferline pick
map("n", "gb", ":BufferLinePick<CR>", { silent = true, desc = "Buffer pick" })
map("n", "gD", ":BufferLinePickClose<CR>", { silent = true, desc = "Buffer pick close" })

-- Spelling
map("n", "<F2>", ":setlocal spell! spelllang=en<CR>", { desc = "Toggle spell check" })
map("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Auto-fix spelling" })

-- Insert mode text transforms
map("i", "<C-u>", "<Esc>viwUea", { silent = true, desc = "Uppercase word" })
map("i", "<C-t>", "<Esc>b~lea", { silent = true, desc = "Title case word" })

-- Visual mode: indent controls
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Visual mode: move lines (The Primeagen)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Terminal escape
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })

-- Bibtex-tidy
map("n", "<localleader>bt", function()
    vim.cmd("!bibtex-tidy --align --space=4 --duplicates --merge=combine " .. vim.fn.fnameescape(vim.fn.expand("%:p")))
end, { desc = "Format bibtex file" })
