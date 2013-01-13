" Great sources & credits:
" Example vimrc - http://www.vi-improved.org/vimrc.php
" gmarik - https://github.com/gmarik/vimfiles/blob/master/vimrc
" durdn - https://github.com/durdn/cfg/blob/master/.vimrc
" FactoryLab - https://github.com/factorylabs/vimfiles
" lukerandall - https://github.com/lukerandall/dotvim/blob/master/vimrc
" mathiasbynens - https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc
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


" Plugins
" Colors
Bundle "nanotech/jellybeans.vim"

" Web
Bundle "pangloss/vim-javascript"
Bundle "lepture/vim-jinja"
"Bundle "lepture/vim-css"
Bundle "cakebaker/scss-syntax.vim"
Bundle "groenewege/vim-less"
Bundle "matchit.zip"
Bundle "ap/vim-css-color"

" Python
Bundle "hynek/vim-python-pep8-indent"
Bundle "python.vim--Vasiliev"

" Haskell
Bundle "bitc/lushtags"
Bundle "Twinside/vim-haskellConceal"
Bundle "Twinside/vim-hoogle"
Bundle "indenthaskell.vim"
"Bundle "haskell.vim"
Bundle "syntaxhaskell.vim"

" Markdown
Bundle "tpope/vim-markdown"

" Syntax
Bundle "scrooloose/syntastic"
Bundle "scrooloose/nerdcommenter"

" Navigation
Bundle "IndexedSearch"
Bundle "camelcasemotion"
Bundle "Lokaltog/vim-powerline"
Bundle "majutsushi/tagbar"
Bundle "godlygeek/tabular"
Bundle "tpope/vim-unimpaired"
Bundle "L9"
Bundle "FuzzyFinder"
"Bundle "fholgado/minibufexpl.vim"
Bundle "techlivezheng/vim-plugin-minibufexpl"

" Misc
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "AutoTag"
Bundle "Shougo/neocomplcache"
"Bundle "AutoComplPop"
"Bundle "embear/vim-localvimrc"
"Bundle "ryan-cf/netrw"

filetype plugin indent on  " Automatically detect file types, and enable file-type-specific plugins and indentation.
set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4
syntax on

" Colors
set t_Co=256  " Set terminal to display 256 colors.
set background=dark
" Set 'TODO' & 'FIXME' strings to be bold and standout as hell. Works for jellybeans color scheme only.
let g:jellybeans_overrides = {
            \ 'Todo': {
                \ 'guifg': 'ff4500',
                \ 'guibg': 'eeee00',
                \ 'ctermfg': '196',
                \ 'ctermbg': '226',
                \ 'attr': 'standout'
            \ }
        \ }
" Misc color overrides.
colorscheme jellybeans

" Misc.
let mapleader=","  " Set <leader> key to comma.
set nostartofline
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).
set history=256  " Number of things to remember in history.
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
let python_highlight_all=1  " Enable all plugin's highlighting.
let python_slow_sync=1  " For fast machines.
let python_print_as_function=1  " Color 'print' function.
autocmd FileType python setlocal linebreak nosmartindent  " nosmartindent for comment indentation problem.
autocmd FileType python set omnifunc=pythoncomplete#Complete
set wildignore+=*.pyc,*.pyo
set wildignore+=*.egg,*.egg-info

" Haskell
"let g:haskell_indent_if=3
"let g:haskell_indent_case=5
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
let g:syntastic_cpp_compiler_options=' -Wall -Wextra -Weffc++'
" Run `make ../makefile` if exists, else use `g++`.
"autocmd FileType cpp setlocal makeprg=[[\ -f\ ../makefile\ ]]\ &&\ make\ ../makefile\ -C\ ..\ \\\|\\\|\ g++
" Run output file after successful make.
"autocmd QuickfixCmdPost make call AfterMakeC()
"function! AfterMakeC()
    "if len(getqflist()) == 0
        "!../bin/runme
    "endif
"endfunction
set wildignore+=*.a,*.o,*.so

" Java
autocmd FileType ant setlocal expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2
set wildignore+=*.class

" Markdown
autocmd BufWinEnter *.md,*.markdown setfiletype markdown

" Syntastic
"let g:syntastic_mode_map = {
            "\ 'mode': 'active',
            "\ 'active_filetypes':  [],
            "\ 'passive_filetypes': [] }
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=2  " Close error window automatically when there are no errors.
let g:syntastic_loc_list_height=5
let g:syntastic_enable_signs=1  " Show sidebar signs.
set statusline+=%#warningmsg#  " Add Error ruler.
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Map '`' to open error window.
nnoremap <silent> ` :Errors<CR>

" Local .vimrc
"let localvimrc_ask = 0  " Don't ask for permission to load, just do it.

" Camelcase motion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Powerline
"let g:Powerline_symbols="unicode"
let g:Powerline_stl_path_style = 'short'

" Tagbar
nnoremap <silent> \ :TagbarToggle<CR>
" Search tag list from current dir up till root.
set tags=./tags;/

" Status Line
set shortmess=atI  " Shortens messages in status line, truncates long messages, no intro (Uganda) message.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.

" Window/buffer mangement.
" L9 is necessary for fuzzyfinder.
let g:fuf_modesDisable = []
let g:fuf_ignoreCase = 1
let g:fuf_timeFormat = ''  " Remove time string.
let g:fuf_maxMenuWidth = 70
let g:fuf_file_exclude = '\v\~$|\.(exe|dll|bak|orig|swp|o|a|pyc|class)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
nnoremap <Leader>1 :FufBuffer<CR>
nnoremap <Leader>2 :FufFileWithCurrentBufferDir<CR>
nnoremap <Leader>3 :FufBufferTagAll<CR>

" Mini buffer explorer
let g:miniBufExplModSelTarget = 1  " Don't open buffer in a non-modifiable buffer (e.g. TagList window).
let g:miniBufExplCheckDupeBufs = 0  " For working with many buffers simultaneously.
let g:miniBufExplShowBufNumbers = 0  " No buffer numbers.

" Neo Complete Cache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
" <CR>: Choose completion and close.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

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
set textwidth=80  " Desirable text width. Used for text auto-wrapping. 0 means no auto-wrapping.
set cc=+1  " Highlight one column AFTER 'textwidth'.
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
set foldmethod=syntax  " Fold on the marker.
set foldlevel=0  " Fold everything when opening a file.
"set foldnestmax=1  " Don't fold inner blocks.
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
