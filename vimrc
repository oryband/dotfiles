" Colors & Design ************************************************************
set t_Co=256 " 256 colors
set background=dark "or light
colorscheme desert256
set gfn=Menlo\ Regular:h14 " gVim Font
set guioptions-=T " disables gVim toolbar (iconbar)
set guicursor=a:blinkon0 " disable gVim cursor blinking

"Syntax **********************************************************************
syntax on " syntax highlighting

" Special syntax for file types.
"autocmd BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
"autocmd BufRead,BufNewFile *.js   set ft=javascript syntax=javascript
"autocmd BufRead,BufNewFile *.html set ft=html syntax=htmldjango

"Tabs ************************************************************************
set softtabstop=4 "Causes backspace to delete 4 spaces = converted <TAB>
set shiftwidth=4 " The amount to block indent when using < and >.
set tabstop=4 " 4 space tab.
set smarttab " Uses shiftwidth instead of tabstop at start of lines.
set expandtab " Replace <tab> with spaces.

autocmd FileType python     set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
autocmd FileType javascript set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
autocmd FileType html       set tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab
autocmd FileType css        set tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab

" Buffers *********************************************************************
set hidden " Allow changing buffers without saving (like :b!).

" Indenting *******************************************************************
filetype plugin indent on
set autoindent " Automatically set the indent of a new line (local to buffer)
set smartindent " smartindent (local to buffer)

" Scrollbars ******************************************************************
set sidescrolloff=2
set numberwidth=4

"Enable Mac Clipboard integration *********************************************
set clipboard=unnamed

" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

" Cursor highlights ***********************************************************
"set cursorline
"set cursorcolumn

" Searching *******************************************************************
"set hlsearch  " highlight search
set incsearch  " Incremental search, search as you type
set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase

" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high

" Line Wrapping ***************************************************************
set nowrap
set linebreak  " Wrap at word

" Directories *****************************************************************
" Setup backup location and enable
set backupdir=~/.vim/backup
set backup

" Set Swap directory
set directory=~/.vim/swap

" Sets path to directory buffer was loaded from
autocmd BufEnter * lcd %:p:h

" Mouse ***********************************************************************
set mouse=a " Enable the mouse
behave xterm
set selectmode=mouse

" File Stuff ******************************************************************
filetype on

" Invisible characters ********************************************************
set listchars=tab:▸\ ,trail:¬,eol:☠
set nolist

" Omni Completion *************************************************************
filetype plugin on
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Misc settings ***************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
"set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how.
"set nofoldenable " Turn off folding.

" Additional Functions ********************************************************
" Source .vimrc after saving it.
"if has("autocmd")
  "autocmd bufwritepost .vimrc source $MYVIMRC
"endif

" Self-explanatory. :)
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Auto-Complete Popup - acp.vim
let g:acp_mappingDriven = 1 " Pop-up occurs only on key types, not cursor movements.

