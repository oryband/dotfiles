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
" Plugins {{{
" Init vim-plug {{{
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
"}}}
" Sane defaults {{{
Plug 'tpope/vim-sensible'
Plug 'kana/vim-fakeclip'
"}}}
" Colors {{{
Plug 'chriskempson/base16-vim'
"}}}
" Languages {{{
" Indent {{{
Plug 'tweekmonster/braceless.vim', { 'for': [ 'python', 'ruby', 'yaml' ] }
"}}}
" HTML {{{
Plug 'matchit.zip', { 'for': 'html' }
Plug 'othree/html5.vim', { 'for': 'html' }
"}}}
" Templates {{{
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
Plug 'tpope/vim-liquid', { 'for': 'liquid' }
"}}}
" CSS {{{
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
"}}}
" Javascript {{{
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'elzr/vim-json', { 'for': ['json', 'javascript'] }
"}}}
" Python {{{
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
"}}}
" Ruby {{{
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
"}}}
" Go {{{
Plug 'fatih/vim-go', { 'for': ['go', 'gohtmltmpl'] }
"}}}
" sh,bash,zsh {{{
Plug 'vitalk/vim-shebang' ", { 'for': ['sh', 'zsh', 'csh', 'ash', 'dash', 'ksh', 'pdksh', 'mksh', 'tcsh'] }
"}}}
" Docker {{{
" Plug 'ekalinin/Dockerfile.vim'
Plug 'tianon/vim-docker', { 'for': 'dockerfile' }
"}}}
" Markdown {{{
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
"}}}
" i3 {{{
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
"}}}
" Nginx {{{
Plug 'fatih/vim-nginx', { 'for': 'nginx' }
"}}}
"}}}
" Everything else {{{
Plug 'rking/ag.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'camelcasemotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
Plug 'tpope/vim-dispatch'
Plug 'IndexedSearch'
Plug 'Konfekt/FastFold'
Plug 'Valloric/ListToggle'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'papanikge/vim-voogle'
Plug 'regedarek/ZoomWin'

function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !python install.py --gocode-completer --tern-completer
    endif
endfunction
" load YCM on first insert command
Plug 'Valloric/YouCompleteMe', {
            \ 'for': [ 'vim', 'python', 'go', 'json', 'sh', 'zsh' ],
            \ 'do': function('BuildYCM')
            \ }

autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
"}}}
" Finish Init vim-plug {{{
call plug#end()
"}}}
"}}}
" Options {{{
" Colors {{{
set background=dark
let base16colorspace=256
colorscheme base16-eighties
"}}}
" Spaces {{{
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
"}}}
" Status Line {{{
set shortmess=atI
set noshowmode
"}}}
" Ignored {{{
set wildignore+=*.swp,.git/,*.jpg,*.jpeg,*.png,*.gif,*.psd,*.pdf,\.DS_Store,\.empty
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

nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :

nnoremap <silent> <C-j> <C-W>j
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

" inoremap 1 !
" inoremap 2 @
" inoremap 3 #
" inoremap 4 $
" inoremap 5 %
" inoremap 6 ^
" inoremap 7 &
" inoremap 8 *
" inoremap 9 (
" inoremap 0 )
" inoremap - _

" inoremap ! 1
" inoremap @ 2
" inoremap # 3
" inoremap $ 4
" inoremap % 5
" inoremap ^ 6
" inoremap & 7
" inoremap * 8
" inoremap ( 9
" inoremap ) 0
" inoremap _ -
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
set relativenumber
set matchtime=3
set nolist
set nosmartindent
set cindent
syntax sync minlines=256
set lazyredraw
set ttyfast

nnoremap <silent> <Leader>r :redraw!<CR>

augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions=crqn2l1j
augroup END

" Set color column per file type.
function! ColorColumnPerFileType()
    call clearmatches()
    let langs = ["python","ruby"]
    if index(langs, &filetype) >= 0 | call matchadd('ColorColumn', printf('\%%%dv', &textwidth+1), -1) | endif
endfunc

" Set new/old regexp engine per file type.
function! RegExpEnginePerFileType()
    call clearmatches()
    let langs = ["go"]
    if index(langs, &filetype) >= 0 | set regexpengine=1 | else | set regexpengine=0 | endif
