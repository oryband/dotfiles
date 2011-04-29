" Great sources & credits -
" gmarik's vimrc - https://github.com/gmarik/vimfiles/blob/master/vimrc
" durdn's vimrc - https://github.com/durdn/cfg/blob/master/.vimrc
" Example vimrc - http://www.vi-improved.org/vimrc.php
"
" Graphical cheat sheet - http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html

" Initialization
set nocompatible  " Disable vi compatibility (more efficient, and besides we're using non-vi tricks here).

set fileformats=unix,dos,mac  " Set file end-of-line priority.

if has ("win32")  " Set mouse behaviour to be like the OS's.
    behave mswin
else
    behave xterm
endif

filetype plugin indent on  " Automatically detect file types, and enable file-type-specific plugins and indentation.


" Plugin Bundles - http://vim-scripts.org/vim/scripts.html
" To install/update type  ':BundleInstall!'  <-- NOTE the exclamation mark '!'
" To clean ununsed plugins type  ':BundleClean!'

" Initialization
if has ("win32")
    set runtimepath+=$HOME/vimfiles/vundle.git/ 
else
    set runtimepath+=$HOME/.vim/vundle.git/ 
endif

call vundle#rc()

" Colors
Bundle "Solarized"
Bundle "jellybeans.vim"
Bundle "desert256.vim"
Bundle "tir_black"

" Syntax
Bundle "python.vim--Vasiliev"
let python_highlight_all=1  " Enable all plugin's highlighting.
let python_slow_sync=1  " For fast machines.
let python_print_as_function=1  " Color 'print' function.

Bundle "django.vim"
Bundle "Better-CSS-Syntax-for-Vim"

" Indentation
Bundle "indentpython.vim"
Bundle "JavaScript-Indent"

" Linting / Error correction
Bundle "pyflakes.vim"

" Other plugins
Bundle "The-NERD-Commenter"

Bundle "camelcasemotion"
" Make word-skip actions stop at new camelCaseWord or new_underscore_word.
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

Bundle "ShowMarks"
" Only show alphabetic marks.
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Marks will be shown in format of 'm[mark char]' e.g. 'mA'.
let g:showmarks_textlower="\.\t"
let g:showmarks_textupper="\.\t"
let g:showmarks_textother="\.\t"

Bundle "Tabular"

Bundle "taglist.vim"
" Sort tags by name (alternative is 'order' - of appearance).
let Tlist_Sort_Type="name"
let Tlist_WinWidth=30  " Window width in chars.
let Tlist_Use_Right_Window=1  " Open tag list window to the right (instead to the left).
let Tlist_GainFocus_On_ToggleOpen=1  " Switch to tag list window after opening it.
let Tlist_Exit_OnlyWindow=1  " Exit Vim if the tag list window is the only one left open.
let Tlist_File_Fold_Auto_Close=1  " Automatically close folds for non-active files in tag list.
"let Tlist_Compact_Format=1  " No spaces and additional help.

" Add JavaScript tag listing.
let g:tlist_javascript_settings='javascript;s:string;a:array;o:object;f:function'

"Bundle 'buftabs'
"let g:buftabs_only_basename=1  " Only print the filename of each buffer, omitting the preceding directory name.
"let g:buftabs_in_statusline=1  " Show the buftabs in the statusline instead of the command line.
"let g:buftabs_active_highlight_group="Visual"  " Highlight selected buffer.

Bundle 'minibufexpl.vim'
let g:miniBufExplModSelTarget = 1  " Don't open buffer in a non-modifiable buffer (e.g. TagList window).
"let g:miniBufExplVSplit = 13  " Vertical column static width in chars
"let g:miniBufExplMaxSize = 2   " Vertical column max size.
"let g:miniBufExplForceSyntaxEnable = 1  " Use this if you encounter highlighting bugs (colors not changing).


" Terminal / GUI
set t_Co=256  " Set terminal to display 256 colors.

if has("win32")  " Fix Windows specific encoding problem.
    set encoding=utf-8
endif


" Colors
set background=dark
" let g:solarized_termcolors=256  " Use this if you don't use Solazried as your terminal colors.
colorscheme solarized
"colorscheme jellybeans
"colorscheme desert256
"colorscheme tir_black

function! GlobalColorSettings()  " Set global color settings, regardless of colorscheme currently in use.
    " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
    "highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

    " TODO: colorscheme jellybeans only.
    "highlight Operator term=underline ctermfg=215 guifg=#ffb964

    " Set cursor color to be like in jellybeans.vim colorscheme, but with black text (previously white).
    "highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

autocmd colorscheme * call GlobalColorSettings()  " Call the global color settings on every colorscheme change.


