" Great sources & credits:
" Example vimrc - http://www.vi-improved.org/vimrc.php
" gmarik - https://github.com/gmarik/vimfiles/blob/master/vimrc
" durdn - https://github.com/durdn/cfg/blob/master/.vimrc
" FactoryLab - https://github.com/factorylabs/vimfiles
" lukerandall - https://github.com/lukerandall/dotvim/blob/master/vimrc
" Graphical cheat sheet - http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html

" Initialization / Vundle Plugin Mangaer
set nocompatible  " Disable vi compatibility (more efficient, and besides - we're using non-vi tricks here).
set fileformats=unix,dos,mac  " Set file end-of-line priority.
filetype off

if has ("win32")
    set runtimepath+=$HOME/vimfiles/bundle/vundle/
else
    set runtimepath+=$HOME/.vim/bundle/vundle/
endif

call vundle#rc()
Bundle "gmarik/vundle"

filetype plugin indent on  " Automatically detect file types, and enable file-type-specific plugins and indentation.
set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4
syntax on

" Misc.
let mapleader=","  " Set <leader> key to comma.
set history=256  " Number of things to remember in history.
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).
"set autoread  " Reload file if changed outside of Vim (DANGEROUS!).
set clipboard+=unnamed  " Enable OS clipboard integration.
set hidden  " The current buffer can be put to the background without writing to disk.
if strpart(expand("%:p:h"), 0, 7) != "scp://"
    autocmd BufEnter * lchdir %:p:h  " Sets current-directory of current buffer/file. We avoid using `set autchdir` instead, because it can cause problems with some plugins.
endif
"autocmd BufWritePost .vimrc source $MYVIMRC  " Source .vimrc after saving it.
"set timeoutlen=500  " Set key-combination timeout.
set title  " Show title in app title bar.
set ttyfast  " Fast drawing.
set scrolloff=3  " Number of lines to keep above/below cursor when scrolling.
"set debug=msg  " Show Vim error messages.

" Web
Bundle "pangloss/vim-javascript"
Bundle "lepture/vim-jinja"
"Bundle "lepture/vim-css"
Bundle "cakebaker/scss-syntax.vim"
Bundle "groenewege/vim-less"
Bundle "matchit.zip"
autocmd BufWinEnter *.json,*jshintrc setfiletype javascript
autocmd BufWinEnter *.scss setfiletype scss
autocmd BufWinEnter *.less setfiletype less
autocmd BufWinEnter *.html,*.htm setfiletype html
autocmd FileType css,scss,less set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html,jinja set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html setlocal syntax=jinja
autocmd FileType html,css,scss,less setlocal expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType html,jinja runtime! macros/matchit.vim
autocmd BufWritePost *.scss,*.sass !compass compile ../ <afile> --force

" Python
Bundle "hynek/vim-python-pep8-indent"
Bundle "python.vim--Vasiliev"
let python_highlight_all=1  " Enable all plugin's highlighting.
let python_slow_sync=1  " For fast machines.
let python_print_as_function=1  " Color 'print' function.
autocmd FileType python setlocal linebreak nosmartindent  " nosmartindent for comment indentation problem.
autocmd FileType python set omnifunc=pythoncomplete#Complete
set wildignore+=*.pyc,*.pyo
set wildignore+=*.egg,*.egg-info

" Haskell
Bundle "bitc/lushtags"
Bundle "Twinside/vim-haskellConceal"
Bundle "Twinside/vim-hoogle"
Bundle "indenthaskell.vim"
"let g:haskell_indent_if=3
"let g:haskell_indent_case=5
"Bundle "haskell.vim"
Bundle "syntaxhaskell.vim"
let hs_highlight_boolean=1
let hs_highlight_types=1
let hs_highlight_debug=1
let hs_allow_hash_operator=1
set wildignore+=*.hi,*.o

" C++
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_include_dirs=[ 'includes', 'include', 'inc',  'headers' ]
let g:syntastic_cpp_auto_refresh_includes=1
let g:syntastic_cpp_remove_include_errors=1
let g:syntastic_cpp_compiler_options=' -Wall -Weffc++'
" Run ../makefile if exists, else compile src/*.cpp, include/*.h, and output to bin/runme
"autocmd FileWritePost cpp setlocal args ../src/*.cpp
"autocmd FileType cpp setlocal makeprg=[[\ -f\ ../makefile\ ]]\ &&\ make\ ../makefile\ -C\ ..\ \\\|\\\|\ g++\ -I\ ../include\ -Wall\ -Weffc++\ -g\ -o\ ../bin/runme\ ##
autocmd FileType cpp setlocal makeprg=[[\ -f\ ../makefile\ ]]\ &&\ make\ ../makefile\ -C\ ..\ \\\|\\\|\ g++
" Run output file after successful make.
"autocmd QuickfixCmdPost make call AfterMakeC()
"function! AfterMakeC()
    "if len(getqflist()) == 0
        "!../bin/runme
    "endif
"endfunction
set wildignore+=*.o,*.a

" Markdown
autocmd BufWinEnter *.md,*.markdown setfiletype markdown
Bundle "tpope/vim-markdown"

" Syntax Checking
Bundle "scrooloose/syntastic"
"Bundle "oryband/syntastic"
"let g:syntastic_mode_map = {
            "\ 'mode': 'active',
            "\ 'active_filetypes':  [],
            "\ 'passive_filetypes': [] }
