" PLUGINS =======================================================================
call plug#begin('~/.vim/plugged')
	Plug 'vimwiki/vimwiki'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'jiangmiao/auto-pairs'
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
call plug#end()           

" GENERAL =======================================================================
filetype plugin on
set nocompatible           
let NERDTreeShowHidden=1
set completeopt-=preview
set noshowmode
set clipboard=unnamedplus
set hidden
set noerrorbells
set scrolloff=8
set laststatus=2
set pastetoggle=<F2> 
set tabstop=2
set shiftwidth=2
set smartindent
set nowrap
set noswapfile
set number relativenumber
set incsearch
set wildmode=longest,list,full
set ignorecase
set colorcolumn=120
set smartcase
set splitbelow splitright

" APPEARANCE ---------------------------------------------------------------------
colorscheme dogrun
syntax on
let python_highlight_all=1
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" KEY MAPS =======================================================================
let mapleader = " "
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>pv :wincmd v<bar> :NERDTree <bar> :vertical resize 25<CR>
nnoremap <silent> <leader>pp :NERDTreeToggle<CR>
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
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>+ :vertical resize 80<CR>
nnoremap <leader>f :Goyo<CR>
nnoremap <leader>s :!clear && shellcheck %<CR>
nnoremap <leader>r :!python %<CR>
inoremap <leader><TAB> <Esc>/<++><Enter>"_c4l
map <C-j> ddp
map <C-k> ddkkp

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" AUTO COMMANDS =======================================================================
" automatically execute "zz" command (center the cursor region on the screen) when entering insert mode
autocmd InsertEnter * norm zz
" disable auto-commenting on new line after a comment
autocmd FileType * setlocal formatoptions-=c formatoptions -=r formatoptions-=o
" restart the respective program when written to config
autocmd BufWritePost xmonad.hs !xmonad --recompile && xmonad --restart
autocmd BufWritePost xmobarrc !killall xmobar && xmobar &
autocmd BufWritePost dunstrc !killall dunst && dunst &
" SNIPPETS ----------------------------------------------------------------------------
" html
autocmd FileType html inoremap ;! <Esc>:read ~/.vim/snippets/html/skeleton<CR><Esc>kdd3jt<a
autocmd FileType html inoremap ;1 <h1></h1><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;2 <h2></h2><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;3 <h3></h3><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;4 <h4></h4><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;5 <h5></h5><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;6 <h6></h6><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;p <p></p><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;s <span></span><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;s <script src=""><++></script><CR><++><Esc>k0f"a
autocmd filetype html inoremap ;a <a></a><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;b <b></b><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;i <i></i><CR><++><Esc>k0lf<i
autocmd filetype html inoremap ;d <div></div><CR><++><Esc>k0lf<i<CR><CR><UP><TAB>
autocmd filetype html inoremap ;b <b></b><CR><++><Esc>k0lf<i
" python
autocmd filetype python inoremap ;i from  import <++><Esc>0tii

" FILE SPECIFIC SETTINGS =======================================================================
" python
au BufNewFile,BufRead *.py
	\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
" web development
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 softtabstop=2 shiftwidth=2
" files to ignore in NERDTree
let NERDTreeIgnore=['\.DS_Store$', '\.git$'] 

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

let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'python': 'python', 'js': 'js', 'haskell': 'haskell', 'bash': 'bash'}
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_list = [wiki]

