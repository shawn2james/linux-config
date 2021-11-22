vim.cmd[[
colorscheme dogrun
syntax on
filetype plugin on
set matchpairs+=<:>
set ignorecase smartcase
set nohlsearch
set encoding=UTF-8
set completeopt-=preview
set shiftwidth=2
set whichwrap=<,>,[,]
set noshowmode
set hidden
set noerrorbells
set scrolloff=12
set laststatus=2
set pastetoggle=<F2> 
set tabstop=4
set number relativenumber
set shiftwidth=2
set smartindent
set nowrap
set noswapfile
set wildmode=longest,list,full
set colorcolumn=140
set splitbelow splitright
set inccommand=nosplit
set clipboard=unnamedplus
]]

vim.g.mapleader = " "
vim.api.nvim_set_keymap('', "<C-j>", "ddp", { silent = true, noremap=true })
vim.api.nvim_set_keymap('', "<C-k>", "ddkkp", { silent = true, noremap=true })
