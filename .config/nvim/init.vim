" PLUGINS 
" =========================================================================================
call plug#begin('~/.vim/plugged')
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'wadackel/vim-dogrun'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'kvrohit/substrata.nvim'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
call plug#end()           

" GENERAL 
" =========================================================================================
filetype plugin on
set matchpairs+=<:>
set ignorecase smartcase 
set nohlsearch
set encoding=UTF-8
set completeopt-=preview
set whichwrap=<,>,[,]
set noshowmode
set hidden
set noerrorbells
set clipboard=unnamedplus
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

" APPEARANCE 
" =========================================================================================
colorscheme gruvbox
hi Normal ctermbg=NONE guibg=NONE

" KEY MAPS 
" =========================================================================================
let mapleader = " "
" window commands
" -----------------------------------------------------------------------------------------
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>wv :vs<CR>
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <leader>+ <C-w>= 
" open commands
" -----------------------------------------------------------------------------------------
nnoremap <silent> <leader>ot :!alacritty --working-directory %:p:h &<CR><CR>

" tab commands
" -----------------------------------------------------------------------------------------
nnoremap <silent> <leader>ct :tabclose<CR>
nnoremap <silent> <leader>1 <Esc>1gt
nnoremap <silent> <leader>2 <Esc>2gt
nnoremap <silent> <leader>3 <Esc>3gt
nnoremap <silent> <leader>4 <Esc>4gt
nnoremap <silent> <leader>5 <Esc>5gt
nnoremap <silent> <leader>6 <Esc>6gt
nnoremap <silent> <leader>7 <Esc>7gt
nnoremap <silent> <leader>8 <Esc>8gt
" general commands
" -----------------------------------------------------------------------------------------
nnoremap <leader>Y :Goyo<CR>
nnoremap <leader>s :!clear && shellcheck %<CR>
nnoremap <leader><TAB> /<++><Enter>"_c4l
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nmap gr <Plug>(coc-references)
map <C-j> ddp
map <C-k> ddkkp
nnoremap <leader>/ :%s/\v/gc<Left><Left><Left>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" AUTO COMMANDS
" =========================================================================================
" automatically execute "zz" command (center the cursor region on the screen) when entering insert mode
" autocmd InsertEnter * norm zz
" disable auto-commenting on new line after a comment
autocmd FileType * setlocal formatoptions-=c formatoptions -=r formatoptions-=o
" restart the respective program when written to config
autocmd BufWritePost xmonad.hs !xmonad --recompile && xmonad --restart
autocmd BufWritePost xmobarrc !killall xmobar && xmobar &
autocmd BufWritePost config.h !sudo make install
autocmd BufWritePost dunstrc !killall dunst && dunst &

" SNIPPETS 
" -----------------------------------------------------------------------------------------
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
" python
autocmd filetype python inoremap ;i from  import <++><Esc>0tii
autocmd filetype python nnoremap <leader>r :!python %<CR>
" vimwiki
autocmd filetype vimwiki inoremap ;b {{{bash}}}<Esc>0f}i<CR><CR><Esc>o<++><Esc>2ki
autocmd filetype vimwiki nnoremap <leader>r :Vimwiki2HTML<CR><CR>
" autocmd filetype vimwiki nnoremap <leader>pc :!pandoc --verbose -f vimwiki -t pdf "%" > "/home/shawn/wikipdf/%:t.pdf"<CR>
" lua
autocmd filetype lua nnoremap <leader>r :!lua %<CR>

" FILE SPECIFIC SETTINGS 
" =========================================================================================
" python
au BufNewFile,BufRead *.py
	\ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
" web development
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=4 softtabstop=4 shiftwidth=4

" PLUGIN SETTINGS 
" =========================================================================================

" lightline
" -----------------------------------------------------------------------------------------
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

" vimwiki
" -----------------------------------------------------------------------------------------
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'python': 'python', 'js': 'js', 'haskell': 'haskell', 'bash': 'bash'}
let g:vimwiki_list = [wiki]

" nerdcommenter
" -----------------------------------------------------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1
