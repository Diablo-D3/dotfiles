" Store the following config under ~/.vim/colors/root-loops.vim
" then load it into vim via ':colorscheme root-loops' or by declaring
" it as your colorscheme in your .vimrc.

" root-loops.vim -- Root Loops Vim Color Scheme.
" Webpage:          https://rootloops.sh?sugar=8&colors=7&sogginess=0&flavor=2&fruit=10&milk=0
" Description:      A vim color scheme for cereal lovers

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "root loops"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi NonText ctermfg=0 guifg=#060606
    hi Comment ctermfg=7 cterm=italic guifg=#ababab gui=italic
    hi Constant ctermfg=3 guifg=#cbab4f
    hi Error ctermfg=1 guifg=#ec9384
    hi Identifier ctermfg=9 guifg=#f2b2a6
    hi Function ctermfg=4 guifg=#96abed
    hi Special ctermfg=13 guifg=#e7aee1
    hi Delimiter ctermfg=15 guifg=#f3f3f3
    hi Statement ctermfg=5 guifg=#dd8ed6
    hi String ctermfg=2 guifg=#6cc581
    hi Operator ctermfg=6 guifg=#54c0d1
    hi Boolean ctermfg=3 guifg=#cbab4f
    hi Label ctermfg=14 guifg=#70d5e7
    hi Keyword ctermfg=5 guifg=#dd8ed6
    hi Exception ctermfg=5 guifg=#dd8ed6
    hi Conditional ctermfg=5 guifg=#dd8ed6
    hi PreProc ctermfg=13 guifg=#e7aee1
    hi Include ctermfg=5 guifg=#dd8ed6
    hi Macro ctermfg=5 guifg=#dd8ed6
    hi StorageClass ctermfg=11 guifg=#e1c166
    hi Structure ctermfg=11 guifg=#e1c166
    hi Todo ctermbg=12 ctermfg=0 cterm=bold guibg=#b2c3f2 guifg=#060606 gui=bold
    hi Type ctermfg=11 guifg=#e1c166
    hi Underlined cterm=underline gui=underline
    hi Bold cterm=bold gui=bold
    hi Italic cterm=italic gui=italic
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi StatusLine ctermbg=0 ctermfg=15 cterm=NONE guibg=#222222 guifg=#f3f3f3 gui=NONE
    hi StatusLineNC ctermbg=0 ctermfg=15 cterm=NONE guibg=#060606 guifg=#e2e2e2 gui=NONE
    hi VertSplit ctermfg=8 guifg=#525252
    hi TabLine ctermbg=0 ctermfg=7 guibg=#222222 guifg=#ababab
    hi TabLineFill ctermbg=NONE ctermfg=0 guibg=NONE guifg=#222222
    hi TabLineSel ctermbg=11 ctermfg=0 guibg=#e1c166 guifg=#222222
    hi Title ctermfg=4 cterm=bold guifg=#96abed gui=bold
    hi CursorLine ctermbg=0 ctermfg=NONE guibg=#222222 guifg=NONE
    hi Cursor ctermbg=15 ctermfg=0 guibg=#f3f3f3 guifg=#060606
    hi CursorColumn ctermbg=0 guibg=#222222
    hi LineNr ctermfg=8 guifg=#525252
    hi CursorLineNr ctermfg=6 guifg=#54c0d1
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi Visual ctermbg=8 ctermfg=15 cterm=bold guibg=#525252 guifg=#f3f3f3 gui=bold
    hi VisualNOS ctermbg=8 ctermfg=15 cterm=bold guibg=#525252 guifg=#f3f3f3 gui=bold
    hi Pmenu ctermbg=0 ctermfg=15 guibg=#222222 guifg=#f3f3f3
    hi PmenuSbar ctermbg=8 ctermfg=7 guibg=#525252 guifg=#ababab
    hi PmenuSel ctermbg=8 ctermfg=15 cterm=bold guibg=#525252 guifg=#f3f3f3 gui=bold
    hi PmenuThumb ctermbg=7 ctermfg=NONE guibg=#ababab guifg=NONE
    hi FoldColumn ctermfg=7 guifg=#ababab
    hi Folded ctermfg=12 guifg=#b2c3f2
    hi WildMenu ctermbg=0 ctermfg=15 cterm=NONE guibg=#222222 guifg=#f3f3f3 gui=NONE
    hi SpecialKey ctermfg=0 guifg=#222222
    hi IncSearch ctermbg=1 ctermfg=0 guibg=#ec9384 guifg=#060606
    hi CurSearch ctermbg=3 ctermfg=0 guibg=#cbab4f guifg=#060606
    hi Search ctermbg=11 ctermfg=0 guibg=#e1c166 guifg=#060606
    hi Directory ctermfg=4 guifg=#96abed
    hi MatchParen ctermbg=0 ctermfg=3 cterm=bold guibg=#222222 guifg=#cbab4f gui=bold
    hi SpellBad cterm=undercurl gui=undercurl guisp=#f2b2a6
    hi SpellCap cterm=undercurl gui=undercurl guisp=#e1c166
    hi SpellLocal cterm=undercurl gui=undercurl guisp=#b2c3f2
    hi SpellRare cterm=undercurl gui=undercurl guisp=#80dc95
    hi ColorColumn ctermbg=8 guibg=#525252
    hi SignColumn ctermfg=7 guifg=#ababab
    hi ModeMsg ctermbg=15 ctermfg=0 cterm=bold guibg=#e2e2e2 guifg=#222222 gui=bold
    hi MoreMsg ctermfg=4 guifg=#96abed
    hi Question ctermfg=4 guifg=#96abed
    hi QuickFixLine ctermbg=0 ctermfg=14 guibg=#222222 guifg=#70d5e7
    hi Conceal ctermfg=8 guifg=#525252
    hi ToolbarLine ctermbg=0 ctermfg=15 guibg=#222222 guifg=#e2e2e2
    hi ToolbarButton ctermbg=8 ctermfg=15 guibg=#525252 guifg=#e2e2e2
    hi debugPC ctermfg=7 guifg=#ababab
    hi debugBreakpoint ctermfg=8 guifg=#525252
    hi ErrorMsg ctermfg=1 cterm=bold,italic guifg=#ec9384 gui=bold,italic
    hi WarningMsg ctermfg=11 guifg=#e1c166
    hi DiffAdd ctermbg=10 ctermfg=0 guibg=#80dc95 guifg=#060606
    hi DiffChange ctermbg=12 ctermfg=0 guibg=#b2c3f2 guifg=#060606
    hi DiffDelete ctermbg=9 ctermfg=0 guibg=#f2b2a6 guifg=#060606
    hi DiffText ctermbg=14 ctermfg=0 guibg=#70d5e7 guifg=#060606
    hi diffAdded ctermfg=10 guifg=#80dc95
    hi diffRemoved ctermfg=9 guifg=#f2b2a6
    hi diffChanged ctermfg=12 guifg=#b2c3f2
    hi diffOldFile ctermfg=11 guifg=#e1c166
    hi diffNewFile ctermfg=13 guifg=#e7aee1
    hi diffFile ctermfg=12 guifg=#b2c3f2
    hi diffLine ctermfg=7 guifg=#ababab
    hi diffIndexLine ctermfg=14 guifg=#70d5e7

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16
    hi Normal ctermbg=NONE ctermfg=NONE
    hi NonText ctermfg=0
    hi Comment ctermfg=7 cterm=italic
    hi Constant ctermfg=3
    hi Error ctermfg=1
    hi Identifier ctermfg=9
    hi Function ctermfg=4
    hi Special ctermfg=13
    hi Delimiter ctermfg=15
    hi Statement ctermfg=5
    hi String ctermfg=2
    hi Operator ctermfg=6
    hi Boolean ctermfg=3
    hi Label ctermfg=14
    hi Keyword ctermfg=5
    hi Exception ctermfg=5
    hi Conditional ctermfg=5
    hi PreProc ctermfg=13
    hi Include ctermfg=5
    hi Macro ctermfg=5
    hi StorageClass ctermfg=11
    hi Structure ctermfg=11
    hi Todo ctermbg=12 ctermfg=0 cterm=bold
    hi Type ctermfg=11
    hi Underlined cterm=underline
    hi Bold cterm=bold
    hi Italic cterm=italic
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE
    hi StatusLine ctermbg=0 ctermfg=15 cterm=NONE
    hi StatusLineNC ctermbg=0 ctermfg=15 cterm=NONE
    hi VertSplit ctermfg=8
    hi TabLine ctermbg=0 ctermfg=7
    hi TabLineFill ctermbg=NONE ctermfg=0
    hi TabLineSel ctermbg=11 ctermfg=0
    hi Title ctermfg=4 cterm=bold
    hi CursorLine ctermbg=0 ctermfg=NONE
    hi Cursor ctermbg=15 ctermfg=0
    hi CursorColumn ctermbg=0
    hi LineNr ctermfg=8
    hi CursorLineNr ctermfg=6
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE
    hi Visual ctermbg=8 ctermfg=15 cterm=bold
    hi VisualNOS ctermbg=8 ctermfg=15 cterm=bold
    hi Pmenu ctermbg=0 ctermfg=15
    hi PmenuSbar ctermbg=8 ctermfg=7
    hi PmenuSel ctermbg=8 ctermfg=15 cterm=bold
    hi PmenuThumb ctermbg=7 ctermfg=NONE
    hi FoldColumn ctermfg=7
    hi Folded ctermfg=12
    hi WildMenu ctermbg=0 ctermfg=15 cterm=NONE
    hi SpecialKey ctermfg=0
    hi IncSearch ctermbg=1 ctermfg=0
    hi CurSearch ctermbg=3 ctermfg=0
    hi Search ctermbg=11 ctermfg=0
    hi Directory ctermfg=4
    hi MatchParen ctermbg=0 ctermfg=3 cterm=bold
    hi SpellBad cterm=undercurl
    hi SpellCap cterm=undercurl
    hi SpellLocal cterm=undercurl
    hi SpellRare cterm=undercurl
    hi ColorColumn ctermbg=8
    hi SignColumn ctermfg=7
    hi ModeMsg ctermbg=15 ctermfg=0 cterm=bold
    hi MoreMsg ctermfg=4
    hi Question ctermfg=4
    hi QuickFixLine ctermbg=0 ctermfg=14
    hi Conceal ctermfg=8
    hi ToolbarLine ctermbg=0 ctermfg=15
    hi ToolbarButton ctermbg=8 ctermfg=15
    hi debugPC ctermfg=7
    hi debugBreakpoint ctermfg=8
    hi ErrorMsg ctermfg=1 cterm=bold,italic
    hi WarningMsg ctermfg=11
    hi DiffAdd ctermbg=10 ctermfg=0
    hi DiffChange ctermbg=12 ctermfg=0
    hi DiffDelete ctermbg=9 ctermfg=0
    hi DiffText ctermbg=14 ctermfg=0
    hi diffAdded ctermfg=10
    hi diffRemoved ctermfg=9
    hi diffChanged ctermfg=12
    hi diffOldFile ctermfg=11
    hi diffNewFile ctermfg=13
    hi diffFile ctermfg=12
    hi diffLine ctermfg=7
    hi diffIndexLine ctermfg=14
endif

hi link EndOfBuffer NonText
hi link SpecialComment Special
hi link Define PreProc
hi link PreCondit PreProc
hi link Number Constant
hi link Float Number
hi link Typedef Type
hi link SpecialChar Special
hi link Debug Special
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link WinSeparator VertSplit
hi link WinBar StatusLine
hi link WinBarNC StatusLineNC
hi link lCursor Cursor
hi link CursorIM Cursor
hi link Terminal Normal

if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = [ '#222222', '#ec9384', '#6cc581', '#cbab4f', '#96abed', '#dd8ed6', '#54c0d1', '#ababab', '#525252', '#f2b2a6', '#80dc95', '#e1c166', '#b2c3f2', '#e7aee1', '#70d5e7', '#e2e2e2' ]
endif
