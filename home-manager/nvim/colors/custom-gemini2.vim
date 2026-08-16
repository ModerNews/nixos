set background=dark
hi clear
let g:colors_name = 'slate_blood_ice_full'

" --- 1. Terminal Colors (Synced to Matugen & Wallpaper) ---
if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#ad2a30', '#50ffb0', '#ffcc33', '#1a2a53', '#d89fff', '#a1e7eb', '#fefefe', '#4c6a84', '#ff5555', '#a1e7eb', '#ffff00', '#40d0ff', '#ff00ff', '#00ffff', '#ffffff']
  for i in range(g:terminal_ansi_colors->len())
    let g:terminal_color_{i} = g:terminal_ansi_colors[i]
  endfor
endif

" --- 2. Links & Plumbing ---
hi! link Terminal Normal
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo

" --- 3. Base UI (The Midnight & Blood) ---
hi Normal          guifg=#fefefe guibg=NONE    gui=NONE
hi EndOfBuffer     guifg=#1a2a53 guibg=NONE    gui=NONE
hi VertSplit       guifg=#1a2a53 guibg=#1a2a53 gui=bold
hi CursorLine      guifg=#fefefe guibg=#ad2a30 gui=bold
hi Visual          guifg=#fefefe guibg=#ad2a30 gui=NONE
hi Search          guifg=#fefefe guibg=#ad2a30 gui=NONE
hi IncSearch       guifg=#fefefe guibg=#d83e4a gui=NONE
hi LineNr          guifg=#666666 guibg=NONE    gui=NONE
hi MatchParen      guifg=#fefefe guibg=#1a2a53 gui=NONE

" --- 4. Menus & Tabs (Adverse Contrast) ---
hi Pmenu           guifg=NONE    guibg=#333333 gui=NONE
hi PmenuSel        guifg=#fefefe guibg=#ad2a30 gui=NONE
hi PmenuSbar       guifg=NONE    guibg=#1a2a53 gui=NONE
hi PmenuThumb      guifg=NONE    guibg=#ad2a30 gui=NONE
hi TabLineSel      guifg=#fefefe guibg=#ad2a30 gui=NONE
hi TabLine         guifg=#666666 guibg=#333333 gui=NONE
hi TabLineFill     guifg=#ff8787 guibg=#333333 gui=NONE

" --- 5. Code Highlighting (Balanced Frost/Flame) ---
hi Comment         guifg=#4c6a84 guibg=NONE    gui=NONE
hi String          guifg=#86a87e guibg=NONE    gui=NONE
hi Identifier      guifg=#d83e4a guibg=NONE    gui=NONE
hi Function        guifg=#ec8509 guibg=NONE    gui=NONE
hi Special         guifg=#a1e7eb guibg=NONE    gui=bold
hi Statement       guifg=#f36630 guibg=NONE    gui=bold
hi Constant        guifg=#a1e7eb guibg=NONE    gui=NONE
hi PreProc         guifg=#ec8509 guibg=NONE    gui=NONE
hi Type            guifg=#f36630 guibg=NONE    gui=bold
hi Operator        guifg=#f36630 guibg=NONE    gui=NONE
hi Title           guifg=#f36630 guibg=NONE    gui=bold
hi Todo            guifg=#14423f guibg=NONE    gui=bold

" --- 6. Markdown Headers (Descending Heat) ---
hi RenderMarkdownH1      guifg=#ff7744 guibg=#451a1a gui=BOLD
hi RenderMarkdownH2      guifg=#ffcc33 guibg=#453505 gui=BOLD
hi RenderMarkdownH3      guifg=#50ffb0 guibg=#153525 gui=BOLD
hi RenderMarkdownH4      guifg=#40d0ff guibg=#102a35 gui=BOLD
hi RenderMarkdownH5      guifg=#d89fff guibg=#251a30 gui=BOLD
hi RenderMarkdownH6      guifg=#808080 guibg=#1a1a1a gui=BOLD
hi! link @markup.heading.1.markdown RenderMarkdownH1
hi! link @markup.heading.2.markdown RenderMarkdownH2
hi! link @markup.heading.3.markdown RenderMarkdownH3
hi! link @markup.heading.4.markdown RenderMarkdownH4
hi! link @markup.heading.5.markdown RenderMarkdownH5
hi! link @markup.heading.6.markdown RenderMarkdownH6

" --- 7. Tables & Lists (The Cyan Frost) ---
highlight! @markup.heading.markdown guifg=#a1e7eb gui=BOLD
hi RenderMarkdownTableHead guifg=#5fbdbf
hi RenderMarkdownTableFill guifg=#5fbdbf
hi RenderMarkdownTableRow  guifg=#2d5557
hi RenderMarkdownBullet    guifg=#a1e7eb gui=BOLD
hi! link RenderMarkdownBullet RenderMarkdownUnchecked

" --- 8. Utilities (Diffs, Diagnostics, Spelling) ---
hi DiffAdd         guifg=#ffffff guibg=#153525 gui=NONE
hi DiffChange      guifg=#ffffff guibg=#102a35 gui=NONE
hi DiffDelete      guifg=#ffffff guibg=#451a1a gui=NONE
hi DiagnosticInfo  guifg=#a1e7eb guibg=NONE    gui=NONE
hi DiagnosticHint  guifg=#10b981 guibg=NONE    gui=NONE
hi DiagnosticWarn  guifg=#f59e07 guibg=NONE    gui=NONE
hi DiagnosticError guifg=#ff0000 guibg=NONE    gui=NONE
hi SpellBad        guifg=#ff0000 guibg=NONE    guisp=#ff0000 gui=undercurl

" --- 9. Plugin Specifics ---
hi NeoTreeFloatBorder guifg=#a1e7eb guibg=NONE gui=NONE
hi NeoTreeFloatTitle  guifg=#a1e7eb guibg=NONE gui=NONE
hi RenderMarkdownCode guibg=#1a1a2a gui=NONE blend=20
