
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="desert"

hi Normal	ctermfg=white

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
hi SpecialKey	ctermfg=green cterm=bold
hi NonText	cterm=bold ctermfg=blue 
hi Directory	ctermfg=cyan cterm=bold
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1 cterm=bold
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=green cterm=bold
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=grey
hi Question	ctermfg=green cterm=bold
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse,bold
hi VertSplit	cterm=reverse,bold
hi Title	ctermfg=5
hi Visual	cterm=reverse cterm=bold
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1 cterm=bold
hi WildMenu	ctermfg=0 ctermbg=3 cterm=bold
hi Folded	ctermfg=grey ctermbg=NONE
hi FoldColumn	ctermfg=grey ctermbg=NONE
hi DiffAdd	ctermbg=4 cterm=bold
hi DiffChange	ctermbg=5 cterm=bold
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=cyan cterm=bold
"hi Constant	ctermfg=white 
hi Constant	ctermfg=brown  cterm=bold
hi Special	ctermfg=5 cterm=bold
hi Identifier	ctermfg=red cterm=bold
hi Statement	ctermfg=yellow cterm=bold
hi PreProc	ctermfg=5 cterm=bold
hi Type		ctermfg=2 cterm=bold
hi Underlined	cterm=underline ctermfg=5 cterm=bold
hi Ignore	cterm=bold ctermfg=7 cterm=bold
hi Ignore	ctermfg=grey cterm=bold
hi Error	cterm=bold ctermfg=7 ctermbg=red cterm=bold

hi MatchParen ctermbg=blue

"vim: sw=4
