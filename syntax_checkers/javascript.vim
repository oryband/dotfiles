"============================================================================
"File:        javascript.vim
"Description: Syntax checking plugin for syntastic.vim using jshint
"Maintainer:  Matthew Kitt <mk dot kitt at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" This is for use with jslint and node, F/ is deprecating in favor of closure
"============================================================================
if exists('loaded_javascript_syntax_checker')
    finish
endif
let loaded_javascript_syntax_checker = 1

if !executable('jshint')
    finish
endif

" Check for a .jshintrc in the cwd at startup, let that override any other configurations.
if filereadable(getcwd() . '/.jshintrc')
    let s:config = getcwd() . '/.jshintrc'
endif

function! SyntaxCheckers_javascript_GetLocList()
    if exists('s:config')
        let makeprg = 'jshint ' . shellescape(expand("%")) . ' --config ' . s:config
    else
        let makeprg = 'jshint ' . shellescape(expand("%"))
    endif
    let errorformat = '%f: line %l\, col %c\, %m,%-G%.%#'
    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction
