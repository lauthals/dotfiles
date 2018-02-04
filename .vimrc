" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible                " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

" Now we set some defaults for the editor
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
syntax on
colorscheme monokai

filetype plugin indent on

let mapleader='-'

set autoindent
set autoread
set backupdir=~/.vim/backups,/tmp
set browsedir=current
set cursorline
set expandtab
set foldmethod=syntax
set formatoptions=c,q,r
set hidden
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:▸\ ,eol:¬
set nobackup
set noerrorbells
set nofoldenable
set noswapfile
set nowrap
set number
set relativenumber
set scrolloff=5
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set t_vb=
set tabstop=4
set undofile
set visualbell
set wildmenu
set wildmode=list:longest

"Auto commands
au FocusLost * :wa "automatic save on lost focus (gvim only)
au VimResized * wincmd = "handle resize problems with windows

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" To avoid weird pasting from other applications than vim.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

map - <nop>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader><Space> :noh<CR>
map <leader>n :NERDTreeToggle<CR>
map <C-y> :bn<CR>
nmap <silent> <leader>cc <leader>c<space>

" configure CtrlP
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'
" also find hidden files
let g:ctrlp_show_hidden = 1

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>pp :CtrlPMixed<cr>
nmap <leader>pb :CtrlPBuffer<cr>
nmap <leader>pm :CtrlPMRU<cr>

" configure Buffergator
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'T'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bb :BuffergatorToggle<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
