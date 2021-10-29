set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4
set relativenumber
set ignorecase
syntax on

" automatically execute "zz" command (center the cursor region on the screen) when entering insert mode
autocmd InsertEnter * norm zz
" automatically remove trailing whitespaces when file saved
" autocmd BufWritePre * %s/\s\$%\\e
