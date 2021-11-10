" PLUGINS =======================================================================
call plug#begin('~/.vim/plugged')
	Plug 'junegunn/goyo.vim'
	Plug 'wadackel/vim-dogrun'
	Plug 'jremmen/vim-ripgrep'
	Plug 'preservim/nerdtree'
	Plug 'vim-scripts/indentpython.vim'
	Plug 'vim-syntastic/syntastic'
	Plug 'nvie/vim-flake8'
	Plug 'kien/ctrlp.vim'
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()           

" GENERAL =======================================================================
filetype plugin on
set nocompatible           
set noshowmode
set noerrorbells
set laststatus=2
set tabstop=2
set shiftwidth=2
set nowrap
set noswapfile
set number relativenumber
set incsearch
set wildmode=longest,list,full
set ignorecase
set splitbelow splitright
colorscheme dogrun
syntax on
let python_highlight_all=1


" KEY MAPS =======================================================================
let mapleader = " "
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>pv :wincmd v<bar> :NERDTree <bar> :vertical resize 25<CR>
nnoremap <silent> <leader>pn :split<bar> :NERDTree <bar> :vertical resize 25<CR>
nnoremap <silent> <leader>pt :vertical botright :term<CR>
nnoremap <silent> <leader>tt :tabnew<CR>:NERDTree<CR>
nnoremap <silent> <leader>tc :tabclose<CR>
nnoremap <silent> <leader>1 <Esc>1gt
nnoremap <silent> <leader>2 <Esc>2gt
nnoremap <silent> <leader>3 <Esc>3gt
nnoremap <silent> <leader>4 <Esc>4gt
nnoremap <silent> <leader>5 <Esc>5gt
nnoremap <silent> <leader>6 <Esc>6gt
nnoremap <silent> <leader>7 <Esc>7gt
nnoremap <silent> <leader>8 <Esc>8gt
nnoremap <silent> <leader>pp :NERDTree<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <leader>f :Goyo<CR>
nnoremap <leader>s :!clear && shellcheck %<CR>
nnoremap <leader>r :!python %<CR>
inoremap <leader><TAB> <Esc>/<++><Enter>"_c4l

" AUTO COMMANDS =======================================================================
" automatically execute "zz" command (center the cursor region on the screen) when entering insert mode
autocmd InsertEnter * norm zz
" disable auto-commenting on new line after a comment
autocmd FileType * setlocal formatoptions-=c formatoptions -=r formatoptions-=o
" restart the respective program when written to config
autocmd BufWritePost xmonad.hs !xmonad --recompile && xmonad --restart
autocmd BufWritePost xmobarrc !killall xmobar && xmobar &
" SNIPPETS ----------------------------------------------------------------------------
" html
autocmd FileType html nnoremap ;! <Esc>:read ~/.vim/snippets/html/skeleton<CR>kdd/<++><Enter>"_c4l
autocmd FileType html inoremap ;1 <h1></h1><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;2 <h2></h2><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;3 <h3></h3><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;4 <h4></h4><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;5 <h5></h5><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;6 <h6></h6><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;p <p></p><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;s <span></span><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;S <script src=""><++></script><CR><++><Esc>k0f"a
autocmd FileType html inoremap ;a <a></a><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;b <b></b><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;i <i></i><CR><++><Esc>k0lf<i
autocmd FileType html inoremap ;d <div></div><CR><++><Esc>k0lf<i<CR><CR><UP><TAB>
autocmd FileType html inoremap ;b <b></b><CR><++><Esc>k0lf<i
" python
autocmd FileType python inoremap ;i from  import <++><Esc>0tii

" general
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap {<CR> {<CR><Esc>i}<CR><++><ESC>2ko
inoremap [<CR> [<CR><Esc>i]<CR><++><ESC>2ko
inoremap (<CR> (<CR><Esc>i)<CR><++><ESC>2ko


" FILE SPECIFIC SETTINGS =======================================================================
" python
au BufNewFile,BufRead *.py
	\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
" web development
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 softtabstop=2 shiftwidth=2


" LIGHTLINE SETTINGS =======================================================================
let g:lightline = {
	\ 'colorscheme': 'darcula',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead'
	\ },
		\ }