endfunc

" Set maximum syntax color column.
function! SynMaxColPerFileType()
    let langs = ["go"]
    if index(langs, &filetype) >= 0 | set synmaxcol=1000 | else | set synmaxcol=3000 | endif
endfunc
"}}}
" Folding {{{
set foldenable
if &diff | set foldmethod=diff | else | set foldmethod=syntax | endif
set foldlevel=0
set foldopen=block,hor,tag,percent,mark,quickfix

function! FoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2)
    let fillcharcount = windowwidth - len(line)

    return line . repeat(" ", fillcharcount)
endfunction " }}}
set foldtext=FoldText()
"}}}
" Backup {{{
set nobackup
set nowritebackup
set directory=~/.vim/swp//
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
set hidden
set title
"}}}
" Languages {{{
" sh,bash,zsh {{{
let g:sh_fold_enabled = 3
let g:zsh_fold_enable = 1
let g:is_bash=1
"}}}
"}}}
"}}}
" Plugin configurations {{{
" Ag {{{
let g:ag_prg = "ag --column --smart-case --follow"
let g:ag_mapping_message = 0
cabbrev ag Ag!
cabbrev Ag Ag!
"}}}
" Airline {{{
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#branch#displayed_head_limit = 15
"}}}
" Autoformat {{{
nmap <Leader>f ;Autoformat<CR>
let g:formatters_go = ['gofmt_1', 'gofmt_2']  " disable goimports
"}}}
" Braceless {{{
let g:braceless_line_continuation = 0
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
let g:ctrlp_working_path_mode = 'raw'
let g:ctrlp_lazy_update = 0
let g:ctrlp_map = '<Leader>p'
noremap <silent> <Leader>b :CtrlPBuffer<CR>
noremap <silent> <Leader>t :CtrlPTag<CR>
let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("j")': ['<c-n>'],
            \ 'PrtSelectMove("k")': ['<c-p>'],
            \ 'PrtHistory(-1)':  ['<c-j>'],
            \ 'PrtHistory(1)': ['<c-k>'],
            \ }
call ctrlp_bdelete#init()
"}}}
" EasyAlign {{{
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
"}}}
" EasyTags {{{
set cpoptions+=d
let g:easytags_file = '~/.vim/.vimtags'
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_dynamic_files = 2
let g:easytags_async = 1
let g:easytags_resolve_links = 1
let g:easytags_suppress_report = 1

" let g:easytags_languages = {
"             \   'javascript': {
"             \       'cmd': 'jsctags',
"             \       'args': [],
"             \       'fileoutput_opt': '-f',
"             \       'stdout_opt': '-f-',
"             \       'recurse_flag': '-R'
"             \   }
"             \}
"}}}
" FakeClip {{{
let g:fakeclip_terminal_multiplexer_type = 'tmux'
"}}}
" Vim-Go {{{
let g:go_dispatch_enabled = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
" let g:go_fmt_experimental = 1
" let g:go_textobj_enabled = 1
let g:go_guru_tags = 'integration'

" let g:go_highlight_array_whitespace_error = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_chan_whitespace_error = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_space_tab_error = 1
" let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
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
            \ '.DS_Store', '\.swp$', '\~$', '.empty',
            \ '\.jpg$', '\.jpeg$', '\.png$', '\.gif$', '\.pdf$',
            \ '\.class$',
            \ '\.a$', '\.o$', '\.so$',
            \ '\.pyc$', '\.pyo$',
            \ '\.tags$'
            \ ]

" augroup NERD-Tree
"     autocmd!
"     autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" augroup END

noremap <silent> <Leader>n :NERDTreeToggle<CR>
"}}}
" Python {{{
let python_slow_sync = 1
let python_highlight_indent_errors = 0
let python_highlight_space_errors = 0
let python_highlight_all = 1
"}}}
" Repeat {{{
silent! call repeat#set("\<Plug>.", v:count)
"}}}
" Signify {{{
let g:signify_vcs_list = [ 'git' ]
"}}}
" Sneak {{{
highlight link SneakPluginTarget Visual

