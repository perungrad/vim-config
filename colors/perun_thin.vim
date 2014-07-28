
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="desert"

hi Normal	ctermfg=grey

" highlight groups
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
"hi VisualNOS
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" color terminal definitions
hi SpecialKey	ctermfg=green
hi NonText	ctermfg=blue 
hi Directory	ctermfg=cyan
hi ErrorMsg	ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=green
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=grey
hi Question	ctermfg=green
hi StatusLine	cterm=reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=5
hi Visual	cterm=reverse
hi VisualNOS	cterm=underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=grey ctermbg=NONE
hi FoldColumn	ctermfg=grey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	ctermfg=4 ctermbg=6
hi DiffText	ctermbg=1
hi Comment	ctermfg=cyan
"hi Constant	ctermfg=grey 
hi Constant	ctermfg=brown 
hi Special	ctermfg=5
hi Identifier	ctermfg=red
hi Statement	ctermfg=yellow
hi PreProc	ctermfg=5
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	ctermfg=7
hi Ignore	ctermfg=grey
hi Error	ctermfg=7 ctermbg=red

hi MatchParen ctermbg=blue

"vim: sw=4
