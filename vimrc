"
" ~/.vimrc
"

"""""""""""""""""""""""""""""""""""""""""""
set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" plugins start here

Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'w0rp/ale'
Plugin 'lervag/vimtex'
Plugin 'lazywei/vim-matlab'
Plugin 'vim-python/python-syntax'
Plugin 'keith/swift.vim'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'PProvost/vim-ps1'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'bitc/vim-hdevtools'
Plugin 'gregjurman/vim-nc'
Plugin 'bfrg/vim-cpp-modern'

"" plugins end here
call vundle#end() " required
"""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on

" saving settings
set updatetime=750
set undofile             " maintain undo file...
set undodir=~/.vim/undo/ " in ~/.vim/undo/
set noswapfile
set nobackup
set nowb
set history=20

" colors
set t_Co=256
colorscheme sunyata

" set encodings and line ending formats
set gfs=fixedgr
set fileencodings=ucs-bom,utf-8,cp1253,default,latin1 " tried on open
set encoding=utf-8           " encoding displayed inside vim
set fileformats=unix,mac,dos " format order to be tried on a new buffer

" behaviour
syntax on
set mouse=a
set regexpengine=1     " use old regex engine
set showcmd            " show typed command
set number             " show line numbers
set showmatch          " show matching parentheses
set laststatus=0       " hide statusline titles
set splitbelow         " open new horizontal windows at bottom
set splitright         " open new vertical windows at right
set previewheight=3    " set preview window height to 3
set fillchars+=fold:\  " set folding separator to ' '
set showbreak=...      " show '...' at start of wrapped lines
set list               " show non-text characters
let &listchars = 'tab:| ,trail:_'

set autoindent
set ignorecase
set smartcase  " case sensitive only if Uppercase
set hlsearch   " highlight search matches

set sw=4 ts=4 sts=4         " default: 4 spaces per tab
set expandtab               " replace tabs with spaces
set backspace=2             " allow backspace in insert mode
set whichwrap+=h,l,<,>,[,]  " fix line movement on line borders
set wrap lbr                " wrap lines by word
set formatoptions=ro        " no automatic line breaking
set nojoinspaces            " don't insert 2 spaces after '.', '?' or '!'
set display+=lastline       " show last wrapped line in window
let colorcolumnposition=81  " position of column to mark text width
set shell=$SHELL
let &shellcmdflag = '--login -c' " 'login shell' to source profile
set noshellslash

" allow folding
set foldenable
set foldmethod=indent
set foldlevel=99    " depth of first folding
set foldnestmax=99 " depth of last folding
set foldcolumn=0

" fix movement in wrapped lines
noremap  <buffer> <silent> <Up>    gk
inoremap <buffer> <silent> <Up>    <C-o>gk
noremap  <buffer> <silent> <Down>  gj
inoremap <buffer> <silent> <Down>  <C-o>gj
noremap  <buffer> <silent> j       gj
noremap  <buffer> <silent> k       gk
noremap  <buffer> <silent> <Home>  g<home>
inoremap <buffer> <silent> <Home>  <C-o>g<home>
noremap  <buffer> <silent> <End>   g<End>
inoremap <buffer> <silent> <End>   <C-o>g<End>
noremap  <buffer> <silent> 0       g0
noremap  <buffer> <silent> ^       g^
noremap  <buffer> <silent> $       g$
noremap  <buffer> <silent> <Space> za

" execute last command with C-@
noremap  <silent> <C-@>   :@:<CR>
inoremap <silent> <C-@>   <Esc>:@:<CR>
cnoremap <silent> <C-@>   <C-e><C-u>@:<CR>

" show highlight group under cursor
map <F10> :echo
\ 'hi<' . synIDattr(synID(line("."),col("."),1),"name") . '> ' .
\ 'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> ' .
\ 'lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'
\ <CR>

" smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

function! IndentWithA()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "a"
    endif
endfunction
nnoremap <expr> a IndentWithA()

" use OS clipboard and copy-paste shortcuts
set clipboard=unnamed,unnamedplus
"inoremap <D-v> <Space><ESC>"+gPi<Delete>
inoremap <D-v> <C-r>+
nnoremap <D-v> "+p
vnoremap <D-v> "+p
cnoremap <D-v> <C-r>+
vnoremap <D-c> "+y

" other mappings
let mapleader = ";"
nnoremap o o<Esc>
let g:SuperTabDefaultCompletionType='<c-n>' " reverse supertab order

function! LocListToggle()
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        lclose
    else
        lopen
    endif
endfunction
nnoremap <silent> <leader>l :call LocListToggle()<CR>

" commenting
let g:NERDDefaultAlign = 'left' " flush left comment delimiters
let g:NERDCommentEmptyLines = 1 " comment empty lines too
let g:NERDAltDelims_swift = 1   " use // instead of /* */ in swift

" Fortran
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1
let fortran_more_precise=1
let fortran_do_enddo=1

" LaTeX
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_TreatMacViewerAsUNIX=1
let g:Tex_ExecuteUNIXViewerInForeground=1
let g:vimtex_view_method='skim'
let g:vimtex_compiler_latexmk={'callback' : 0}
let g:tex_comment_nospell=1

" ALE
"let g:ale_cursor_detail=1 " show errors in preview window
"let g:ale_echo_cursor=0   " don't show errors in status line
let g:ale_list_window_size=6
let g:ale_echo_msg_format='%severity%: %s'
let g:ale_sign_column_always=1
let g:ale_sign_error='x'
let g:ale_sign_warning ='!'

" functions
function! SetSignColumn(file_name, is_modifiable)
    if empty(a:file_name) || !a:is_modifiable
        let &signcolumn = 'no'
        let b:gutterwidth = 0
    else
        let &signcolumn = 'yes'
        let b:gutterwidth = 2
    endif
endfunction

" Autocommands
augroup vimrc
    autocmd!

    " autosave named files
    autocmd CursorHold ?* nested update

    " limit amount of syntax lines
    autocmd BufEnter,Syntax * syn sync minlines=200 maxlines=200

    " enable sign column when appropriate
    autocmd BufWinEnter,BufRead,BufWrite *
      \  call SetSignColumn(@%, &modifiable)

    " set color column to 80th character
    autocmd BufWinEnter,VimResized,TextChanged,TextChangedI,OptionSet *
      \  let &numberwidth = float2nr(log10(line('$'))) + 2
      \| let &textwidth   =
      "\    colorcolumnposition - 2 - &numberwidth*&number - b:gutterwidth
      \    &columns - 2 - &numberwidth*&number - b:gutterwidth
      \| let &colorcolumn =
      \    colorcolumnposition - b:gutterwidth - &numberwidth*&number

    " custom syntax rules
    autocmd BufWinEnter,BufRead,BufWrite ?* silent! set fileencoding=utf-8
    autocmd BufWinEnter,BufRead,BufWrite *.c set cindent
    autocmd BufWinEnter,BufRead,BufWrite *.py :Python3Syntax
    autocmd FileType tex,latex,text
      \  set spell spelllang=en_us,el,cjk " spell check .tex and .txt
    let textFiletypes = ['tex', 'latex', 'text', 'sh', '']
    autocmd BufWinEnter,BufRead,BufWrite *
      \  if index(textFiletypes, &ft) < 0
      \  | :source $HOME/.vim/after/syntax/default.vim

    " close loclists with buffer
    autocmd QuitPre * if empty(&buftype) | lclose | endif

    " remember folds
    au BufWinLeave * mkview
    au BufWinEnter * silent loadview
augroup END
