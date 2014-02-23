" Great sources & credits: {{{
" Example vimrc - vi-improved.org/vimrc.php
" janus - github.com/carlhuda/janus
" gmarik - github.com/gmarik/vimfiles/blob/master/vimrc
" durdn - github.com/durdn/cfg/blob/master/.vimrc
" FactoryLab - github.com/factorylabs/vimfiles
" lukerandall - github.com/lukerandall/dotvim/blob/master/vimrc
" mathiasbynens - github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" Graphical cheat sheet - viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
"}}}

" Initialization / Vundle Plugin Manager {{{
set nocompatible  " Disable vi compatibility (more efficient, and besides - we're using non-vi tricks here).
filetype off

if has ("win32") | set runtimepath+=$HOME/vimfiles/bundle/vundle/
else | set runtimepath+=$HOME/.vim/bundle/vundle/ | endif

call vundle#rc()
Bundle "gmarik/vundle"
"}}}

" Plugins {{{
" Colors
Bundle "nanotech/jellybeans.vim"

" Web {{{
Bundle "othree/html5.vim"
Bundle "pangloss/vim-javascript"
Bundle "lepture/vim-jinja"
Bundle "tpope/vim-liquid"
Bundle "wavded/vim-stylus"
Bundle "matchit.zip"
" Bundle "ap/vim-css-color"
"}}}

" Python
Bundle "hynek/vim-python-pep8-indent"
Bundle "python.vim--Vasiliev"
Bundle "tmhedberg/SimpylFold"

" Markdown
Bundle "tpope/vim-markdown"

" Syntax
Bundle "scrooloose/syntastic"
Bundle "tpope/vim-commentary"

" Navigation {{{
Bundle "majutsushi/tagbar"
Bundle "kien/ctrlp.vim"
Bundle "bling/vim-airline"
Bundle "scrooloose/nerdtree"
Bundle "mileszs/ack.vim"
Bundle "justinmk/vim-sneak"
Bundle "godlygeek/tabular"
Bundle "tpope/vim-unimpaired"
Bundle "tpope/vim-repeat"
Bundle "IndexedSearch"
Bundle "camelcasemotion"
"}}}

" Misc {{{
Bundle "Valloric/YouCompleteMe"
Bundle "tpope/vim-surround"
" vim-misc is necessary for vim-easytags.
" Bundle "xolox/vim-misc"
" Bundle "xolox/vim-easytags"
Bundle "tpope/vim-fugitive"
Bundle "airblade/vim-gitgutter"
Bundle "Valloric/ListToggle"
Bundle "tpope/vim-sensible"

set expandtab tabstop=4 softtabstop=4 shiftwidth=4
"}}}
"}}}

" Options {{{
" Colors {{{
set t_Co=256  " Set terminal to display 256 colors.
set background=dark
" Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
" Works for jellybeans color scheme only.
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
set clipboard+=unnamed  " Enable OS clipboard integration.
set hidden  " The current buffer can be put to the background without writing to disk.
set title  " Show title in app title bar.
set ttyfast  " Fast drawing.
"}}}

" Status Line {{{
set shortmess=atI  " Shortens messages in status line, truncates long messages, no intro (Uganda) message.
set noshowmode  " Hide the default mode text (e.g. -- INSERT -- below the statusline)
"}}}

" Ignored files {{{
set wildignore+=*.swp,.git/,*.jpg,*.jpeg,*.png,*.gif,*.psd,*.pdf,*.DS_Store
"}}}

" Key mappings {{{
let mapleader=","  " Set <leader> key to comma.
silent! call repeat#set("\<Plug>.", v:count)  " activate vim-repeat plugin.
cabbrev vhelp vert help
inoremap jk <Esc>
map <silent> <C-j> <C-W>j
map <silent> <C-k> <C-W>k
map <silent> <C-h> <C-W>h
map <silent> <C-l> <C-W>l
" move line-wise, not screen-size.
nnoremap j gj
nnoremap k gk
"}}}

" Searching {{{
set smartcase  " Be case sensitive when input has a capital letter.
set ignorecase  " Ignore case when searching.
set gdefault  " Make searched global `/g` by default.
if exists('&wildignorecase') | set wildignorecase | endif  " In-case-sensitive dir/file completion.
set wildmode=list:longest  " List options when hitting tab, and match longest common command.
"}}}

