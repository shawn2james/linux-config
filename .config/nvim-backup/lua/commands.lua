vim.api.nvim_set_keymap("n", "<Leader>ot", ":!alacritty --working-directory %:p:h &<CR><CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>Y", ":Goyo<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>S", ":!clear && shellcheck %<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<Leader><TAB>", '/<++><Enter>"_c41', {silent = true, noremap = true})
