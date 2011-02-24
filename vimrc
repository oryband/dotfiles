" Sources -
" gmarik's vimrc - https://github.com/gmarik/vimfiles/blob/master/vimrc - Thanks! :)
" Graphical cheat sheet - http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html

" Initialization
set nocompatible  " disable vi compatibility (more efficient).
filetype plugin indent on  " Automatically detect file types.


" Plugin Bundles - http://vim-scripts.org/vim/scripts.html
" To install/update type  ':BundleInstall!'  <-- NOTE the exclamation mark '!'
" To clean ununsed plugins type  ':BundleClean!'

" Initialization
set runtimepath+=~/.vim/vundle.git/ 
call vundle#rc()

" Colors
Bundle "jellybeans.vim"
Bundle "desert256.vim"

" Syntax
Bundle "python.vim--Vasiliev"
:let python_highlight_all=1
:let python_slow_sync=1
:let python_print_as_function=1

Bundle "django.vim"
"Bundle "Better-CSS-Syntax-for-Vim"

" Indentation
Bundle "indentpython.vim"
Bundle "JavaScript-Indent"

" Linting - Error correction
Bundle "pyflakes.vim"

" Other plugins
Bundle "taglist.vim"

Bundle "buftabs"
:let g:buftabs_only_basename=1  " only print the filename of each buffer, omitting the preceding directory name.
:let g:buftabs_in_statusline=1  " show the buftabs in the statusline instead of the command line.
:let g:buftabs_active_highlight_group="Visual"  " Highlight selected buffer.


" Colors
colorscheme jellybeans  " or desert256
set background=dark  " or light


" Formatting
"set fo+=o  " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r  " Do not automatically insert a comment leader after an enter.
set fo-=t  " Do no auto-wrap text using textwidth (does not apply to comments).

set nowrap  " No line wrapping.
set linebreak  " Wrap at word.

set backspace=indent  " Erase previously entered characters in insert mode.
set backspace+=eol
set backspace+=start

set number " Show line numbers.
"set nonumber " Hide line numbers.
set numberwidth=4  " Width of numbers column.


" Syntax
syntax on  " Syntax highlighting.
autocmd FileType html set filetype=html syntax=htmldjango  " Special syntax for html+django.


" Omni Completion
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS


" Indentation
set autoindent  " Automatically set the indent of a new line (local to buffer).
set smartindent

set tabstop=4  " Tab size eql 4 spaces.
set softtabstop=4
set shiftwidth=4  " Default shift width for indents.
set expandtab  " Replace tabs with ${tabstop} spaces.
set smarttab

" Special indentation for specific file types.
autocmd FileType html set filetype=html tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab
autocmd FileType css  set filetype=css  tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab


" Searching
"set hlsearch  " Highlight search.
set smartcase  " Be case sensitive when input has a capital letter.
set incsearch  " Show matches while typing.
set ignorecase  " Ignore case when searching.


" Folding
set foldenable  " Turn on folding.
"set nofoldenable  " Turn off folding.
set foldmethod=marker  " Fold on the marker.
set foldlevel=100  " Don't autofold anything (but I can still fold manually).

set foldopen=block,hor,tag  " What movements open folds.
set foldopen+=percent,mark
set foldopen+=quickfix


" Backup
set nowritebackup  " Disable backup
set nobackup
"set backupdir=~/.vim/backup  " Setup backup location and enable
"set backup
set directory=/tmp//  " Set swap directory. prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)


" Window splitting
set equalalways  " Multiple windows, when created, are equal in size.
set splitbelow splitright  " New windows are created to the bottom-right.


" Bells
set novisualbell  " No blinking
"set noerrorbells  " No noise.
"set vb t_vb= " Disable any beeps or flashes on error


" Status Line
set shortmess=atI  " Shortens messages in status line.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.
set ruler  " Doesn't work with buftabs.vim plugin.
"set ch=2  " Make command line two lines high

" Invisible characters.
set listchars=tab:▸\ ,trail:¬,eol:«  " Invisible characters.
"set listchars=tab:°\ ,trail:·,eol:☠  " Alternate invisible characters.
"set list  " Display invisible characters.
set nolist  " Don't display invisible characters.


" Mouse
set mouse=a  " Enable mouse.
"set mouse-=a  " Disable mouse.
set mousehide  " Hide mouse after chars typed.
behave xterm  " Make mouse behave like in xterm (instead of, e.g. Windows' command-prompt mouse).
set selectmode=mouse  " Enable visule selection with mouse.


" GUI
" Terminal
set t_Co=256  " Set terminal with 256 colors.

" gVim / MacVim
set guifont=Monaco:h14  " gVim font.
set guioptions-=T  " disables gVim toolbar (iconbar).
set guicursor=a:blinkon0  " disable gVim cursor blinking.

"set cursorline  " Set cursor to line.
"set cursorcolumn  " Set cursor to column.


" General
set history=256  " Number of things to remember in history.
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).
"set autoread  " Reload file if changed outside of vim (DANGEROUS!).
set clipboard+=unnamed  " Enable OS Clipboard integration.
set hidden  " The current buffer can be put to the background without writing to disk.
" Sets path to directory buffer was loaded from
autocmd BufEnter * lcd %:p:h


" Additional Functions

" Source .vimrc after saving it.
"if has("autocmd")
  "autocmd bufwritepost .vimrc source $MYVIMRC
"endif

