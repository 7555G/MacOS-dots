"
" ~/.vimrc
"

"""""""""""""""""""""""""""""""""""""""""""
set nocompatible  " be iMproved, required
filetype off  " required

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" plugins start here
Plugin 'tpope/vim-rsi'
Plugin 'scrooloose/nerdcommenter'
Plugin 'w0rp/ale'
Plugin 'skywind3000/vim-auto-popmenu'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-python/python-syntax'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'bitc/vim-hdevtools'
Plugin 'keith/swift.vim'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'lervag/vimtex'
Plugin 'PProvost/vim-ps1'
Plugin 'yuezk/vim-js'
Plugin 'peterhoeg/vim-qml'

"" plugins end here
call vundle#end()  " required
"""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on

" saving
set updatetime=400  " autoupdate delay
set undofile  " maintain undo file
set undodir=$HOME/.vim/undo/  " undo file location
set noswapfile  " don't write swap file
set nowritebackup  " no backup before overwriting
set nobackup  " no persistent backups
set autoread  " auto-read modified open files

" set encodings and line ending formats
set fileencodings=ucs-bom,utf-8,cp1253,default,latin1  " tried on open
set encoding=utf-8  " encoding used for displaying inside vim
set fileformats=unix,mac,dos  " format order to be tried on a new buffer

" appearance
set t_Co=16
colorscheme sunyata
set number  " show line numbers
set numberwidth=1  " smallest width at start
set wrap  " wrap long lines
set showmatch  " show matching parentheses
set noshowcmd  " hide typed command
set laststatus=2  " always show statusline
let &statusline = ' %(%h%w %)%F%#MatchParen#%m%##%a%=R: %l/%L  C: %c/%{Pad(strwidth(getline(".")), 3)} '
let &fillchars = 'vert:│,diff:-,eob: '
set showbreak=…  " show '…' at start of wrapped lines
set list  " show non-text characters
let &listchars = 'tab:╵ ,trail:·,conceal:*'
set concealcursor=inc  " enable conceal on cursor line in i, n, c modes
set conceallevel=1  " enable conceal
function! MyFoldText()  " custom fold text
    let line = getline(v:foldstart)
    let sub = substitute(line, '\S\+.*', '...', 'g')
    return sub
endfunction
function! Pad(s,amt)  " add right padding to string
    return a:s . repeat(' ',a:amt - len(a:s))
endfunction

" behaviour
set regexpengine=1  " use old regex engine
set mouse=a  " enable mouse
set splitbelow  " open new horizontal windows at bottom
set splitright  " open new vertical windows at right
set previewheight=3  " set preview window height to 3
set autoindent  " autointent
set expandtab  " replace tabs with spaces
set sw=2   " ┐
set ts=4   " ├ 4 spaces per tab, fold every 2
set sts=4  " ┘
set nojoinspaces  " don't insert 2 spaces after '.', '?' or '!'
set backspace=2  " allow backspace in insert mode
set scrolloff=3  " scroll 3 lines before the last
set whichwrap+=h,l,<,>,[,]  " fix line movement on line borders
set wrap lbr  " wrap lines by word
set formatoptions=ro  " no automatic line breaking
set display+=lastline  " show last wrapped line in window
let colorcolumn = 81  " color column on 81st character
set shell=$SHELL\ -l  " login shell for 'term'
set shellcmdflag=-l\ -c  " login shell for '!'

" folding
set foldenable  " enable folding
set foldmethod=indent  " fold only based on intentation
set foldlevel=99  " depth of first folding
set foldnestmax=99  " depth of last folding
set foldcolumn=0  " hide fold column

" searching
set smartcase  " case sensitive only if Uppercase
set hlsearch  " highlight search matches

" autocompletion
set completeopt-=preview  " don't show preview window with info
set completeopt+=menuone,noinsert  " single-item popup & don't auto-insert
set complete-=u,t  " disable completion based on tags and unloaded buffers
set shortmess+=c  " shut off completion messages
set belloff+=ctrlg  " silent completion
let g:apc_enable_ft = {'*':1, 'cpp':0}  " auto popup
let g:apc_cr_confirm = 1  " return inserts selected

" change leader
let mapleader =  ";"

" autocompletion mappings
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? "\<Down>" : ""
inoremap <expr> <C-j> pumvisible() ? "" :  "\<C-j>"
"inoremap <expr> <C-p> pumvisible() ? "\<Up>" : ""
inoremap <expr> <C-k> pumvisible() ? "" : "\<C-k>"

" wrapped lines movement mappings
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
noremap  <silent> <C-@> :@:<CR>
inoremap <silent> <C-@> <Esc>:@:<CR>
cnoremap <silent> <C-@> <C-e><C-u>@:<CR>

" print highlight group under cursor
map <F10> :echo
\   'hi<' . synIDattr(synID(line("."),col("."),1),"name") . '> ' .
\   'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> ' .
\   'lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'
\   <CR>

" smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return  "\"_cc"
    else
        return  "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

function! IndentWithA()
    if len(getline('.')) == 0
        return  "\"_cc"
    else
        return  "a"
    endif
endfunction
nnoremap <expr> a IndentWithA()

" use OS clipboard and copy-paste shortcuts
set clipboard=unnamed,unnamedplus
"inoremap <D-v> <Space><ESC>"+gPi<Delete>
inoremap <D-v> <C-r>+
nnoremap <D-v>  "+p
vnoremap <D-v>  "+p
cnoremap <D-v> <C-r>+
"vnoremap <D-c>  "+y
nnoremap <D-c>  :echo "ok"

" show loclist
function! LocListToggle()
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        lclose
    else
        lopen
    endif
endfunction
nnoremap <silent> <leader>l :call LocListToggle()<CR>

" ignorecase when searching by using '\c'
noremap <silent> / :echo '/'<CR>/\c
noremap <silent> ? :echo '?'<CR>?\c

" other mappings
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap <silent> <leader>d :ALEGoToDefinition \| new<CR>

" nerdcommenter
let g:NERDDefaultAlign = 'left'  " flush left comment delimiters
let g:NERDCommentEmptyLines = 1  " comment empty lines too
let g:NERDAltDelims_swift = 1  " use // instead of /* */ in swift
let g:NERDRemoveAltComs = 1  " also remove alternative comments
" let g:NERDSpaceDelims = 1  " add extra spaces around delimiters
let g:NERDRemoveExtraSpaces = 1  " always remove extra spaces
let g:NERDTrimTrailingWhitespace  = 1

" LaTeX
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:tex_comment_nospell = 1

" ALE
let g:ale_list_window_size = 6
let g:ale_echo_msg_format = '%linter%::%severity%% code% -- %s'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '!'
let g:ale_linters = {'cpp': ['ccls']}
let &omnifunc = 'ale#completion#OmniFunc'
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 400
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache'
\   }
\}


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

    " enable sign column (when appropriate) and set foldtext
    autocmd BufWinEnter,BufRead,BufWrite *
    \   call SetSignColumn(@%, &modifiable)
    \|  set foldtext=MyFoldText()

    " autosave named files
    autocmd CursorHold ?* nested if empty(&buftype) | update | endif

    " convert everything to utf-8
    autocmd BufWinEnter,BufRead,BufWrite ?* silent! set fileencoding=utf-8

    " spell check text files
    autocmd FileType tex,latex,text,markdown
    \   set formatoptions=tawcroql
    \|  set spell spelllang=en_us,el,cjk

    " limit amount of syntax lines
    autocmd Syntax * syn sync minlines=200 maxlines=200

    " enable syntax, load default syntax, * show guides for non-text files
    let textFiletypes =
    \   ['xml', 'yaml', 'markdown', 'qf', 'help', 'tex', 'latex', 'text', '']
    autocmd BufWinEnter,BufRead * nested
    \   if !exists("g:syntax_on")
    \|      syntax on
    \|      syntax enable
    \|  endif
    \|  if index(textFiletypes, &filetype) < 0
    \|      source $HOME/.vim/after/syntax/default.vim
    \|      source $HOME/.vim/after/syntax/indent_guides.vim
    \|  endif

    " use xml syntax for some extensions
    autocmd BufWinEnter,BufRead,BufWrite
    \   *.sdf,*.world,*.model,*.config,*.launch,*.plist set ft=xml

    " syntax for qml extensions
    "autocmd BufWinEnter,BufRead,BufWrite *.qml set ft=yaml

    " cmake custom autocompletion
    autocmd BufWinEnter,BufRead,BufWrite CMakeLists.txt,*.cmake
    \   set complete=.,k
    \|  set dictionary=$HOME/.vim/words/cmake.txt

    " close loclists with buffer
    autocmd QuitPre * if empty(&buftype) | lclose | endif

    " remember state
    au BufWinLeave,BufWrite * silent! mkview
    au BufRead * silent! loadview
augroup END
