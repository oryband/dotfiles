" Sources {{{
" vi-improved.org/vimrc.php
" github.com/carlhuda/janus
" github.com/gmarik/vimfiles/blob/master/vimrc
" github.com/durdn/cfg/blob/master/.vimrc
" github.com/factorylabs/vimfiles
" github.com/lukerandall/dotvim/blob/master/vimrc
" github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
"}}}
" Initialization / Vundle Plugin Manager {{{
set nocompatible
filetype off

set runtimepath+=$HOME/.vim/bundle/vundle/

call vundle#rc()
Bundle "gmarik/vundle"
"}}}
" Plugins {{{
" Sane defaults
Bundle "tpope/vim-sensible"

" Colors
Bundle "oryband/vim-colors-solarized"

" HTML/CSS/JS
Bundle "matchit.zip"
Bundle "othree/html5.vim"
Bundle "lepture/vim-jinja"
Bundle "tpope/vim-liquid"
Bundle "wavded/vim-stylus"
" Bundle "ap/vim-css-color"
Bundle "pangloss/vim-javascript"
Bundle "jelera/vim-javascript-syntax"
Bundle "marijnh/tern_for_vim"

" Python
Bundle "hynek/vim-python-pep8-indent"
Bundle "hdima/python-syntax"
Bundle "tmhedberg/SimpylFold"
Bundle "jmcantrell/vim-virtualenv"

" Java
Bundle "javacomplete"
Bundle "tpope/vim-classpath"

" Markdown
Bundle "tpope/vim-markdown"

" Everything else
Bundle "mileszs/ack.vim"
Bundle "camelcasemotion"
Bundle "kien/ctrlp.vim"
Bundle "IndexedSearch"
Bundle "Valloric/ListToggle"
Bundle "scrooloose/nerdtree"
Bundle "godlygeek/tabular"
Bundle "majutsushi/tagbar"
Bundle "scrooloose/syntastic"
Bundle "bling/vim-airline"
Bundle "tpope/vim-commentary"
Bundle "xolox/vim-easytags"
Bundle "tpope/vim-fugitive"
Bundle "airblade/vim-gitgutter"
Bundle "xolox/vim-misc"
Bundle "justinmk/vim-sneak"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-unimpaired"
Bundle "Valloric/YouCompleteMe"
"}}}
" Options {{{
" Colors {{{
set background=dark
colorscheme solarized
"}}}
" Spaces {{{
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
"}}}
" Status Line {{{
set shortmess=atI
set noshowmode
"}}}
" Ignored {{{
set wildignore+=*.swp,.git/,*.jpg,*.jpeg,*.png,*.gif,*.psd,*.pdf,*.DS_Store
set wildignore+=*.pyc,*.pyo,*.egg,*.egg-info
set wildignore+=*.a,*.o,*.so
set wildignore+=*.class
"}}}
" Keys {{{
let mapleader=","
cabbrev vhelp vert help
inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
nnoremap <silent> <C-j> <C-W>j
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l
"}}}
" Searching {{{
set smartcase
set ignorecase
set gdefault
set wildmode=list:longest
if exists('&wildignorecase') | set wildignorecase | endif
"}}}
" Format {{{
set nowrap
set linebreak
set textwidth=79
set colorcolumn=+1
set relativenumber
set matchtime=3
set nolist
set nosmartindent
set cindent
augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions=crqn2l1j
augroup END

function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call StripTrailingWhitespaces()
"}}}
" Folding {{{
set foldenable
set foldmethod=syntax
set foldlevel=0
set foldopen=block,hor,tag,percent,mark,quickfix

function! FoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)

    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=FoldText()
