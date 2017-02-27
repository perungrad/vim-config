set nocompatible
filetype off
set shell=/bin/bash

" vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" phpcomplete
Plugin 'https://github.com/shawncplus/phpcomplete.vim.git'

" supertab
Plugin 'https://github.com/ervandew/supertab.git'

" taggatron (automatic updates of ctag files)
Plugin 'https://github.com/joonty/vim-taggatron.git'

" tagbar - 'tags' from current file in sidebar. requires ctags
Plugin 'majutsushi/tagbar.git'

" vdebug (debugger for php, ruby, python, nodejs...)
Plugin 'https://github.com/joonty/vdebug.git'

" nerdtree
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'jistr/vim-nerdtree-tabs'

" git
Plugin 'https://github.com/tpope/vim-fugitive.git'
Plugin 'airblade/vim-gitgutter'

" ctrlP - file search
Plugin 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plugin 'tacahiroy/ctrlp-funky'

" Sauce - project specific configuration
Plugin 'joonty/vim-sauce.git'

" Snipmate
" snipmate zavislosti
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" snipmate plugin
Plugin 'garbas/vim-snipmate'
" snippety pre snipmate
Plugin 'honza/vim-snippets'

" emmet
Plugin 'mattn/emmet-vim'

" powerline
Plugin 'Lokaltog/powerline'

" support for EditorConfig
Plugin 'editorconfig/editorconfig-vim'

" PHP
" add 'use' statements
Plugin 'arnaud-lb/vim-php-namespace'

" run phpunit from vim
Plugin 'joonty/vim-phpunitqf.git'

" padawan - autocomplete
Plugin 'mkusher/padawan.vim'

" plugins for phpcomplete-extended
"Bundle 'Shougo/vimproc'
"Bundle 'Shougo/unite.vim'
"Bundle 'm2mdas/phpcomplete-extended'
"Bundle 'm2mdas/phpcomplete-extended-symfony'

" symfony
"Plugin 'docteurklein/vim-symfony'

" conque term
"Plugin 'rosenfeld/conque-term'

" collection of php plugins
"Plugin 'spf13/PIV'

" SYNTAX HIGHLIGHTERS
Plugin 'evidens/vim-twig'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-git'
Plugin 'vim-scripts/php-annotations-syntax'

" template system, maybe for PIV?
" Plugin 'tobyS/vmustache'

" tabular (align assignments and statements)
Plugin 'godlygeek/tabular'

" match tags
Plugin 'gregsexton/MatchTag'

" syntax control and linting
Plugin 'scrooloose/syntastic'

" easymotion (with s)
Plugin 'easymotion/vim-easymotion'

" search and replace multiple variants of a word
Plugin 'tpope/vim-abolish'

" rainbow parenthesis
"Plugin 'losingkeys/vim-niji'

" multiple cursors
Plugin 'terryma/vim-multiple-cursors'

" color themes
"Plugin 'mkarmona/materialbox'
"Plugin 'loogica/vim_themes'
"Plugin 'scheakur/vim-scheakur'
"Plugin 'atelierbram/vim-colors_atelier-schemes'
"Plugin 'flazz/vim-colorschemes'

Plugin 'mxw/vim-jsx'
Plugin 'honza/dockerfile.vim'

call vundle#end()

"filetype plugin indent on
filetype plugin on

" vdebug
let g:vdebug_options= {
\    'port' : 19999
\}

" supertab
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "<c-n>"

" phpcomplete-extended
"let g:phpcomplete_index_composer_command = "/home/perun/bin/composer"
"autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP

" taggatron
let g:tagcommands = {
\    "php" : {
\        "tagfile":".php.tags",
\        "args":"-R --PHP-kinds=+cf --regex-php='/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i'"
\    },
\    "javascript" : {"tagfile":".js.tags","args":"-R --exclude=node_modules"}
\}

" nerdtree
"autocmd vimenter * NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeDirArrows=1

" ctrlP
let g:ctrlp_map    = '<c-p>'
let g:ctrlp_cmd    = 'CtrlP'
let g:ctrlp_regexp = 0

" ctrlP funky
nnoremap ,fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap ,fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" tagbar
nmap <F2> :TagbarToggle<CR>

" snippets
let g:snips_author = 'Milan Herda <perun@perunhq.org>'
let g:acp_behaviorSnipmateLength = 1

" emmet
let g:user_emmet_leader_key='<C-Z>'

" powerline
set noshowmode
set rtp+=/home/perun/.vim/bundle/powerline/powerline/bindings/vim/

" snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['php'] = 'php'