" Formatting
set textwidth=80  " Desirable text width. Used for text auto-wrapping.
set formatoptions=r,2  " FIXME: Doesn't work, unless re-sourcing .vimrc. Enable comment leader insertion after hitting <Enter> in insert mode, and keep last line indentation. Disable all other format options. NOTE: Requires 'set autoindent'.

set nowrap     " No line wrapping.
set linebreak  " Wrap at word.

set backspace=indent,eol,start  " Enable backspace key. Erase previously entered characters in insert mode.

set number " Show line numbers.
set numberwidth=5  " Width of numbers column.


" Syntax
syntax on  " Syntax highlighting.
autocmd BufWinEnter,FileType html setfiletype htmldjango  " Special syntax for html+django.

set showmatch  " Show matching brace on insertion or cursor over.
set matchtime=3  " How many tenths of a second to wait before showing matching braces.
set matchpairs+=<:>  " Treat '<','>' as matching braces.


" Omni Completion
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS


" Indentation
set autoindent  " Automatically set the indent of a new line (local to buffer).
set smartindent
"set shiftround  " Round shift actions. i.e. When at 3 spaces, and I hit > ... go to 4, not 5. FIXME: Doesn't work.

" expandtab  = All tabs will be spaces.
" softabstop = How many spaces will a tab take when 'expandtab' is on.
" smarttab   = delete chunks of spaces like tabs.
" tabstop    = How many spaces is a tab (visually).
" shiftwidth = How many spaces will a 'shift' command take.
autocmd BufWinEnter,FileType *,python,javascript set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4  " This includes default behaviour.
autocmd BufWinEnter,FileType html,css            set expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2  " FIXME: Doesn't work.



" Searching
"set hlsearch  " Highlight search.
set smartcase  " Be case sensitive when input has a capital letter.
set incsearch  " Show matches while typing.
set ignorecase  " Ignore case when searching.


" Folding
set foldenable  " Turn on folding.
set foldmethod=marker  " Fold on the marker.
set foldlevel=100  " Don't autofold anything (but I can still fold manually).
set foldopen=block,hor,tag,percent,mark,quickfix  " What movements open folds.


" Backup
set nobackup  " Disable file backup before file overwrite attempt.
set nowritebackup

"set undofile  " Keep undo actions even when a file (buffer) is closed.
"if has ("win32")  " Set undo files location.
    "set undodir=$HOME\vimfiles\undo
    "set undodir+=C:\tmp
    "set undodir+=C:\temp
    "set undodir+=.
"else
    "set undodir=$HOME/.vim/undo
    "set undodir+=/var/tmp
    "set undodir+=/tmp
    "set undodir+=.
"endif


" Window splitting
"set equalalways  " Multiple windows, when created, are equal in size. NOTE: Doesn't work well with MiniBufExpl.vim
set splitbelow splitright  " New windows are created to the bottom-right.


" Status Line
set shortmess=at  " Shortens messages in status line, truncates long messages.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.
set ruler  " Show file status ruler. NOTE: Doesn't work with buftabs.vim plugin.
"set ch=2  " Make command line two lines high


" Invisible characters.
if ! has("win32")
    set listchars=tab:▸\ ,trail:¬,eol:«  " Invisible characters.
    "set listchars=tab:°\ ,trail:·,eol:☠  " Alternate invisible characters.
endif
"set list  " Display invisible characters.
set nolist  " Don't display invisible characters.


" Mouse
set mouse=a  " Enable mouse.
"set mouse-=a  " Disable mouse.
set mousehide  " Hide mouse after chars typed.
behave xterm  " Make mouse behave like in xterm (instead of, e.g. Windows' command-prompt mouse).
set selectmode=mouse  " Enable visule selection with mouse.


" Bells
set novisualbell  " No blinking
"set noerrorbells  " No noise.
"set vb t_vb= " Disable any beeps or flashes on error


" Ignored files
set wildignore+=*.jpg,*.jpeg,*.png,*.gif  " Ignore images
set wildignore+=*.pdf  " Ignore PDF files
set wildignore+=*.pyc,*.pyo  " Ignore compiled Python files


" Key mappings
" Map arrow keys to window-change actions.
"map <Up> <C-w>k
"map <Down> <C-w>j
map <Left> <C-w>h
map <Right> <C-w>l

" Map up/down keys to page-up/down.
map <Up> <C-b>
map <Down> <C-f>


" General
let mapleader=","  " Set <leader> key to comma.

set history=256  " Number of things to remember in history.

set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).

"set autoread  " Reload file if changed outside of Vim (DANGEROUS!).

set clipboard+=unnamed  " Enable OS clipboard integration.

set hidden  " The current buffer can be put to the background without writing to disk.

autocmd BufWinEnter * lcd %:p:h  " Sets current-directory of current buffer/file. We avoid using `set autchdir` instead, because it can cause problems with some plugins.
"autocmd bufwritepost .vimrc source $MYVIMRC  " Source .vimrc after saving it.

