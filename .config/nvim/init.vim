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
call plug#begin(stdpath('data') . '/plugged')
" }}}
" Sane defaults {{{
Plug 'tpope/vim-sensible'
" }}}
" Colors {{{
Plug 'chriskempson/base16-vim'
" }}}
" Languages {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
" Clojure {{{
Plug 'Olical/conjure', { 'for': 'clojure', 'tag': 'develop' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-slamhound', { 'for': 'clojure' }
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
" YAML {{{
Plug 'pedrohdz/vim-yaml-folds', { 'for': 'yaml' }
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
" Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
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
let base16colorspace=256
if !exists('g:colors_name') || g:colors_name != 'base16-eighties'
  colorscheme base16-eighties
endif
" }}}
" Spaces {{{
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
" }}}
" Status Line {{{
set signcolumn=auto:2
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
let maplocalleader=","
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
set nohlsearch
set gdefault
set wildmode=list:longest
set wildignorecase
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

nnoremap <silent> <Leader>r :redraw!<CR>

" TODO consider removing
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
" Clojure-Static {{{
let g:clojure_fold = 1
" }}}
" CoC {{{
let g:coc_global_extensions = [
            \ 'coc-diagnostic',
            \ 'coc-json',
            \ ]

highlight! link CocErrorHighlight NONE
highlight! link CocWarningHighlight NONE
highlight! link CocInfoHighlight NONE
highlight! link CocHintHighlight NONE

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" nnoremap <silent> K :call <SID>show_doc()<CR>
nnoremap <silent><leader>dh :call <SID>show_documentation()<CR>
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" nnoremap <silent><leader>gd :call CocAction('jumpDefinition')<CR>
" nnoremap <silent><leader>gl :call CocAction('jumpDeclaration')<CR>
" nnoremap <silent><leader>gi :call CocAction('jumpImplementation')<CR>
" nnoremap <silent><leader>gr <Plug>(coc-references)
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

nnoremap <silent><nowait> <leader>ga  :<C-u>CocFzfList diagnostics<cr>
nmap <silent><leader>ge <Plug>(coc-diagnostic-info)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" nmap <leader>qf <Plug>(coc-fix-current)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Other helpful stuff
" nnoremap <silent><leader>gc :call CocAction('codeAction')<CR>
" nnoremap <silent><leader>gR :call CocAction('rename')<CR>
" nnoremap <silent><leader>gq :call CocAction('quickfixes')<CR>
" nnoremap <silent><leader>,. :call CocActionAsync('format')<CR>
" nnoremap <silent><leader>gL :CocFzfList<CR>

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Clojure stuff {{{
nnoremap <silent> <leader>rrc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rrn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rrp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rrf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>

nnoremap <silent> <leader>rth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rtw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>rta :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>

nnoremap <silent> <leader>rlm :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> <leader>rli :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> <leader>rle :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>

nnoremap <silent> <leader>rom :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> <leader>ros :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
" }}}
" }}}
" Conjure {{{
let g:conjure#mapping#def_word = v:false
" }}}
" EasyTags {{{
set cpoptions+=d
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_dynamic_files = 2
let g:easytags_async = 1
let g:easytags_resolve_links = 1
let g:easytags_suppress_report = 1
let g:easytags_suppress_ctags_warning = 1
" }}}
" fzf {{{
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <Leader>f :FzfFiles<CR>
nnoremap <silent> <Leader>b :FzfBuffers<CR>
nnoremap <silent> <Leader>a :FzfAg<CR>
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
" highlight link SneakPluginTarget Visual

" map ; <Plug>SneakNext

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
" }}}
" Tagbar {{{
nnoremap <silent> <Leader>t :TagbarToggle<CR>

let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

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
    autocmd BufWinEnter *.sql setfiletype mysql
    autocmd BufWinEnter *.zsh-theme setfiletype zsh
    autocmd BufWinEnter Pipfile.lock setfiletype json
" }}}
" Filetype actions {{{
" TODO consider editing
augroup FileTypeActions
    autocmd!
    autocmd FileType * set tags=./.tags;,~/.vimtags
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType qf setlocal wrap
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Set comment strings {{{
augroup CommentStrings
    autocmd!
    autocmd FileType conf setlocal commentstring=#\ %s
    autocmd FileType i3 setlocal commentstring=#\ %s
    autocmd FileType xdefaults setlocal commentstring=!\ %s
augroup END
" }}}
" }}}
" }}}
