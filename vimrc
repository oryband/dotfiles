" Great sources & credits: {{{
" Example vimrc - http://www.vi-improved.org/vimrc.php
" gmarik - https://github.com/gmarik/vimfiles/blob/master/vimrc
" durdn - https://github.com/durdn/cfg/blob/master/.vimrc
" FactoryLab - https://github.com/factorylabs/vimfiles
" lukerandall - https://github.com/lukerandall/dotvim/blob/master/vimrc
" mathiasbynens - https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" Graphical cheat sheet - http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
"}}}

" Initialization / Vundle Plugin Manager {{{
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
"}}}

" Plugins {{{
" Colors
Bundle "nanotech/jellybeans.vim"

" Web {{{
Bundle "pangloss/vim-javascript"
Bundle "lepture/vim-jinja"
Bundle "tpope/vim-liquid"
"Bundle "lepture/vim-css"
Bundle "cakebaker/scss-syntax.vim"
Bundle "groenewege/vim-less"
Bundle "matchit.zip"
Bundle "ap/vim-css-color"
"}}}

" Python
Bundle "hynek/vim-python-pep8-indent"
Bundle "python.vim--Vasiliev"

" Haskell {{{
"Bundle "bitc/lushtags"
"Bundle "Twinside/vim-haskellConceal"
"Bundle "Twinside/vim-hoogle"
"Bundle "indenthaskell.vim"
"Bundle "haskell.vim"
"Bundle "syntaxhaskell.vim"
"}}}

" Markdown
Bundle "tpope/vim-markdown"

" Racket
Bundle "wlangstroth/vim-racket"

" Syntax
Bundle "scrooloose/syntastic"
Bundle "scrooloose/nerdcommenter"
Bundle "nathanaelkane/vim-indent-guides"

" Navigation {{{
Bundle "IndexedSearch"
Bundle "camelcasemotion"
Bundle "Lokaltog/vim-powerline"
Bundle "majutsushi/tagbar"
Bundle "godlygeek/tabular"
Bundle "tpope/vim-unimpaired"
Bundle "L9"
Bundle "FuzzyFinder"
Bundle "techlivezheng/vim-plugin-minibufexpl"
"}}}

" Misc {{{
Bundle "Valloric/YouCompleteMe"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "AutoTag"
Bundle "embear/vim-localvimrc"
Bundle "Valloric/ListToggle"
"Bundle "ryan-cf/netrw"

filetype plugin indent on  " Automatically detect file types, and enable file-type-specific plugins and indentation.
set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4
syntax on
"}}}
"}}}

" Options {{{
" Colors {{{
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
"}}}

" Misc. {{{
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
"}}}

" Status Line {{{
set shortmess=atI  " Shortens messages in status line, truncates long messages, no intro (Uganda) message.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.
"}}}

" Searching {{{
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
"}}}

" Formatting & Text {{{
set encoding=utf-8
set nowrap  " No line wrapping.
set linebreak  " Wrap at word.
set textwidth=80  " Desirable text width. Used for text auto-wrapping. 0 means no auto-wrapping.
set colorcolumn=+1  " Highlight one column AFTER 'textwidth'.
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
" Add a custom command to strip trailing whitespaces.
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call StripTrailingWhitespaces()
"}}}

" Indentation {{{
set autoindent  " Automatically set the indent of a new line (local to buffer).
set smartindent
"set shiftround  " Round shift actions. i.e. When at 3 spaces, and I hit > ... go to 4, not 5. FIXME: Doesn't work.
"}}}

" Folding {{{
set foldenable  " Turn on folding.
set foldmethod=syntax  " Fold on the marker.
set foldlevel=0  " Fold everything when opening a file.
"set foldnestmax=1  " Don't fold inner blocks.
set foldopen=block,hor,tag,percent,mark,quickfix  " Which movements open folds.
""}}}

" Backup {{{
set nobackup  " Disable file backup before file overwrite attempt.
set nowritebackup
"}}}

" Window splitting {{{
"set equalalways  " Multiple windows, when created, are equal in size. NOTE: Doesn't work well with MiniBufExpl.vim
set splitbelow splitright  " New windows are created to the bottom-right.
"}}}

" Mouse {{{
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
"}}}

" Bells {{{
set novisualbell  " No blinking
"set noerrorbells  " No noise.
"set vb t_vb= " Disable any beeps or flashes on error
"}}}

" Ignored files {{{
set wildignore+=*.swp  " Vim
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.psd  " Ignore images
set wildignore+=*.pdf  " Ignore PDF files
set wildignore+=*.DS_STORE
"}}}

" Key mappings {{{
" Page up/down.
noremap <C-k> <C-b>
noremap <C-j> <C-f>
" Window-change actions.
noremap <Up> <C-w>k
noremap <Down> <C-w>j
noremap <Left> <C-w>h
noremap <Right> <C-w>l
"}}}
"}}}

" Plugin configurations {{{
" YouCompleteMe {{{
let g:ycm_confirm_extra_conf = 0  " Don't ask for permission to load C/C++ conf.
let g:ycm_register_as_syntastic_checker = 0  " Disable YCM-Syntastic for C-family langauges.
"}}}

