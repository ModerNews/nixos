" wal.vim -- Vim color scheme.
" Author:      gruzin (grzegorz.jagielski.2019@zsa.pwr.edu.pl)
" Webpage:     
" Description: wal generated colorscheme
" Last Change: 2023-04-13

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wal"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#e79ab0 gui=NONE
    hi NonText ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#2ca0cb gui=NONE
    hi Comment ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Constant ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=#e7e09a gui=NONE
    hi Error ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Identifier ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=#e7e09a gui=NONE
    hi Ignore ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi PreProc ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#2ca0cb gui=NONE
    hi Special ctermbg=NONE ctermfg=1 cterm=bold guibg=NONE guifg=#a162a1 gui=bold
    hi Statement ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#2ca0cb gui=NONE
    hi String ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#a162a1 gui=NONE
    hi Todo ctermbg=NONE ctermfg=10 cterm=bold,italic guibg=NONE guifg=#9ae7d1 gui=bold,italic
    hi Type ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=#e7e09a gui=NONE
    hi Underlined ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi StatusLine ctermbg=15 ctermfg=2 cterm=bold guibg=#edc8de guifg=#e165a7 gui=bold
    hi StatusLineNC ctermbg=2 ctermfg=15 cterm=bold guibg=#e165a7 guifg=#edc8de gui=bold
    hi VertSplit ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi TabLine ctermbg=NONE ctermfg=8 cterm=bold guibg=NONE guifg=#a58c9b gui=bold
    hi TabLineFill ctermbg=NONE ctermfg=8 cterm=bold guibg=NONE guifg=#a58c9b gui=bold
    hi TabLineSel ctermbg=NONE ctermfg=8 cterm=bold guibg=NONE guifg=#a58c9b gui=bold
    hi Title ctermbg=NONE ctermfg=2 cterm=bold guibg=NONE guifg=#e165a7 gui=bold
    hi CursorLine ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi LineNr ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi CursorLineNr ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi helpNormal ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Visual ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi VisualNOS ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Pmenu ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi PmenuSbar ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi PmenuSel ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi PmenuThumb ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi FoldColumn ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Folded ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi WildMenu ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=0 cterm=NONE guibg=NONE guifg=#1f1b2d gui=NONE
    hi DiffAdd ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi DiffChange ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi DiffDelete ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi DiffText ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi IncSearch ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Search ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Directory ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=#9ae7d1 gui=NONE
    hi MatchParen ctermbg=15 ctermfg=0 cterm=NONE guibg=#edc8de guifg=#1f1b2d gui=NONE
    hi SpellBad ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE guisp=#a162a1
    hi SpellCap ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE guisp=#5da3ce
    hi SpellLocal ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE guisp=#e79ab0
    hi SpellRare ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE guisp=#c2b3b4
    hi ColorColumn ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi SignColumn ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi ErrorMsg ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi ModeMsg ctermbg=NONE ctermfg=8 cterm=bold guibg=NONE guifg=#a58c9b gui=bold
    hi MoreMsg ctermbg=NONE ctermfg=8 cterm=bold guibg=NONE guifg=#a58c9b gui=bold
    hi Question ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Cursor ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi CursorColumn ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi QuickFixLine ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi Conceal ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi ToolbarLine ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi ToolbarButton ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi debugPC ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE
    hi debugBreakpoint ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#a58c9b gui=NONE

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16

    hi Normal ctermbg=NONE ctermfg=darkmagenta cterm=NONE
    hi NonText ctermbg=NONE ctermfg=darkyellow cterm=NONE
    hi Comment ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Constant ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Error ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Identifier ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Ignore ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi PreProc ctermbg=NONE ctermfg=darkyellow cterm=NONE
    hi Special ctermbg=NONE ctermfg=darkred cterm=bold
    hi Statement ctermbg=NONE ctermfg=darkyellow cterm=NONE
    hi String ctermbg=NONE ctermfg=darkred cterm=NONE
    hi Todo ctermbg=NONE ctermfg=green cterm=bold,italic
    hi Type ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Underlined ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi StatusLine ctermbg=white ctermfg=darkgreen cterm=bold
    hi StatusLineNC ctermbg=darkgreen ctermfg=white cterm=bold
    hi VertSplit ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi TabLine ctermbg=NONE ctermfg=darkgray cterm=bold
    hi TabLineFill ctermbg=NONE ctermfg=darkgray cterm=bold
    hi TabLineSel ctermbg=NONE ctermfg=darkgray cterm=bold
    hi Title ctermbg=NONE ctermfg=darkgreen cterm=bold
    hi CursorLine ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi LineNr ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi CursorLineNr ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi helpNormal ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Visual ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi VisualNOS ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Pmenu ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi PmenuSbar ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi PmenuSel ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi PmenuThumb ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi FoldColumn ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Folded ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi WildMenu ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi SpecialKey ctermbg=NONE ctermfg=black cterm=NONE
    hi DiffAdd ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi DiffChange ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi DiffDelete ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi DiffText ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi IncSearch ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Search ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Directory ctermbg=NONE ctermfg=green cterm=NONE
    hi MatchParen ctermbg=white ctermfg=black cterm=NONE
    hi SpellBad ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi SpellCap ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi SpellLocal ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi SpellRare ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi ColorColumn ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi SignColumn ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi ErrorMsg ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi ModeMsg ctermbg=NONE ctermfg=darkgray cterm=bold
    hi MoreMsg ctermbg=NONE ctermfg=darkgray cterm=bold
    hi Question ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Cursor ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi CursorColumn ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi QuickFixLine ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi Conceal ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi ToolbarLine ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi ToolbarButton ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi debugPC ctermbg=NONE ctermfg=darkgray cterm=NONE
    hi debugBreakpoint ctermbg=NONE ctermfg=darkgray cterm=NONE
endif

hi link EndOfBuffer NonText
hi link Number Constant
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link WarningMsg Error
hi link CursorIM Cursor
hi link Terminal Normal

if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = [ '#1f1b2d', '#a162a1', '#e165a7', '#2ca0cb', '#5da3ce', '#e79ab0', '#c2b3b4', '#edc8de', '#a58c9b', '#a162a1', '#9ae7d1', '#e7e09a', '#5da3ce', '#e79ab0', '#c2b3b4', '#edc8de' ]
endif

" Generated with RNB (https://github.com/romainl/vim-rnb)
