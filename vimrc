set nocompatible

" Required for Vundle
filetype off

" Vundle and Bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'

"Required for SnipMate
filetype plugin on

Bundle 'msanders/snipmate.vim'

" Buffers
set encoding=utf-8

" Display
set rulerformat=%l:%c ruler
set shortmess=atI
set titlestring=%f title
set ttyfast

" Editting
filetype plugin indent on
set pastetoggle=<f2>
syntax on

" Searching
set incsearch
set gdefault
set hlsearch
set ignorecase
set smartcase

" Programming language autocommands
au BufNewFile,BufRead *.rb set filetype=ruby expandtab shiftwidth=2 tabstop=2 commentstring=\ #\ %s
au BufNewFile,BufRead *.py set filetype=python expandtab shiftwidth=4 tabstop=4 commentstring=\ #\ %s
au BufNewFile,BufRead *.c set filetype=c cindent expandtab shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.js set filetype=javascript expandtab shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.scm set filetype=scheme lisp autoindent expandtab shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.rkt set filetype=racket lisp autoindent expandtab shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.clj set filetype=clojure lisp autoindent expandtab shiftwidth=2 tabstop=2

" Enable omni completion
au FileType ruby set omnifunc=rubycomplete#Complete
au FileType ruby let g:rubycomplete_buffer_loading=1
au FileType ruby let g:rubycomplete_classes_in_global=1
au FileType ruby setlocal makeprg=ruby\ %

au FileType python set omnifunc=pythoncomplete#Complete
au FileType python let g:rubycomplete_buffer_loading=1
au FileType python let g:rubycomplete_classes_in_global=1
au FileType python setlocal makeprg=python\ %

" NERDTree configuration
au VimEnter * NERDTree
au VimEnter * NERDTreeToggle
noremap <silent> <F10> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
command Tree execute "NERDTree"

