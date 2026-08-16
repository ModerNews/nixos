set background=dark
hi clear
let g:colors_name = 'dark_blood'

" 16-color palette for terminal integration (TUI)
let g:terminal_ansi_colors = [
  \ '#130908', '#B91E24', '#4B634B', '#B8935A',
  \ '#004B73', '#7F2926', '#4a8a8d', '#F9DCD9',
  \ '#42302F', '#FFB3AD', '#86a87e', '#ffcc33',
  \ '#91CCFF', '#FD8A82', '#a1e7eb', '#FFFFFF']

" --- Core UI (Transparent/Opacity-First) ---
hi Normal          guifg=#F9DCD9 guibg=NONE    gui=NONE
hi Terminal        guifg=#F9DCD9 guibg=NONE    gui=NONE
hi EndOfBuffer     guifg=#42302F guibg=NONE    gui=NONE
hi LineNr          guifg=#5B403E guibg=NONE    gui=NONE
hi CursorLineNr    guifg=#FFB3AD guibg=#2B1C1A gui=bold
hi VertSplit       guifg=#2B1C1A guibg=NONE    gui=bold
hi ColorColumn     guibg=#180B09 gui=NONE
hi Folded          guifg=#5B403E guibg=#180B09 gui=NONE
hi SignColumn      guifg=NONE    guibg=NONE

" --- Selection & Interaction ---
hi Visual          guifg=#FFFFFF guibg=#680009 gui=NONE
hi Search          guifg=#FFFFFF guibg=#B91E24 gui=NONE
hi IncSearch       guifg=#FFFFFF guibg=#FFB3AD gui=NONE
hi CursorLine      guibg=#2B1C1A gui=NONE
hi MatchParen      guifg=#FFFFFF guibg=#004B73 gui=bold
hi Question        guifg=#FD8A82 guibg=NONE    gui=NONE

" --- Popups & Floating Windows ---
hi Pmenu           guifg=#F9DCD9 guibg=#271816 gui=NONE
hi PmenuSel        guifg=#FFFFFF guibg=#B91E24 gui=NONE
hi PmenuSbar       guibg=#180B09
hi PmenuThumb      guibg=#B91E24
hi NormalFloat     guifg=#F9DCD9 guibg=NONE
hi NeoTreeFloatBorder guifg=#B91E24 guibg=NONE
hi NeoTreeFloatTitle  guifg=#FFB3AD guibg=NONE
hi NeoTreeVertSplit   guifg=#2B1C1A guibg=NONE blend=0

" --- Syntax (The Blood Hierarchy) ---
hi Comment         guifg=#5B403E gui=italic
hi Constant        guifg=#FD8A82 gui=NONE
hi String          guifg=#86a87e gui=NONE
hi Identifier      guifg=#FFB3AD gui=NONE
hi Function        guifg=#B91E24 gui=bold
hi Statement       guifg=#B91E24 gui=bold
hi PreProc         guifg=#FD8A82 gui=NONE
hi Type            guifg=#B91E24 gui=bold
hi Special         guifg=#a1e7eb gui=bold
hi Operator        guifg=#B91E24 gui=NONE
hi Todo            guifg=#86a87e guibg=NONE    gui=bold

" --- Diagnostics ---
hi DiagnosticError guifg=#B91E24 guibg=NONE
hi DiagnosticWarn  guifg=#B8935A guibg=NONE
hi DiagnosticInfo  guifg=#004B73 guibg=NONE
hi DiagnosticHint  guifg=#4B634B guibg=NONE

" --- RenderMarkdown: Complete Hierarchy ---
" Level 1 - Primary Blood Red
hi RenderMarkdownH1     guifg=#B91E24 gui=bold
hi RenderMarkdownH1Bg   guibg=#42302F
" Level 2 - Lustre Pink/Red
hi RenderMarkdownH2     guifg=#FFB3AD gui=bold
hi RenderMarkdownH2Bg   guibg=#2B1C1A
" Level 3 - Muted Bone (The on_surface_variant)
hi RenderMarkdownH3     guifg=#E3BEBA gui=bold
hi RenderMarkdownH3Bg   guibg=#372624
" Level 4 - Shadow Blue (Tertiary)
hi RenderMarkdownH4     guifg=#91CCFF gui=bold
hi RenderMarkdownH4Bg   guibg=#003351
" Level 5 - Forest Green (Hint)
hi RenderMarkdownH5     guifg=#86a87e gui=bold
hi RenderMarkdownH5Bg   guibg=#1E2A1E
" Level 6 - Dark Slate
hi RenderMarkdownH6     guifg=#5B403E gui=bold
hi RenderMarkdownH6Bg   guibg=#180B09

" RenderMarkdown Utilities
hi RenderMarkdownTableHead guifg=#B91E24
hi RenderMarkdownTableFill guifg=#B91E24
hi RenderMarkdownTableRow  guifg=#5B403E
hi RenderMarkdownCode      guibg=#180B09 gui=NONE blend=20
hi RenderMarkdownCodeInline guibg=#180B09 gui=NONE blend=20

" Links
hi! link @markup.heading.1.markdown RenderMarkdownH1
hi! link @markup.heading.2.markdown RenderMarkdownH2
hi! link @markup.heading.3.markdown RenderMarkdownH3
hi! link @markup.heading.4.markdown RenderMarkdownH4
hi! link @markup.heading.5.markdown RenderMarkdownH5
hi! link @markup.heading.6.markdown RenderMarkdownH6
