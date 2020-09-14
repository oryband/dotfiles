" Sources {{{
" vi-improved.org/vimrc.php
" github.com/carlhuda/janus
" github.com/gmarik/vimfiles/blob/master/vimrc
" github.com/durdn/cfg/blob/master/.vimrc
" github.com/factorylabs/vimfiles
" github.com/lukerandall/dotvim/blob/master/vimrc
" github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
" }}}
" Plugins {{{
" Init vim-plug {{{
set nocompatible

call plug#begin(stdpath('data') . '/plugged')
" }}}
" Sane defaults {{{
Plug 'tpope/vim-sensible'
" }}}
" Colors {{{
Plug 'chriskempson/base16-vim'
" }}}
" Languages {{{
" HTML {{{
Plug 'tmhedberg/matchit', { 'for': 'html' }
Plug 'othree/html5.vim', { 'for': 'html' }
" }}}
" Templates {{{
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
Plug 'tpope/vim-liquid', { 'for': 'liquid' }
" }}}
" C++ {{{
Plug 'bfrg/vim-cpp-modern', { 'for': 'cpp' }
Plug 'prabirshrestha/async.vim', { 'for': 'cpp' }
Plug 'prabirshrestha/vim-lsp', { 'for': 'cpp' }
Plug 'pdavydov108/vim-lsp-cquery', { 'for': 'cpp' }

" }}}
" Clojure {{{
Plug 'fbeline/kibit-vim', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-slamhound', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
" }}}
" Javascript {{{
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'elzr/vim-json', { 'for': ['json', 'javascript'] }
" }}}
" Typescript {{{
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" }}}
" Python {{{
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
" }}}
" sh,bash,zsh {{{
Plug 'vitalk/vim-shebang' ", { 'for': ['sh', 'zsh', 'csh', 'ash', 'dash', 'ksh', 'pdksh', 'mksh', 'tcsh'] }
" }}}
" Docker {{{
" Plug 'ekalinin/Dockerfile.vim'
Plug 'tianon/vim-docker', { 'for': 'dockerfile' }
" }}}
" Markdown {{{
Plug 'godlygeek/tabular', { 'for': ['clojure', 'markdown'] }  " plasticboy dependency
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" }}}
" i3 {{{
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
" }}}
" Nginx {{{
Plug 'fatih/vim-nginx', { 'for': 'nginx' }
" }}}
" HCL {{{
Plug 'fatih/vim-hclfmt', { 'do': 'go get -u github.com/fatih/hclfmt' }
Plug 'hashivim/vim-terraform'
" }}}
" YAML {{{
Plug 'pedrohdz/vim-yaml-folds', { 'for': 'yaml' }
" }}}
" TOML {{{
Plug 'cespare/vim-toml', { 'for': 'toml' }
" }}}
" Solidity {{{
Plug 'tomlion/vim-solidity'
" }}}
" }}}
" }}}
" Everything else {{{
Plug 'Chiel92/vim-autoformat'
Plug 'Konfekt/FastFold'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'bkad/CamelCaseMotion'
Plug 'henrik/vim-indexed-search'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'romainl/vim-qf'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
" }}}
" Finish Init vim-plug {{{
call plug#end()
" }}}
" Options {{{
" Colors {{{
set background=dark
let base16colorspace=256
if !exists('g:colors_name') || g:colors_name != 'base16-eighties'
  colorscheme base16-eighties
endif
" }}}
" Spaces {{{
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
" }}}
" Status Line {{{
set shortmess=atI
set noshowmode
" }}}
" Ignored {{{
set wildignore+=*.swp,.git/,*.jpg,*.jpeg,*.png,*.gif,*.psd,*.pdf,\.DS_Store,\.empty
set wildignore+=*.pyc,*.pyo,*.egg,*.egg-info
set wildignore+=*.a,*.o,*.so
set wildignore+=*.class
" }}}
" Keys {{{
let mapleader=","
cabbrev vhelp vert help

inoremap jk <Esc>
inoremap jj <Esc>

nnoremap j gj
nnoremap k gk

