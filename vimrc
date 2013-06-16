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

" Markdown
Bundle "tpope/vim-markdown"

" Racket
Bundle "wlangstroth/vim-racket"

" Syntax
Bundle "scrooloose/syntastic"
Bundle "tomtom/tcomment_vim"

" Navigation {{{
Bundle "majutsushi/tagbar"
Bundle "wincent/Command-T"
Bundle "Lokaltog/vim-powerline"
Bundle "scrooloose/nerdtree"
Bundle "Lokaltog/vim-easymotion"
Bundle "godlygeek/tabular"
Bundle "tpope/vim-unimpaired"
Bundle "tpope/vim-repeat"
Bundle "IndexedSearch"
Bundle "camelcasemotion"
Bundle "wikitopian/hardmode"
"}}}

" Misc {{{
Bundle "Valloric/YouCompleteMe"
Bundle "tpope/vim-surround"
" vim-misc is necessary for vim-easytags.
Bundle "xolox/vim-misc"
Bundle "xolox/vim-easytags"
Bundle "tpope/vim-fugitive"
Bundle "embear/vim-localvimrc"
Bundle "Valloric/ListToggle"
Bundle "airblade/vim-rooter"
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
set nostartofline
set splitbelow splitright  " New windows are created to the bottom-right.
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay).
set history=256  " Number of things to remember in history.
set clipboard+=unnamed  " Enable OS clipboard integration.
set hidden  " The current buffer can be put to the background without writing to disk.
set title  " Show title in app title bar.
set ttyfast  " Fast drawing.
set scrolloff=3  " Number of lines to keep above/below cursor when scrolling.
"}}}

" Status Line {{{
set shortmess=atI  " Shortens messages in status line, truncates long messages, no intro (Uganda) message.
set laststatus=2  " Always show status line.
set showcmd  " Display an incomplete command in status line.
"}}}

" Ignored files {{{
set wildignore+=*.swp  " Vim
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.psd  " Ignore images
set wildignore+=*.pdf  " Ignore PDF files
set wildignore+=*.DS_STORE
"}}}

" Key mappings {{{
let mapleader=","  " Set <leader> key to comma.
silent! call repeat#set("\<Plug>.", v:count)  " activate vim-repeat plugin.
cnoremap help vert help
imap jk <Esc>
imap kj <Esc>
imap jj <Esc>
imap kk <Esc>
" Window-change actions.
" noremap <Up> <C-w>k
" noremap <Down> <C-w>j
" noremap <Left> <C-w>h
" noremap <Right> <C-w>l
"}}}

" Searching {{{
set smartcase  " Be case sensitive when input has a capital letter.
set incsearch  " Show matches while typing.
set ignorecase  " Ignore case when searching.
set gdefault  " Make searched global `/g` by default.
if exists('&wildignorecase') | set wildignorecase | endif  " In-case-sensitive dir/file completion.
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
if ! has("win32") | set listchars=tab:▸\ ,trail:¬,eol:« | endif  " Invisible characters.
set nolist  " Don't display invisible characters.
" Custom command to strip trailing whitespaces.
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
"}}}

" Folding {{{
set foldenable  " Turn on folding.
set foldmethod=syntax  " Fold on the marker.
set foldlevel=0  " Fold everything when opening a file.
set foldopen=block,hor,tag,percent,mark,quickfix  " Which movements open folds.
""}}}

" Backup {{{
set nobackup  " Disable file backup before file overwrite attempt.
set nowritebackup
"}}}

" Mouse {{{
"Set mouse behaviour to be like the OS's.
if has ("win32") | behave mswin | else | behave xterm | endif
set mouse-=a  " Disable mouse.
set mousehide  " Hide mouse after chars typed.
behave xterm  " Make mouse behave like in xterm (instead of, e.g. Windows' command-prompt mouse).
set selectmode=mouse  " Enable visule selection with mouse.
"}}}

" Bells {{{
set novisualbell  " No blinking
"}}}
"}}}

" Plugin configurations {{{
" YouCompleteMe - YCM {{{
let g:ycm_confirm_extra_conf = 0  " Don't ask for permission to load C-languages configuration file.
let g:ycm_autoclose_preview_window_after_insertion = 1  " Close function signature preview after exiting insert mode.
" let g:ycm_max_diagnostics_to_display = 30  " Maximum numbers of  errors/warnings to display.
" let g:ycm_register_as_syntastic_checker = 0  " Disable YCM-Syntastic for C-family langauges.
"}}}

" Syntastic {{{
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 2  " Close error window automatically when there are no errors.
let g:syntastic_enable_signs = 1  " Show sidebar signs.
set statusline+=%#warningmsg#  " Add Error ruler.
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"}}}

" Command-T {{{
"let g:CommandTMaxDepth = 0  " Scan current dir only.
let g:CommandTMaxHeight = 15  " Set max window height.
let g:CommandTMatchWindowAtTop = 1  " Set window to top instead of bottom.
nnoremap <silent> <Leader>g :CommandTTag<CR>
nnoremap <silent> <Leader>f :CommandTRefreshMap<CR>
let g:CommandTCancelMap = [ "<ESC>", "<C-c>" ]
"}}}

" Powerline {{{
"let g:Powerline_symbols="unicode"
let g:Powerline_stl_path_style = 'short'
"}}}

" Tagbar {{{
let g:tagbar_sort = 0
nnoremap <silent> \ :TagbarToggle<CR>
" Search tag list from current dir up till root.
"}}}

" {{{ NERDTree
let NERDTreeQuitOnOpen = 1  " Close tree when opening a file.
let NERDTreeShowHidden = 1  " Show hidden files.
let NERDTreeChDirMode = 1  " Set tree root to :pwd.
let NERDTreeShowFiles = 1  " Show files (+ dirs) on startup.
let NERDTreeIgnore = [ '.DS_Store', '.*.swp$', '\~$' ]  " Ignore these file patterns.
let NERDTreeWinPos = 'right'  " Open window on right side.
noremap <Leader>e :NERDTreeToggle<CR>
"}}}

" EasyTags {{{
set tags=./.tags;~/
let g:easytags_file = '~/.tags'  " Default tags file.
let g:easytags_cmd = 'ctags'
let g:easytags_dynamic_files = 1  " Search tag files.
let g:easytags_updatetime_warn = 0  " Don't show updatetime annoying warning.
" let g:easytags_events = [ 'BufWritePost' ]  " Update on save only.
"}}}

" TComment {{{
let g:tcommentMapLeader1 = '<Leader>c'
" NERDCommenter-like behavior:
noremap <Leader>cc :TCommentMaybeInline<CR>
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

" ListToggle {{{
let g:lt_height = 10
"}}}
" Hard-mode {{{
" Toggle key.
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()  " Auto-activate hard-mode.
"}}}

" Rooter {{{
autocmd VimEnter * :Rooter
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
let NERDTreeIgnore += ['.*.pyc$', '*.pyc$']  " Don't display this in NERDTree.
"}}}

" Ruby {{{
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
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
let g:easytags_languages = {
            \   'racket': {
            \     'cmd': g:easytags_cmd,
            \       'args': ['--langmap=scheme:.rkt'],
            \       'fileoutput_opt': '-f',
            \       'stdout_opt': '-f-',
            \       'recurse_flag': '-R'
            \   }
            \}
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