"}}}
" Backup {{{
set nobackup
set nowritebackup
"}}}
" Mouse {{{
behave xterm
set mouse-=a
set mousehide
"}}}
" Bells {{{
set novisualbell
"}}}
" Misc. {{{
set nostartofline
set splitbelow splitright
set clipboard+=unnamed
set hidden
set title
set lazyredraw
set ttyfast
"}}}
"}}}
" Plugin configurations {{{
" Airline {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
"}}}
" Camelcase motion {{{
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
"}}}
" CtrlP {{{
let g:ctrlp_map = '<Leader>p'
noremap <silent> <Leader>b :CtrlPBuffer<CR>
noremap <silent> <Leader>t :CtrlPTag<CR>
"}}}
" EasyTags {{{
set tags=./.tags;~/
let g:easytags_file = '~/.tags'
let g:easytags_cmd = 'ctags'
let g:easytags_dynamic_files = 1
let g:easytags_updatetime_warn = 0
let g:easytags_events = ['BufWritePost']
"}}}
" ListToggle {{{
let g:lt_height = 10
"}}}
" NERDTree {{{
let NERDChristmasTree = 1
let NERDTreeShowHidden = 1
let NERDTreeChDirMode = 1
let NERDTreeShowFiles = 1
let NERDTreeMinimalUI = 1
let NERDTreeWinPos = 'right'
let NERDTreeIgnore = [
            \ '.DS_Store', '.*.swp$', '\~$',
            \ '.*.class$',
            \ '.*.pyc$', '*.pyc$'
            \ ]

augroup NERD-Tree
    autocmd!
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

noremap <silent> <Leader>n :NERDTreeToggle<CR>
"}}}
" Python {{{
let python_slow_sync = 1
let python_highlight_builtins = 1
let python_highlight_builtin_objs = 1
let python_highlight_builtin_funcs = 1
let python_highlight_exceptions = 1
let python_highlight_string_formatting = 1
let python_highlight_string_format = 1
let python_highlight_string_templates = 1
let python_highlight_indent_errors = 0
let python_highlight_space_errors = 0
let python_highlight_doctests = 1
let python_print_as_function = 1
let python_highlight_file_headers_as_comments = 1
"}}}
" Repeat {{{
silent! call repeat#set("\<Plug>.", v:count)
"}}}
" Sneak {{{
highlight link SneakPluginTarget Visual

nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
xmap <leader>s <Plug>Sneak_s
xmap <leader>S <Plug>Sneak_S
omap <leader>s <Plug>Sneak_s
omap <leader>S <Plug>Sneak_S

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
"}}}
" Syntastic {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '♫'
let g:syntastic_style_error_symbol = '♪'

let g:syntastic_html_checkers = ['tidy', 'jshint']

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
"}}}
" Tagbar {{{
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags' }

nnoremap <silent> <Leader>a :TagbarToggle<CR>
"}}}
" Tern {{{
let g:tern#command = ['tern', '--no-port-file']
let g:tern_show_signature_in_pum = 1
" let g:tern_show_argument_hints = 'on_move'
"}}}
" Virtualenv {{{
" let g:virtualenv_auto_activate = 1
"}}}
" YouCompleteMe - YCM {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
"}}}
" Autocmds {{{
" BufWinEnter {{{
augroup Buf-Win-Enter
    autocmd!
    autocmd BufWinEnter *.less setfiletype less
    autocmd BufWinEnter *.json,.jshintrc,.tern-config,.tern-project setfiletype javascript
    autocmd BufWinEnter *.md,*.markdown setfiletype markdown
augroup END
"}}}
" FileType {{{
augroup File-Type
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType html,xml,jinja,liquid,css,scss,less,stylus,ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType html,xml,jinja,liquid runtime! macros/matchit.vim
    autocmd FileType jinja setlocal commentstring={#\ %s\ #}
    autocmd FileType css,scss,less,stylus setlocal omnifunc=csscomplete#CompleteCSS
    " autocmd FileType javascript call JavaScriptFold()
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete completefunc=javacomplete#CompleteParamsInfo makeprg=mvn\ compile\ -q
    autocmd FileType tex setlocal number norelativenumber
augroup END
"}}}
"}}}
