" General Settings
set number " show line numbers
set relativenumber " set relative line numbers
syntax enable " enable syntax highlighting
set showmatch " show matching brackets/parentheses 

" Set native file explore to tree style
" vim.g:netrw_liststyle = 3

" Exit insert mode with 'jk'
inoremap jk <ESC>

" Test exiting insert mode with 'jj'
inoremap jj <ESC>

" Indentation Settings
set expandtab " use spaces instead of tabs 
set tabstop=4
set shiftwidth=4

" UI Settings 
set laststatus=2 " always show status bar
set wrap " wrap long lines
set encoding=utf-8

" Vundle Plugin Manager Settings
set nocompatible " ensures VI is not used instead of VIM: required for Vundle 
filetype off " required for Vundle

" Set runtime path for Vim plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Additional Plugins
Plugin 'preservim/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim' 
Plugin 'vim-airline/vim-airline'
Plugin 'morhetz/gruvbox'

call vundle#end() 
filetype plugin indent on 
set t_Co=256
syntax on
" Colorscheme
colorscheme gruvbox

" Other Configuration Here
" "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
