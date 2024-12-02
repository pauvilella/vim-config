local keymap = vim.keymap

-- Quickly quit
keymap.set({ "n" }, "<leader>q", ":xa<cr>", { noremap = true, silent = true, desc = "Save and quit all buffers" })
-- Save all files
keymap.set({ "n" }, "<leader>w", ":wa<cr>", { noremap = true, silent = true, desc = "Save all buffers" })

-- <J> and <K> move the seleted line(s) up & down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- For easily indenting lines
keymap.set('v', '>', '>gv', { noremap = true, silent = true, desc = "after tab in re-select the same" })
keymap.set('v', '<', '<gv', { noremap = true, silent = true, desc = "after tab out re-select the same" })

-- For easily search results and have the cursor on the middle of the screen so I don't get loget lostt
keymap.set('n', 'n', 'nzzzv',
  { noremap = true, silent = true, desc = "Goes to the next result on the seach and put the cursor in the middle" })
keymap.set('n', 'N', 'Nzzzv',
  { noremap = true, silent = true, desc = "Goes to the prev result on the seach and put the cursor in the middle" })

-- Deletes to the void register
keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Nothing done when <Q> is pressed
keymap.set("n", "Q", "<nop>")

-- Helps with text substitution
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true, desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true, desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true, desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { noremap = true, silent = true, desc = "Close current split" }) -- close current split window

-- Source files
keymap.set('', '<leader>rr', ':source %<cr>',
  { noremap = true, silent = true, desc = "Source the current file (double r: Reload)" })