" Formatting & Text {{{
set nowrap  " No line wrapping.
set linebreak  " Wrap at word.
set textwidth=79  " Desirable text width. Used for text auto-wrapping. 0 means no auto-wrapping.
set colorcolumn=+1  " Highlight one column AFTER 'textwidth'.
" Enable auto-wrapping comments, comment leader auto-insertion
" in <Insert> mode, auto-format paragraphs, keep last line indentation.
" Disable all other format options.
" NOTE: Requires 'set autoindent'. autocmd FileType is required since
" I set `formatoptions` differently for each file type (.c, .py, etc.)."
autocmd FileType * set formatoptions=r,2
set relativenumber  " Use relative line numbering.
set matchtime=3  " How many tenths of a second to wait before showing matching braces.
" if ! has("win32") | set listchars=tab:▸\ ,trail:¬,eol:« | endif  " Invisible characters.
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
let g:syntastic_style_warning_symbol = '♫'
let g:syntastic_style_error_symbol = '♪'
let g:syntastic_auto_loc_list = 2  " Close error window automatically when there are no errors.
let g:syntastic_enable_signs = 1  " Show sidebar signs.
let g:syntastic_mode_map = { 'passive_filetypes': ['html'] }
"}}}

" Airline {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
"}}}

" Sneak {{{
nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
xmap <leader>s <Plug>Sneak_s
xmap <leader>S <Plug>Sneak_S
omap <leader>s <Plug>Sneak_s
omap <leader>S <Plug>Sneak_S

" nmap f <Plug>Sneak_f
" nmap F <Plug>Sneak_F
" xmap f <Plug>Sneak_f
" xmap F <Plug>Sneak_F
" omap f <Plug>Sneak_f
" omap F <Plug>Sneak_F

" nmap t <Plug>Sneak_t
" nmap T <Plug>Sneak_T
" xmap t <Plug>Sneak_t
" xmap T <Plug>Sneak_T
" omap t <Plug>Sneak_t
" omap T <Plug>Sneak_T
"}}}

" Tagbar {{{
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
nnoremap <silent> <Leader>a :TagbarToggle<CR>
"}}}

" CtrlP {{{
let g:ctrlp_map = '<Leader>p'
noremap <silent> <Leader>b :CtrlPBuffer<CR>
noremap <silent> <Leader>t :CtrlPTag<CR>
"}}}

" {{{ NERDTree
let NERDTreeQuitOnOpen = 1  " Close tree when opening a file.
let NERDTreeShowHidden = 1  " Show hidden files.
let NERDTreeChDirMode = 1  " Set tree root to :pwd.
let NERDTreeShowFiles = 1  " Show files (+ dirs) on startup.
let NERDTreeIgnore = [ '.DS_Store', '.*.swp$', '\~$' ]  " Ignore these file patterns.
let NERDTreeWinPos = 'right'  " Open window on right side.
noremap <Leader>n :NERDTreeToggle<CR>
"}}}

" EasyTags {{{
set tags=./.tags;~/
let g:easytags_file = '~/.tags'  " Default tags file.
let g:easytags_cmd = 'ctags'
let g:easytags_dynamic_files = 1  " Search tag files.
let g:easytags_updatetime_warn = 0  " Don't show updatetime annoying warning.
" let g:easytags_events = [ 'BufWritePost' ]  " Update on save only.
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

" Language-specific {{{
" Vim {{{
autocmd FileType vim setlocal foldmethod=marker
"}}}

" Web {{{
autocmd BufWinEnter *.html,*.htm setfiletype jinja
autocmd BufWinEnter *.sass,*.scss setfiletype scss
autocmd BufWinEnter *.less setfiletype less
autocmd BufWinEnter *.json,*jshintrc setfiletype javascript
autocmd FileType css,scss,less,stylus set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html,jinja,liquid set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html,jinja,liquid,css,scss,less,stylus setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType html,jinja,liquid runtime! macros/matchit.vim
autocmd FileType jinja set commentstring={#\ %s\ #}
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
autocmd FileType ant setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
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