" Syntastic {{{
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
"let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=2  " Close error window automatically when there are no errors.
let g:syntastic_enable_signs=1  " Show sidebar signs.
set statusline+=%#warningmsg#  " Add Error ruler.
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"}}}

" Local .vimrc {{{
let localvimrc_ask = 0  " Load .lvimrc without asking.
let g:localvimrc_sandbox = 0  " No sandbox (less secure).
"}}}

" Camelcase motion {{{
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
"}}}

" Powerline {{{
"let g:Powerline_symbols="unicode"
let g:Powerline_stl_path_style = 'short'
"}}}

" Tagbar {{{
nnoremap <silent> \ :TagbarToggle<CR>
" Search tag list from current dir up till root.
set tags=./tags;/
"}}}

" Window/buffer mangement. {{{
" L9 is necessary for fuzzyfinder.
let g:fuf_modesDisable = []
let g:fuf_ignoreCase = 1
let g:fuf_timeFormat = ''  " Remove time string.
let g:fuf_maxMenuWidth = 70
let g:fuf_file_exclude = '\v\~$|\.(exe|dll|bak|orig|swp|o|a|pyc|class)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
nnoremap <Leader>1 :FufBuffer<CR>
nnoremap <Leader>2 :FufFileWithCurrentBufferDir<CR>
nnoremap <Leader>3 :FufBufferTagAll<CR>
"}}}

" Mini buffer explorer {{{
let g:miniBufExplShowBufNumbers = 0  " No buffer numbers.
"}}}

" ListToggle {{{
let g:lt_location_list_toggle_map = '<leader>`'
let g:lt_height = 10
"}}}
"}}}

" Language-specific {{{
" Vim {{{
autocmd FileType vim setlocal foldmethod=marker
"}}}

" Web {{{
autocmd BufWinEnter *.html,*.htm setfiletype html
autocmd BufWinEnter *.scss setfiletype scss
autocmd BufWinEnter *.less setfiletype less
autocmd BufWinEnter *.json,*jshintrc setfiletype javascript
autocmd FileType html setlocal filetype=jinja
autocmd FileType css,scss,less set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html,jinja,liquid set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html,jinja,liquid,css,scss,less setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType html,jinja,liquid runtime! macros/matchit.vim
"autocmd BufWritePost *.scss,*.sass !compass compile ../ <afile> --force
"}}}

" Python {{{
let python_highlight_all=1  " Enable all plugin's highlighting.
let python_slow_sync=1  " For fast machines.
let python_print_as_function=1  " Color 'print' function.
autocmd FileType python setlocal linebreak nosmartindent  " nosmartindent for comment indentation problem.
autocmd FileType python set omnifunc=pythoncomplete#Complete
set wildignore+=*.pyc,*.pyo
set wildignore+=*.egg,*.egg-info
"}}}

" Ruby {{{
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
"}}}

" Haskell {{{
"let g:haskell_indent_if=3
"let g:haskell_indent_case=5
let hs_highlight_boolean=1
let hs_highlight_types=1
let hs_highlight_debug=1
let hs_allow_hash_operator=1
set wildignore+=*.hi,*.o
"}}}

" C/C++ {{{
let g:syntastic_c_compiler_options = '-ansi -Wall -Wextra'
let g:syntastic_cpp_compiler_options = '-Wall -Wextra -Weffc++'
let g:syntastic_c_include_dirs = [ 'includes', 'include', 'inc',  'headers' ]

let g:syntastic_c_check_header = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_c_remove_include_errors = 1

let g:syntastic_cpp_check_header = g:syntastic_c_check_header
let g:syntastic_cpp_include_dirs = g:syntastic_c_include_dirs
let g:syntastic_cpp_auto_refresh_includes = g:syntastic_c_auto_refresh_includes
let g:syntastic_cpp_remove_include_errors = g:syntastic_c_remove_include_errors
set wildignore+=*.a,*.o,*.so
"}}}

" Java {{{
autocmd FileType ant setlocal expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2
let g:syntastic_java_checker = "javac"
let g:syntastic_java_javac_delete_output=0  " Don't delete .class files after syntax check.
set wildignore+=*.class
"}}}

" Markdown {{{
autocmd BufWinEnter *.md,*.markdown setfiletype markdown
"}}}

" Assembly {{{
autocmd BufWinEnter *.s,*.bin setfiletype nasm
"}}}

" Racket {{{
"autocmd BufWinEnter *.rkt,*.rktl setfiletype scheme
autocmd FileType scheme setlocal lisp tabstop=2 softtabstop=2 shiftwidth=2
"}}}

" Bash/Shell {{{
autocmd BufWinEnter *bashrc,*bash_prompt,*bash_profile,*aliases setfiletype sh
"}}}

" Git {{{
autocmd BufWinEnter *gitconfig setfiletype gitconfig
"}}}

" SSH {{{
autocmd BufWinEnter *sshconfig setfiletype sshconfig
"}}}
"}}}
