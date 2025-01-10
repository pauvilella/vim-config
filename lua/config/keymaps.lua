local keymap = vim.keymap

-- Quickly quit
keymap.set({ "n" }, "<leader>q", ":xa<cr>", { noremap = true, silent = true, desc = "Save and quit all buffers" })
-- Save all files
keymap.set({ "n" }, "<leader>w", ":wa<cr>", { noremap = true, silent = true, desc = "Save all buffers" })

-- Select all
keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { noremap = true, silent = true, desc = "Select all" })

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

-- Remove highlight after search
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Remove highlight search" })

-- Helps with text search and text replace
-- rw: Replace Word (under cursor) starting from the cursor until the end of the file
keymap.set("n", "<leader>rw", [[:,$s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
-- rwa: Replce All Words (under cursor) starting from the beginning of the file until the end of the file
keymap.set("n", "<leader>raw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
-- sw: Search Word (under cursor)
keymap.set("n", "<leader>sw", [[:/\<<C-r><C-w>\><CR>]])
-- rw: Replace All Words (under selection) starting from the cursor until the end of the file
keymap.set("v", "<leader>rw", [["hy:,$s/<C-r>h/<C-r>h/gc<left><left><left>]])
-- raw: Replace All Words (under selection) starting from the beginning of the file until the end of the file
keymap.set("v", "<leader>raw", [["hy:%s/<C-r>h/<C-r>h/gc<left><left><left>]])
-- sw: Search Word (under selection)
keymap.set("v", "<leader>sw", [["hy:<C-u>/\V<C-r>=escape(@h, '/\\')<CR><CR>]])

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true, desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true, desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true, desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { noremap = true, silent = true, desc = "Close current split" }) -- close current split window

-- Source files
keymap.set('', '<leader>rr', ':source %<cr>',
  { noremap = true, silent = true, desc = "Source the current file (double r: Reload)" })