" syntastic
let g:syntastic_php_checkers = ['php', 'phpmd', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=PSR2'
let g:syntastic_php_phpmd_post_args_before = 'text'
let g:syntastic_php_phpmd_post_args = 'unusedcode'
let g:syntastic_javascript_jslint_args = '--predef=define --prefef=require --predef=requirejs --predef=window --predef=module'
let g:syntastic_javascript_checkers = ['jshint']
"let g:syntastic_php_phpmd_exec = '/home/perun/bin/phpmd'
"let g:syntastic_php_phpmd_post_args = "text /home/perun/www/domelia2/phpmd-rules.xml"
"
" jsx
let g:jsx_ext_required = 0

" ################################################################
" custom functions
function! StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endfunction

function AlignAssignments ()
    let ASSIGN_OP   = '[-+*/%|&\.]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
        endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction

function AlignDocBlock ()
    let ASSIGN_OP   = '[-+*/%|&\.]\?\$\@<!\$[\$~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
        endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction

" first set path
set path+=**

" jump to a twig view in symfony
function! s:SfJumpToView()
    mark C
    normal! ]M
    let end = line(".")
    normal! [m
    try
        call search('v[^.:]+.html.twig', '', end)
        normal! gf
    catch
        normal! g`C
        echohl WarningMsg | echomsg "Template file not found" | echohl None
    endtry
endfunction
com! SfJumpToView call s:SfJumpToView()

" create a mapping only in a Controller file
autocmd BufEnter *Controller.php nmap <buffer><leader>v :SfJumpToView<CR>

" easy motion
nmap s <Plug>(easymotion-s)

" custom settings
set number
set ruler
set hlsearch
set smartindent
set nocindent
set autoindent
"set showmode "zakomentovane kvoli powerline
set completeopt=menuone,preview
set nocompatible
set laststatus=2
set autoread
set tabstop=4
set shiftwidth=4
set expandtab "standardne namiesto tabov vkladame medzeru
"set noswapfile
set tabpagemax=100

highlight TrailingWhitespaces ctermbg=red guibg=#382424
autocmd ColorScheme * highlight TrailingWhitespaces ctermbg=red guibg=#382424
autocmd BufWinEnter * match TrailingWhitespaces / \|\s\+$/

if has("gui_running")
    set t_Co=256

    set background=dark
    "set background=light
    colorscheme molokai

    "set guifont=Envy\ Code\ R\ for\ Powerline\ 11
    set guifont=Terminess\ Powerline\ 11
    set lines=70 columns=220
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
else
    set background=dark
    colorscheme molokai
endif

highlight clear SignColumn
highlight SyntasticErrorLine guibg=#870001 ctermbg=red
highlight SyntasticWarningLine guibg=#8700df ctermbg=blue

autocmd BufWritePre *.php :call StripTrailingWhitespace()
autocmd BufWritePre *.tpl :call StripTrailingWhitespace()
autocmd BufWritePre *.html :call StripTrailingWhitespace()
autocmd BufWritePre *.js :call StripTrailingWhitespace()
autocmd BufWritePre *.css :call StripTrailingWhitespace()
autocmd BufWritePre *.scss :call StripTrailingWhitespace()
autocmd BufWritePre *.latte :call StripTrailingWhitespace()
autocmd BufWritePre *.twig :call StripTrailingWhitespace()
autocmd BufWritePre *.yml :call StripTrailingWhitespace()

"php settings
let php_sql_query=1
let php_htmlInStrings=1
let php_baselib=1
let php_asp_tags=0
let php_parent_error_close=1
let php_parent_error_open=1
let php_noShortTags=0
let php_sync_method=0
let php_folding=1

" custom shortcuts
nmap <silent>  ;=  :call AlignAssignments()<CR>
nmap <silent>  ;]  :call AlignDocBlock()<CR>
" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
" double "quote" a word
nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl
" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>
" close preview window fo omni copletion
"map <F12> <esc>:pc<cr>
" return do the starting column after dot
nmap . .`[
" open tag in a new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

imap {<CR> {<CR>}<esc>O
imap (<CR> (<CR>)<esc>O
imap [<CR> [<CR>]<esc>O

nmap ,g :Gstatus<CR>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Tab> :tabnext<CR>

" file templates
autocmd BufNewFile *.php 0r ~/.vim/template/empty.php

" php namespaces
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

" vim-symfony plugin
"let g:symfony_app_console_caller= "php"
"let g:symfony_app_console_path= "app/console"
"let g:symfony_enable_shell_mapping = 0 "disable the mapping of symfony console

" conqueterm
"map <F12> :execute ":ConqueTermSplit php app/console -s --process-isolation"<CR>

" tabular
if exists(":Tabularize")
    nmap ,a= :Tabularize /=<CR>
    vmap ,a= :Tabularize /=<CR>
    nmap ,a: :Tabularize /:\zs<CR>
    vmap ,a: :Tabularize /:\zs<CR>
endif

" double backward slashes
imap ,,\ <Esc>:call setline('.', substitute(getline('.'), '\\', '\\\\', 'g'))<cr>i
nmap ,,\ :call setline('.', substitute(getline('.'), '\\', '\\\\', 'g'))<cr>


