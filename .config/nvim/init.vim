" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible                " Use Vim defaults instead of 100% vi compatibility

filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" Now we set some defaults for the editor
syntax on
colorscheme monokai

filetype plugin indent on

let mapleader='ö'

set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=~/.vim/backups,/tmp
set browsedir=current
set cursorline
set expandtab
set foldmethod=syntax
set formatoptions=c,q,r
set hidden
set history=50
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:▸\ ,eol:¬
set nobackup
set noerrorbells
set nofoldenable
set noswapfile
set wrap
set number
set relativenumber
set ruler
set scrolloff=5
set shiftwidth=4
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

inoremap <C-h> <C-d>
inoremap <C-l> <C-t>
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <leader><Space> :noh<CR>
nnoremap <leader>bq :bp <BAR> bd #<cr>
nnoremap <leader>Eo <C-w><C-v><C-l>:e ~/.oni/config.js<cr>
nnoremap <leader>eo :e ~/.oni/config.js<cr>
nnoremap <leader>Ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>s <C-w>s<C-w>l
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <silent> <leader>cc <leader>c<space>
noremap <C-y> :buffer #<CR>
noremap <leader>n :NERDTreeToggle<CR>

" ==================== CTRLP =========================
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
nnoremap <leader>ö :CtrlP<cr>

" =================== BUFFERGATOR =====================
" configure Buffergator
" Use the top of the screen
let g:buffergator_viewport_split_policy = 'T'
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1
" Go to the previous buffer open
nnoremap <leader>jj :BuffergatorMruCyclePrev<cr>
" Go to the next buffer open
nnoremap <leader>kk :BuffergatorMruCycleNext<cr>
" View the entire list of buffers open
nnoremap <leader>bb :BuffergatorToggle<cr>

