set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
set showcmd
set ruler
set encoding=utf-8
set showmatch
set relativenumber
set laststatus=2

so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
so ~/.vim/keymaps.vim

" APARECIA
if (has("termguicolors"))
 set termguicolors
endif
syntax enable 
colorscheme  OceanicNext