let g:syntastic_enable_signs=1  " Show sidebar signs.
"let g:syntastic_auto_loc_list=1  " Auto open errors window upon detection.
set statusline+=%#warningmsg#  " Add Error ruler.
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nnoremap <silent> ` :Errors<CR>
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_balloons=1

Bundle "camelcasemotion"
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

Bundle "Lokaltog/vim-powerline"
"let g:Powerline_symbols="unicode"
let g:Powerline_stl_path_style = 'short'

Bundle "majutsushi/tagbar"
nnoremap <silent> \ :TagbarToggle<CR>
" Search tag list from current dir up till root.
set tags=./tags;/

Bundle "godlygeek/tabular"
Bundle "tpope/vim-unimpaired"

" Colors
Bundle "nanotech/jellybeans.vim"
Bundle "jelera/vim-gummybears-colorscheme.git"
Bundle "chriskempson/vim-tomorrow-theme"
Bundle "tomasr/molokai"
" Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
let g:jellybeans_overrides = { 'Todo': { 'guifg': 'ff4500', 'guibg': 'eeee00', 'ctermfg': '196', 'ctermbg': '226', 'attr': 'standout' }, }
hi MBEVisibleActive guifg=#A6DB29 guibg=fg
hi MBEVisibleChangedActive guifg=#F1266F guibg=fg
hi MBEVisibleChanged guifg=#F1266F guibg=fg
hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
hi MBEChanged guifg=#CD5907 guibg=fg
hi MBENormal guifg=#808080 guibg=fg
set t_Co=256  " Set terminal to display 256 colors.
set background=dark
colorscheme jellybeans
"colorscheme gummybears
"colorscheme tomorrow-night-bright
"colorscheme molokai
set cc=+1  " Highlight one column AFTER 'textwidth'.
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
highlight WhitespaceEOL ctermbg=red guibg=red

" Status Line
set shortmess=at  " Shortens messages in status line, truncates long messages.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.

" Window/buffer mangement.
" L9 is necessary for fuzzyfinder.
Bundle "L9"
Bundle "FuzzyFinder"
let g:fuf_modesDisable = []
let g:fuf_ignoreCase = 1
let g:fuf_timeFormat = ''  " Remove time string.
let g:fuf_maxMenuWidth = 70
"let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
nnoremap <Leader>1 :FufBuffer<CR>
nnoremap <Leader>2 :FufFileWithCurrentBufferDir<CR>
nnoremap <Leader>3 :FufBufferTagAll<CR>

" Searching
"set hlsearch  " Highlight search.
set smartcase  " Be case sensitive when input has a capital letter.
set incsearch  " Show matches while typing.
set ignorecase  " Ignore case when searching.
set gdefault  " Make searched global `/g` by default.
if exists('&wildignorecase')
    set wildignorecase  " In-case-sensitive dir/file completion.
endif
set wildmenu  " Enable menu for commands
set wildmode=list:longest  " List options when hitting tab, and match longest common command.

" Formatting & Text
set encoding=utf-8
set nowrap  " No line wrapping.
set linebreak  " Wrap at word.
set textwidth=76  " Desirable text width. Used for text auto-wrapping. 0 means no auto-wrapping.
" Enable auto-wrapping comments, comment leader auto-insertion
" in <Insert> mode, auto-format paragraphs, keep last line indentation.
" Disable all other format options.
" NOTE: Requires 'set autoindent'. autocmd FileType is required since
" I set `formatoptions` differently for each file type (.c, .py, etc.)."
autocmd FileType * set formatoptions=r,2
set backspace=indent,eol,start  " Enable backspace key. Erase previously entered characters in insert mode.
set number  " Show line numbers.
set showmatch  " Show matching brace on insertion or cursor over.
set matchtime=3  " How many tenths of a second to wait before showing matching braces.
" Invisible characters.
if ! has("win32")
    set listchars=tab:▸\ ,trail:¬,eol:«  " Invisible characters.
endif
set nolist  " Don't display invisible characters.

" Indentation
set autoindent  " Automatically set the indent of a new line (local to buffer).
set smartindent
"set shiftround  " Round shift actions. i.e. When at 3 spaces, and I hit > ... go to 4, not 5. FIXME: Doesn't work.

" Folding
set foldenable  " Turn on folding.
set foldmethod=marker  " Fold on the marker.
set foldlevel=100  " Don't autofold anything (but I can still fold manually).
set foldopen=block,hor,tag,percent,mark,quickfix  " Which movements open folds.

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

" Mouse
"Set mouse behaviour to be like the OS's.
if has ("win32")
    behave mswin
else
    behave xterm
endif
"set mouse=a  " Enable mouse.
set mouse-=a  " Disable mouse.
set mousehide  " Hide mouse after chars typed.
behave xterm  " Make mouse behave like in xterm (instead of, e.g. Windows' command-prompt mouse).
set selectmode=mouse  " Enable visule selection with mouse.

" Bells
set novisualbell  " No blinking
"set noerrorbells  " No noise.
"set vb t_vb= " Disable any beeps or flashes on error

" Ignored files
set wildignore+=*.swp  " Vim
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.psd  " Ignore images
set wildignore+=*.pdf  " Ignore PDF files
set wildignore+=*.DS_STORE

" Key mappings
" Page up/down.
noremap <C-k> <C-b>
noremap <C-j> <C-f>
" Window-change actions.
noremap <Up> <C-w>k
noremap <Down> <C-w>j
noremap <Left> <C-w>h
noremap <Right> <C-w>l

Bundle "AutoTag"
Bundle "IndexedSearch"
Bundle "AutoComplPop"
Bundle "scrooloose/nerdcommenter"
Bundle "ryan-cf/netrw"
