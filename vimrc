" Great sources -
" gmarik's vimrc - https://github.com/gmarik/vimfiles/blob/master/vimrc
" durdn's vimrc - https://github.com/durdn/cfg/blob/master/.vimrc
" Graphical cheat sheet - http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html

" Initialization
set nocompatible  " Disable vi compatibility (more efficient, and besides we're using non-vi tricks here).
set fileformats=unix,dos,mac  " Set new file format and file format support (everything).

if has ("win32")
    behave mswin
else
    behave xterm
endif

filetype plugin indent on  " Automatically detect file types.


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
Bundle "jellybeans.vim"
Bundle "desert256.vim"
Bundle "tir_black"

" Syntax
Bundle "python.vim--Vasiliev"
let python_highlight_all=1  " Enable all plugin's highlighting.
let python_slow_sync=1  " For fast machines.
let python_print_as_function=1  " Color 'print' function.

Bundle "django.vim"
"Bundle 'https://github.com/oryband/Better-CSS-Syntax-for-Vim'

" Indentation
Bundle "indentpython.vim"
Bundle "JavaScript-Indent"

" Linting - Error correction
Bundle "pyflakes.vim"

" Other plugins
"Bundle 'EnhCommentify.vim'
"let g:EnhCommentifyRespectIndent='Yes'  " Put comment sign near text, not at beginning of line.
"let g:EnhCommentifyUseAltKeys='Yes'  " Comment using <Meta-x> instead of <Leader>x
"let g:EnhCommentifyTraditionalMode='Yes'  " Comment/Uncommend each line seperately.
"let g:EnhCommentifyFirstLineMode='Yes'  " Comment/Uncomment according to status of first line of code block.
"let g:EnhCommentifyMultiPartBlocks = 'Yes'  " Wrap comment signs around code blocks, not line-by-line.
"let g:EnhCommentifyUseSyntax='Yes'  " Use smart-commenting (e.g. <script> inside and *.html file will do a JavaScript commenting).
"imap <C-c> <Esc><Plug>Traditional

Bundle "camelcasemotion"
" Make word skip actions stop at new camelCaseWord or new_underscore_word.
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
let g:showmarks_textlower="m\t"
let g:showmarks_textupper="m\t"
let g:showmarks_textother="m\t"

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

"Bundle 'buftabs'
"let g:buftabs_only_basename=1  " Only print the filename of each buffer, omitting the preceding directory name.
"let g:buftabs_in_statusline=1  " Show the buftabs in the statusline instead of the command line.
"let g:buftabs_active_highlight_group="Visual"  " Highlight selected buffer.

Bundle 'minibufexpl.vim'
"let g:miniBufExplVSplit = 13  " Vertical column static width in chars
"let g:miniBufExplMaxSize = 2   " Vertical column max size.
let g:miniBufExplModSelTarget = 1  " Don't open buffer in a non-modifiable buffer (e.g. TagList window) -- I think this can cause a bug where two MiniBufExpl windows get opened every now and then.
"let g:miniBufExplForceSyntaxEnable = 1  " Use this if you encounter highlighting bugs (colors not changing).

"Bundle 'L9'
"Bundle 'FuzzyFinder'
"map <leader>f :FufFileWithCurrentBufferDir **/<C-M> 
"map <leader>b :FufBuffer<C-M>


" GUI
" Terminal
set t_Co=256  " Set terminal with 256 colors.

" gVim / MacVim
if has("win32")
    set guifont=Consolas:h12  " gVim font.
    set encoding=utf-8
else
    set guifont=Monaco:h14  " gVim font.
endif

set guioptions=a  " Disables all GUI options (menu, scrollbar, etc.)
"set guioptions-=T  " disables gVim toolbar (iconbar).

set guicursor=a:blinkon0  " disable gVim cursor blinking.
"set cursorline  " Set cursor to line.
"set cursorcolumn  " Set cursor to column.


" Colors
set background=dark
colorscheme jellybeans
"colorscheme desert256
"colorscheme tir_black

function! GlobalColorSettings()  " Set global color settings, regardless of colorscheme currently in use.
    " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
    highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

    " Set cursor color to be like in jellybeans.vim colorscheme, but with black text (previously white).
    highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

autocmd colorscheme * call GlobalColorSettings()  " Call the global color settings on every colorscheme change.


" Formatting
set textwidth=80  " Desirable text width. Used for text auto-wrapping.
set formatoptions=r,2  " Insert comment leader after hitting <Enter> in insert mode, and keep last line indentation. NOTE: Requires 'set autoindent'.

set nowrap     " No line wrapping.
set linebreak  " Wrap at word.

set backspace=indent,eol,start  " Enable backspace key. Erase previously entered characters in insert mode.

set number " Show line numbers.
set numberwidth=5  " Width of numbers column.


" Syntax
syntax on  " Syntax highlighting.
autocmd BufWinEnter,FileType html setfiletype htmldjango  " Special syntax for html+django.

" Show matching brace on insertion or cursor over.
set showmatch
set matchtime=3
set matchpairs+=<:>  " Treat '<','>' as matching braces.


" Omni Completion
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS


" Indentation
set autoindent  " Automatically set the indent of a new line (local to buffer).
set smartindent

" expandtab  = All tabs will be spaces.         | tabstop    = How many spaces is a tab (visually).
" smarttab   = delete chunks of spaces as tabs. | softabstop = How many spaces will a tab take when 'expandtab' is on.
" shiftwidth = How many spaces will a 'shift' command take.
autocmd BufWinEnter,FileType *,python,javascript set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab  " This includes default behaviour.
autocmd BufWinEnter,FileType html,css            set tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab


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
set nobackup  " Disable file backup beforew file overwrrite attempt.
set nowritebackup

if has ("win32")
    set directory=C:\windows/temp/
else
    set directory=/tmp//  " Set swap directory. prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
endif

set undofile  " Keep undo actions even when a file (buffer) is closed.
set undodir+=$HOME/.undo


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
map <Left> <C-w>j
"map <Left> <C-w>h
map <Right> <C-w>l

" Map up/down keys to page-up/down.
map <Up> <C-b>
map <Down> <C-f>


" General
set history=256  " Number of things to remember in history.
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).
"set autoread  " Reload file if changed outside of Vim (DANGEROUS!).
set clipboard+=unnamed  " Enable OS clipboard integration.
set hidden  " The current buffer can be put to the background without writing to disk.
autocmd BufWinEnter * lcd %:p:h  " Sets current-directory of current buffer/file.
"autocmd bufwritepost .vimrc source $MYVIMRC  " Source .vimrc after saving it.

