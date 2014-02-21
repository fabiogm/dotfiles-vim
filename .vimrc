set nocompatible

" Required for Vundle
filetype off

" Vundle and Bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'

"Required for SnipMate
filetype plugin on

Bundle 'msanders/snipmate.vim'

" Buffers
set encoding=utf-8

" Display
"set rulerformat=%l:%c ruler
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

au BufNewFile,BufRead *.rb set filetype=ruby expandtab shiftwidth=2 tabstop=2 commentstring=\ #\ %s
au BufNewFile,BufRead *.py set filetype=python expandtab shiftwidth=4 tabstop=4 commentstring=\ #\ %s
au BufNewFile,BufRead *.c set filetype=c cindent expandtab shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.js set filetype=javascript expandtab shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.scm set filetype=scheme lisp expandtab shiftwidth=2 tabstop=2 autoindent
au BufNewFile,BufRead *.rkt set filetype=racket lisp expandtab shiftwidth=2 tabstop=2 autoindent
" TODO. All the indentation for Clojure files will be placed in a indent plugin
" file.
au BufNewFile,BufRead *.clj set filetype=clojure 

au FileType ruby set omnifunc=rubycomplete#Complete
au FileType ruby let g:rubycomplete_buffer_loading=1
au FileType ruby let g:rubycomplete_classes_in_global=1
au FileType ruby setlocal makeprg=ruby\ %

au FileType python set omnifunc=pythoncomplete#Complete
au FileType python let g:rubycomplete_buffer_loading=1
au FileType python let g:rubycomplete_classes_in_global=1
au FileType python setlocal makeprg=python\ %

" use solarized by default
 set background=light
 let g:solarized_termcolors=256
 colorscheme solarized

" NERDTree configuration
au VimEnter * NERDTree
au VimEnter * NERDTreeToggle
noremap <silent> <F10> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
command Tree execute "NERDTree"

set statusline=
set statusline +=\ %n\ %*     " bufer number
set statusline +=%y%*         " file type
set statusline +=\ %<%F%*     " full path
set statusline +=%m%*         " modified flag
set statusline +=%=%5l%*      " current line
set statusline +=/%L%*        " total lines
set statusline +=%4v\ %*      " virtual column number

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