map : <Plug>SneakNext

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
" noremap <silent> <Leader>c :echo "Checking..."<CR> :SyntasticCheck<CR>
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:syntastic_filetype_map = {
            \ 'jinja': 'html',
            \ 'liquid': 'html',
            \ 'stylus': 'css',
            \ 'scss': 'css',
            \ 'less': 'css'
            \ }

let g:syntastic_id_checkers = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 2

let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = 'E'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_warning_symbol = 'SW'
let g:syntastic_style_error_symbol = 'SE'
highlight link SyntasticStyleErrorSign Todo

let g:syntastic_python_checkers = ['pylint', 'pep8', 'pydocstyle']
let g:syntastic_html_checkers = ['tidy', 'jshint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:syntastic_go_checkers = [ 'go', 'gometalinter' ]
let syntastic_go_gometalinter_args = '-t -D testify -D test -D gofmt -D goimports -D gotype -D structcheck -D dupl -D gocyclo -D aligncheck'
let g:syntastic_go_go_build_args = '-tags="'.g:go_guru_tags.'"'
let g:syntastic_go_go_test_args = g:syntastic_go_go_build_args

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
nnoremap <silent> <Leader>g :TagbarToggle<CR>

let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags' }
"}}}
" Tern {{{
let g:tern#command = ['tern', '--no-port-file']
let g:tern_show_signature_in_pum = 1
let g:tern_show_argument_hints = 'on_move'
"}}}
" Virtualenv {{{
" let g:virtualenv_directory = 'venv'
"}}}
" Vundle {{{
cabbrev BundleInstall PluginInstall
cabbrev BundleInstall! PluginInstall!
cabbrev BundleClean PluginClean
cabbrev BundleClean! PluginClean!
cabbrev BundleList PluginList
cabbrev BundleList! PluginList!
cabbrev BundleSearch PluginSearch
cabbrev BundleSearch! PluginSearch!
"}}}
" YouCompleteMe - YCM {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_python_binary_path = 'python'  " support virtualenv

" Call YCM/Go/js GoTo depending on file type.
function! GoToDef()
    if &ft == 'go'
        call go#def#Jump('')
    elseif &ft == 'javascript'
        execute 'TernDef'
    else
        execute 'YcmCompleter GoTo'
    endif
endfunction
nnoremap <leader>] :call GoToDef()<CR>
"}}}
" Autocmds {{{
" BufWinEnter {{{
augroup Buf-Win-Enter
    autocmd!
    autocmd BufWinEnter * call ColorColumnPerFileType() | call RegExpEnginePerFileType() | call SynMaxColPerFileType()
    autocmd BufWinEnter *.less setfiletype less
    autocmd BufWinEnter *.md,*.markdown setfiletype markdown
    autocmd BufWinEnter *.sql setfiletype mysql
    autocmd BufWinEnter .jshintrc setfiletype javascript
    autocmd BufWinEnter .tern-config,.tern-project setfiletype json
    autocmd BufWinEnter *.zsh-theme setfiletype zsh
augroup END
"}}}
" BufWrite {{{
augroup Buf-Write
    au BufWrite *.go,*.json,*.html :Autoformat
augroup END
"}}}
" FileType {{{
augroup MiscSettings
    autocmd!
    autocmd FileType * set tags=./.tags;,~/.vim/.vimtags
    autocmd FileType python,ruby BracelessEnable +indent
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType go nmap <Leader>d <Plug>(go-doc-vertical) | nmap <Leader>i <Plug>(go-info)
    autocmd FileType html,json,xml,jinja,liquid,css,scss,less,stylus,ruby,yaml,gitcommit,nginx setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType html,xml,jinja,liquid runtime! macros/matchit.vim
    autocmd FileType qf setlocal wrap
    autocmd FileType scss,less,stylus setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType tex setlocal number norelativenumber
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup CommentStrings
    autocmd FileType i3 setlocal commentstring=#\ %s
    autocmd FileType jinja setlocal commentstring={#\ %s\ #}
    autocmd FileType xdefaults setlocal commentstring=!\ %s
    autocmd FileType gohtmltmpl setlocal commentstring={{/*\ %s\ */}}
    autocmd FileType nginx setlocal commentstring=#\ %s
augroup END
"}}}
"}}}
"}}}
