return require("packer").startup(function (use) 
	use "wbthomason/packer.nvim"
	use 'mattn/emmet-vim'
	use { 'neoclide/coc.nvim', branch="release" }
	use 'jiangmiao/auto-pairs'
	use 'vimwiki/vimwiki'
	use 'junegunn/goyo.vim'
	use 'wadackel/vim-dogrun'
	use 'morhetz/gruvbox'
	use 'jremmen/vim-ripgrep'
	use 'preservim/nerdcommenter'
	use 'vim-scripts/indentpython.vim'
	use 'vim-syntastic/syntastic'
	use 'nvie/vim-flake8'
	use 'itchyny/lightline.vim'
	use 'tpope/vim-fugitive'
	use 'nvim-telescope/telescope.nvim'
	use 'BurntSushi/ripgrep'
	use 'nvim-lua/plenary.nvim'
end)

