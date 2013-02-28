" The ArchLinux global vimrc - setting only a few sane defaults
"
" Maintainer:      Tobias Kieslich [tobias funnychar archlinux dot org]
"
" NEVER EDIT THIS FILE, IT'S OVERWRITTEN UPON UPGRADES, GLOBAL CONFIGURATION
" SHALL BE DONE IN /etc/vimrc, USER SPECIFIC CONFIGURATION IN ~/.vimrc

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible                " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing

" Now we set some defaults for the editor
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
syntax on

" My own changes: "
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'minibufexpl.vim'
Bundle 'The-NERD-tree'
Bundle 'joonty/vim-phpqa.git'
Bundle 'SuperTab'
Bundle 'Command-T'

filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab
set backupdir=~/.vim/backups,/tmp
set number
set hlsearch
set incsearch
set formatoptions=c,q,r
set background=dark
set browsedir=current
set autoindent
set smartindent
set scrolloff=5
set foldmethod=syntax
set nofoldenable
set colorcolumn=81
colors evening

let g:SuperTabDefaultCompletionType = ""

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

nnoremap <F3> :NERDTreeToggle<CR>

" To avoid weird pasting from other applications than vim.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

" LaTeX:
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
