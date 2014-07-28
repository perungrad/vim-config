" vundle
set nocompatible
filetype off
set shell=/bin/bash

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'joonty/vim-phpqa.git'
Bundle 'https://github.com/shawncplus/phpcomplete.vim.git'
Bundle 'https://github.com/ervandew/supertab.git'
Bundle 'https://github.com/joonty/vim-taggatron.git'
Bundle 'https://github.com/joonty/vdebug.git'
Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/tpope/vim-fugitive.git'
Bundle 'https://github.com/kien/ctrlp.vim.git'
Bundle 'joonty/vim-sauce.git'
Bundle 'majutsushi/tagbar.git'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "mattn/emmet-vim"
Bundle "Lokaltog/powerline"
"Bundle "vim-scripts/phpfolding.vim"
Bundle "evidens/vim-twig"
Bundle "editorconfig/editorconfig-vim"
Bundle "arnaud-lb/vim-php-namespace"
Bundle "docteurklein/vim-symfony"
Bundle "rosenfeld/conque-term"
Bundle "tobyS/vmustache"
"Bundle "spf13/PIV"
Bundle "godlygeek/tabular"
Bundle "gregsexton/MatchTag"
Bundle 'joonty/vim-phpunitqf.git'

"filetype plugin indent on
filetype plugin on

" PHPQA
let g:phpqa_php_cmd='/usr/bin/php'
let g:phpqa_codesniffer_args = "--standard=Symfony2"
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_messdetector_autorun = 0
let g:phpqa_codecoverage_autorun = 0

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" taggatron
let g:tagcommands = {
\    "php" : {
\        "tagfile":".php.tags",
\        "args":"-R --PHP-kinds=+cf --regex-php='/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i'"
\    },
\    "javascript" : {"tagfile":".js.tags","args":"-R"}
\}

" nerdtree
"autocmd vimenter * NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeDirArrows=1

" ctrlP
let g:ctrlp_map    = '<c-p>'
let g:ctrlp_cmd    = 'CtrlP'
let g:ctrlp_regexp = 0

" tagbar

nmap <F2> :TagbarToggle<CR>

" snippets
let g:snips_author = 'Milan Herda'
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

highlight TrailingWhitespaces ctermbg=red guibg=#382424
autocmd ColorScheme * highlight TrailingWhitespaces ctermbg=red guibg=#382424
autocmd BufWinEnter * match TrailingWhitespaces / \|\s\+$/

if has("gui_running")
    set t_Co=256
    set background=dark
    colorscheme vividchalk
    "set guifont=Envy\ Code\ R\ for\ Powerline\ 11
    set guifont=Terminess\ Powerline\ 11
    set lines=70 columns=220
    set guioptions-=T
else
    set background=dark
    colorscheme gruvbox
endif

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

" symfony console
let g:symfony_enable_shell_mapping = 0 "disable the mapping of symfony console

map <F12> :execute ":ConqueTermSplit php app/console -s --process-isolation"<CR>

" tabularize
if exists(":Tabularize")
    nmap ,a= :Tabularize /=<CR>
    vmap ,a= :Tabularize /=<CR>
    nmap ,a: :Tabularize /:\zs<CR>
    vmap ,a: :Tabularize /:\zs<CR>
endif