nnoremap <leader>3 <C-^>

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
" }}}
" Searching {{{
set smartcase
set ignorecase
set gdefault
set wildmode=list:longest
if exists('&wildignorecase') | set wildignorecase | endif
" }}}
" Format {{{
set nowrap
set linebreak
set textwidth=79
set relativenumber
set number
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
    let langs = ["python"]
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
" }}}
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
" }}}
" Backup {{{
set nobackup
set nowritebackup
set directory=~/.vim/swp//
" }}}
" Mouse {{{
behave xterm
set mouse-=a
set mousehide
" }}}
" Bells {{{
set novisualbell
" }}}
" Misc. {{{
set nostartofline
set splitbelow splitright
set hidden
set title
set clipboard=unnamedplus
" }}}
" Languages {{{
" sh,bash,zsh {{{
let g:sh_fold_enabled = 3
let g:zsh_fold_enable = 1
let g:is_bash=1
" }}}
" }}}
" }}}
" Plugin configurations {{{
" Airline {{{
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols_ascii = 1
let g:airline#extensions#branch#displayed_head_limit = 15
" }}}
" Autoformat {{{
let g:formatters_go = ['gofmt_1', 'gofmt_2']  " disable goimports
" }}}
" Camelcase motion {{{
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
" }}}
" EasyTags {{{
set cpoptions+=d
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_dynamic_files = 2
let g:easytags_async = 1
let g:easytags_resolve_links = 1
let g:easytags_suppress_report = 1
let g:easytags_suppress_ctags_warning = 1

" let g:easytags_languages = {
"             \   'javascript': {
"             \       'cmd': 'jsctags',
"             \       'args': [],
"             \       'fileoutput_opt': '-f',
"             \       'stdout_opt': '-f-',
"             \       'recurse_flag': '-R'
"             \   }
"             \}
" }}}
" fzf {{{
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <Leader>f :FzfFiles<CR>
nnoremap <silent> <Leader>b :FzfBuffers<CR>
nnoremap <silent> <Leader>a :FzfAg<CR>
" }}}
" LSP (C++) {{{
if executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/tmp/' . $USER . '/cquery/cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif
" }}}
" NERDTree {{{
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
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

noremap <silent> <Leader>n :NERDTreeToggle<CR>
" }}}
" Python {{{
let python_slow_sync = 1
let python_highlight_indent_errors = 0
let python_highlight_space_errors = 0
let python_highlight_all = 1
" }}}
" Quickfix {{{
nmap <Leader>q <Plug>(qf_qf_toggle)
nmap <Leader>l <Plug>(qf_loc_toggle)
" }}}
" Repeat {{{
silent! call repeat#set("\<Plug>.", v:count)
" }}}
" Signify {{{
let g:signify_vcs_list = [ 'git' ]
" }}}
" Sneak {{{
highlight link SneakPluginTarget Visual

map ; <Plug>SneakNext

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
" }}}
" Tagbar {{{
nnoremap <silent> <Leader>g :TagbarToggle<CR>

let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags' }
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" }}}
" Tern {{{
let g:tern#command = ['tern', '--no-port-file']
let g:tern_show_signature_in_pum = 1
let g:tern_show_argument_hints = 'on_move'
" }}}
" Virtualenv {{{
" let g:virtualenv_directory = 'venv'
" }}}
" Autocmds {{{
" Actions on opening a new buffer {{{
augroup Buf-Win-Enter
    autocmd!
    autocmd BufWinEnter * call ColorColumnPerFileType() | call RegExpEnginePerFileType() | call SynMaxColPerFileType()
augroup END
" }}}
" Set file types {{{
augroup SetFileTypes
    autocmd!
    autocmd BufWinEnter *.less setfiletype less
    autocmd BufWinEnter *.sql setfiletype mysql
    autocmd BufWinEnter *.zsh-theme setfiletype zsh
    autocmd BufWinEnter *.x setfiletype c  " XDR
    autocmd BufWinEnter Pipfile setfiletype toml
    autocmd BufWinEnter Pipfile.lock,.tern-config,.tern-project,*.abi setfiletype json
" }}}
" Filetype actions {{{
augroup FileTypeActions
    autocmd!
    autocmd FileType * set tags=./.tags;,~/.vimtags
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType html,json,xml,jinja,liquid,css,scss,less,stylus,yaml,gitcommit,nginx,toml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType html,xml,jinja,liquid runtime! macros/matchit.vim
    autocmd FileType qf setlocal wrap
    autocmd FileType scss,less,stylus setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType tex setlocal number norelativenumber
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Set comment strings {{{
augroup CommentStrings
    autocmd!
    autocmd FileType conf setlocal commentstring=#\ %s
    autocmd FileType i3 setlocal commentstring=#\ %s
    autocmd FileType jinja2 setlocal commentstring={#\ %s\ #}
    autocmd FileType nginx setlocal commentstring=#\ %s
    autocmd FileType terraform setlocal commentstring=#\ %s
    autocmd FileType toml setlocal commentstring=#\ %s
    autocmd FileType xdefaults setlocal commentstring=!\ %s
augroup END
" }}}
" }}}
" }}}
