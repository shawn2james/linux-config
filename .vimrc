set nocompatible           

" Create the `tags` file (may need to install ctags first) 
command! MakeTags !ctags -R .

" Provides tab-completion for all file-related tasks
set path+=** 

" PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
call vundle#end()           
filetype plugin indent on    

set noshowmode
set laststatus=2
set relativenumber
set clipboard=unnamedplus
set ignorecase
syntax on
let python_highlight_all=1

" automatically execute "zz" command (center the cursor region on the screen) when entering insert mode
autocmd InsertEnter * norm zz

if $TERM =~ "alacritty"
	let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
	let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

au BufNewFile,BufRead *.py
	\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 softtabstop=2 shiftwidth=2

map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

let g:lightline = {
	\ 'colorscheme': 'darcula',
	\ }
