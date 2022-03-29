call plug#begin("~/.vim/plugged")
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'dracula/vim'
Plug 'honza/vim-snippets'
call plug#end()
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula
set number
