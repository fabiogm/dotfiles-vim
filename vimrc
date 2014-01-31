" .vimrc config file

" let Vundle manage Vundle
" https://github.com/gmarik/vundle
" $ vim +BundleInstall +qall
" (or from vim) :BundleInstall
"
" Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

set nocompatible               " be iMproved
filetype off                   " required!

syntax enable
set backspace=2

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Put Bundles here
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'msanders/snipmate.vim'
Bundle 'davidhalter/jedi-vim'

filetype plugin indent on     " required!

" Shell like behavior(not recommended) (but I like it!).
set completeopt+=longest
inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"


" custom vimrc configuration here
set t_Co=256
set encoding=utf-8

set hlsearch " Highlight searches
set number   " show line numbers

set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4

" Set tags file. Search in the current directory and then walks up the tree.
set tags=./tags;/

set list
set listchars=tab:→\ ,trail:.,extends:#,nbsp:.

" Highlight extra white spaces
" Those lines to:
"   - Create the ExtraWhitespace hl group
"   - Match trailing spaces
"   - This will ensure all themes get it
"   - Makes sure that trailing spaces are highlighted once out of insert mode
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+\%#\@<!$/
" match ErrorMsg '\%>80v.\+'
" au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * redraw!

" This are to move the divisions around for split sessions
noremap <silent> ] <C-W>++
noremap <silent> [ <C-W>-
noremap <silent> } <C-W>>
noremap <silent> { <C-W><
noremap <silent> <C-J> <C-W>j<C-W>_
noremap <silent> <C-K> <C-W>k<C-W>_

set wmh=0			" sets the minimum window height to 0


" To replace spaces with tabs :set noet|retab!
" Following commands are to set filetype specifics like ruby files to be
" indented with tabs of 2 spaces.
au BufNewFile,BufRead *.rb set filetype=ruby expandtab shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.js,*.js.rb,*.js.erb set filetype=javascript noexpandtab shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.less set filetype=less noexpandtab shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.haml set filetype=haml expandtab shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.py,*.pm set filetype=python expandtab shiftwidth=4 tabstop=4

" Enable omni completion.
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType c set omnifunc=ccomplete#Complete

au FileType ruby set omnifunc=rubycomplete#Complete
au FileType ruby let g:rubycomplete_buffer_loading=1
au FileType ruby let g:rubycomplete_classes_in_global=1

" use solarized by default
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" NERDTree configuration
au VimEnter * NERDTree
au VimEnter * NERDTreeToggle

noremap <silent> <F10> :NERDTreeToggle<CR>

let g:NERDTreeDirArrows=0
command Tree execute "NERDTree"

" Delete buffer while keeping window layout (don't close buffer windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
echohl ErrorMsg
echomsg a:msg
echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
if empty(a:buffer)
let btarget = bufnr('%')
elseif a:buffer =~ '^\d\+$'
let btarget = bufnr(str2nr(a:buffer))
else
let btarget = bufnr(a:buffer)
endif
if btarget < 0
call s:Warn('No matching buffer for '.a:buffer)
return
endif
if empty(a:bang) && getbufvar(btarget, '&modified')
call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
return
endif
" Numbers of windows that view target buffer which we will delete.
let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
if !g:bclose_multiple && len(wnums) > 1
call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
return
endif
let wcurrent = winnr()
for w in wnums
execute w.'wincmd w'
let prevbuf = bufnr('#')
if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
buffer #
else
bprevious
endif
if btarget == bufnr('%')
" Numbers of listed buffers which are not the target to be deleted.
let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
" Listed, not target, and not displayed.
let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
" Take the first buffer, if any (could be more intelligent).
let bjump = (bhidden + blisted + [-1])[0]
if bjump > 0
execute 'buffer '.bjump
else
execute 'enew'.a:bang
endif
endif
endfor
execute 'bdelete'.a:bang.' '.btarget
execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')
nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>

" Rewrite bg color for the set list
hi SpecialKey ctermbg=234
set nolist
