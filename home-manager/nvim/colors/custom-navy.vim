" custom colorscheme

set background=dark
hi clear
let g:colors_name = 'custom-navy'

let s:t_Co = &t_Co

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#cd0000', '#00cd00', '#cdcd00', '#0000ee', '#cd00cd', '#00cdcd', '#e5e5e5', '#7f7f7f', '#ff0000', '#00ff00', '#ffff00', '#5c5cff', '#ff00ff', '#00ffff', '#ffffff']
  for i in range(g:terminal_ansi_colors->len())
    let g:terminal_color_{i} = g:terminal_ansi_colors[i]
  endfor
endif

" Shared colors (TODOs, Headers, Callouts)
hi ColorRed guifg=#ff7744 guibg=NONE gui=NONE cterm=NONE
hi ColorRedBold guifg=#ff7744 guibg=NONE gui=bold cterm=bold
hi ColorRedBg guifg=#ff7744 guibg=#552a20 gui=bold cterm=bold
hi ColorYellow guifg=#ffcc33 guibg=NONE gui=NONE cterm=NONE
hi ColorYellowBold guifg=#ffcc33 guibg=NONE gui=bold cterm=bold
hi ColorYellowBg guifg=#ffcc33 guibg=#2a2510 gui=bold cterm=bold
hi ColorOrange guifg=#f36630 guibg=NONE gui=NONE cterm=NONE
hi ColorOrangeBold guifg=#f36630 guibg=NONE gui=bold cterm=bold
hi ColorOrangeBg guifg=#f36630 guibg=#2a1a15 gui=bold cterm=bold
hi ColorGreen guifg=#50ffb0 guibg=NONE gui=NONE cterm=NONE
hi ColorGreenBold guifg=#50ffb0 guibg=NONE gui=bold cterm=bold
hi ColorGreenBg guifg=#86a87e guibg=#1a2a1f gui=bold cterm=bold
hi ColorCyan guifg=#40d0ff guibg=NONE gui=NONE cterm=NONE
hi ColorCyanBold guifg=#40d0ff guibg=NONE gui=bold cterm=bold
hi ColorCyanBg guifg=#a1e7eb guibg=#1a2a30 gui=bold cterm=bold
hi ColorPurple guifg=#d89fff guibg=NONE gui=NONE cterm=NONE
hi ColorPurpleBold guifg=#d89fff guibg=NONE gui=bold cterm=bold
hi ColorPurpleBg guifg=#d89fff guibg=#251a30 gui=bold cterm=bold
hi ColorGray guifg=#b0b0b0 guibg=NONE gui=NONE cterm=NONE
hi ColorGrayBold guifg=#b0b0b0 guibg=NONE gui=bold cterm=bold
hi ColorGrayBg guifg=#b0b0b0 guibg=#222222 gui=bold cterm=bold

" TODO comments
hi! link TodoFgFIX ColorRedBg
hi! link TodoBgFIX ColorRedBg
hi! link TodoSignFIX ColorRed
hi! link TodoFgHACK ColorYellowBg
hi! link TodoBgHACK ColorYellowBg
hi! link TodoSignHACK ColorYellow
hi! link TodoFgWARN ColorOrangeBg
hi! link TodoBgWARN ColorOrangeBg
hi! link TodoSignWARN ColorOrange
hi! link TodoFgTODO ColorGreenBg
hi! link TodoBgTODO ColorGreenBg
hi! link TodoSignTODO ColorGreen
hi! link TodoFgNOTE ColorCyanBg
hi! link TodoBgNOTE ColorCyanBg
hi! link TodoSignNOTE ColorCyan
hi! link TodoFgPERF ColorPurpleBg
hi! link TodoBgPERF ColorPurpleBg
hi! link TodoSignPERF ColorPurple
hi! link TodoFgTEST ColorGrayBg
hi! link TodoBgTEST ColorGrayBg
hi! link TodoSignTEST ColorGray

" Markdown headers
hi! link RenderMarkdownH1 ColorRedBold
hi RenderMarkdownH1Bg guibg=#552a20
hi! link RenderMarkdownH2 ColorYellowBold
hi RenderMarkdownH2Bg guibg=#554010
hi! link RenderMarkdownH3 ColorGreenBold
hi RenderMarkdownH3Bg guibg=#1a4535
hi! link RenderMarkdownH4 ColorCyanBold
hi RenderMarkdownH4Bg guibg=#1a3a50
hi! link RenderMarkdownH5 ColorPurpleBold
hi RenderMarkdownH5Bg guibg=#352545
hi! link RenderMarkdownH6 ColorGrayBold
hi RenderMarkdownH6Bg guibg=#2a2a2a

hi! link @markup.heading.1.markdown RenderMarkdownH1
hi! link @markup.heading.2.markdown RenderMarkdownH2
hi! link @markup.heading.3.markdown RenderMarkdownH3
hi! link @markup.heading.4.markdown RenderMarkdownH4
hi! link @markup.heading.5.markdown RenderMarkdownH5
hi! link @markup.heading.6.markdown RenderMarkdownH6

" Markdown callouts
hi! link RenderMarkdownError ColorRed
hi! link RenderMarkdownWarn ColorYellow
hi! link RenderMarkdownSuccess ColorGreen
hi! link RenderMarkdownInfo ColorCyan
hi! link RenderMarkdownHint ColorPurple

" Markdown elements
hi RenderMarkdownTableHead guifg=#4a8a8d
hi RenderMarkdownTableFill guifg=#4a8a8d
hi RenderMarkdownTableRow guifg=#2d5557
hi @markup.heading.markdown guifg=#a1e7eb gui=bold
hi! link RenderMarkdownBullet Constant
hi! link RenderMarkdownDash Constant
hi! link RenderMarkdownQuote Constant
hi! link RenderMarkdownLink Constant
hi! link RenderMarkdownWikiLink Constant
hi! link RenderMarkdownUnchecked Constant
hi! link RenderMarkdownChecked String
hi RenderMarkdownCode guibg=#1a1a2a gui=NONE cterm=NONE blend=20
hi RenderMarkdownCodeInline guifg=#a1e7eb guibg=#1a1a2a gui=NONE cterm=NONE
hi! link @markup.math Constant
hi! link @markup.raw Constant
hi! link @markup.raw.markdown_inline Constant
hi! link @markup.quote.markdown Constant

" UI links
hi! link Terminal Normal
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo

" UI elements
hi Normal guifg=#fefefe guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#1a2a53 guibg=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#1a2a53 guibg=#1a2a53 gui=bold cterm=NONE
hi LineNr guifg=#666666 guibg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=NONE guibg=#333333 gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=#262626 gui=NONE cterm=NONE
hi StatusLine guifg=#1a2a53 guibg=#1a2a53 gui=bold cterm=NONE
hi StatusLineNC guifg=#1a2a53 guibg=#1a2a53 gui=bold cterm=NONE
hi StatusLineTerm guifg=#1a2a53 guibg=#1a2a53 gui=bold cterm=NONE
hi StatusLineTermNC guifg=#1a2a53 guibg=#1a2a53 gui=bold cterm=NONE
hi Pmenu guifg=NONE guibg=#333333 gui=NONE cterm=NONE
hi PmenuSel guifg=#fefefe guibg=#ad2a30 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#1a2a53 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#ad2a30 gui=NONE cterm=NONE
hi CmpMenu guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi CmpMenuSbar guifg=NONE guibg=#1a2a53 gui=NONE cterm=NONE
hi CmpMenuThumb guifg=NONE guibg=#ad2a30 gui=NONE cterm=NONE
hi TabLine guifg=#666666 guibg=#333333 gui=NONE cterm=NONE
hi TabLineSel guifg=#fefefe guibg=#ad2a30 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi CursorLine guifg=#fefefe guibg=#ad2a30 gui=bold cterm=NONE
hi CursorColumn guifg=NONE guibg=#333333 gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#000000 gui=NONE cterm=NONE
hi Visual guifg=#fefefe guibg=#ad2a30 gui=NONE cterm=NONE
hi VisualNOS guifg=#fefefe guibg=#ad2a30 gui=NONE cterm=NONE
hi Cursor guifg=#333333 guibg=#d7d787 gui=NONE cterm=NONE
hi lCursor guifg=#262626 guibg=#ffafaf gui=NONE cterm=NONE
hi Search guifg=#fefefe guibg=#ad2a30 gui=NONE cterm=NONE
hi IncSearch guifg=#fefefe guibg=#d83e4a gui=NONE cterm=NONE
hi MatchParen guifg=#fefefe guibg=#1a2a53 gui=NONE cterm=NONE
hi Folded guifg=#666666 guibg=#000000 gui=NONE cterm=NONE
hi FoldColumn guifg=#5f87d7 guibg=#000000 gui=NONE cterm=NONE
hi Error guifg=#ff0000 guibg=#ffffff gui=reverse cterm=reverse
hi ErrorMsg guifg=#1f1b2d guibg=#ff0000 gui=reverse cterm=reverse
hi WarningMsg guifg=#ff8787 guibg=NONE gui=NONE cterm=NONE
hi ModeMsg guifg=#fefefe guibg=#ad2a30 gui=NONE cterm=NONE
hi MoreMsg guifg=#00875f guibg=NONE gui=NONE cterm=NONE
hi Question guifg=#e165a7 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#d7d787 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#00875f guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guifg=#000000 guibg=#5f87d7 gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#262626 guibg=#d7d787 gui=NONE cterm=NONE
hi WildMenu guifg=#262626 guibg=#d7d787 gui=NONE cterm=NONE
hi Underlined guifg=#5f87d7 guibg=NONE gui=underline cterm=underline
hi Todo guifg=#14423f guibg=NONE gui=bold cterm=NONE
hi SpellBad guifg=#ff0000 guibg=NONE guisp=#ff0000 gui=undercurl cterm=underline
hi SpellCap guifg=#ffff00 guibg=NONE guisp=#ffff00 gui=undercurl cterm=underline
hi SpellLocal guifg=#ffafaf guibg=NONE guisp=#ffafaf gui=undercurl cterm=underline
hi SpellRare guifg=#ffd7af guibg=NONE guisp=#ffd7af gui=undercurl cterm=underline

" Code syntax
hi Comment guifg=#4c6a84 guibg=#181c22 gui=NONE cterm=NONE
hi String guifg=#86a87e guibg=#1a2a1f gui=NONE cterm=NONE
hi Constant guifg=#a1e7eb guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#fefefe guibg=NONE gui=NONE cterm=NONE
hi Function guifg=#f36630 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi Structure guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#f36630 guibg=NONE gui=NONE cterm=NONE
hi Define guifg=#f36630 guibg=NONE gui=bold cterm=bold
hi Operator guifg=#fefefe guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#4c6a84 guibg=NONE gui=NONE cterm=NONE
hi Directory guifg=#d83e4a guibg=NONE gui=bold cterm=bold
hi Title guifg=#d83e4a guibg=NONE gui=bold cterm=bold
hi Conceal guifg=#4c6a84 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IblIndent guifg=#4c6a84 guibg=NONE gui=NONE cterm=NONE

" Diagnostics & Diff
hi DiagnosticError guifg=#ff0000 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#f59e07 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticHint guifg=#10b981 guibg=NONE gui=NONE cterm=NONE
hi! link DiagnosticInfo Constant
hi DiffAdd guifg=#ffffff guibg=#5f875f gui=NONE cterm=NONE
hi DiffChange guifg=#ffffff guibg=#5f87af gui=NONE cterm=NONE
hi DiffText guifg=#000000 guibg=#c6c6c6 gui=NONE cterm=NONE
hi DiffDelete guifg=#ffffff guibg=#af5faf gui=NONE cterm=NONE

" Notify
hi NotifyBackground guibg=#000000

" NeoTree
hi NeoTreeDirectoryIcon guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi NeoTreeDirectoryName guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi! link NeoTreeRootName NeoTreeDirectoryName
hi NeoTreeFloatBorder guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi NeoTreeFloatTitle guifg=#d83e4a guibg=NONE gui=NONE cterm=NONE
hi NeoTreeFloatNormal guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi! link NormalFloat NeoTreeFloatNormal
hi NeoTreeVertSplit guifg=#1a2a53 guibg=NONE gui=NONE cterm=NONE blend=0
hi NeoTreeDotfile guifg=#4c6a84 guibg=NONE gui=NONE cterm=NONE
hi NeoTreeHiddenByName guifg=#4c6a84 guibg=NONE gui=NONE cterm=NONE

" Rainbow delimiters
hi RainbowRed guifg=#d83e4a
hi RainbowOrange guifg=#f36630
hi RainbowYellow guifg=#ffcc33
hi RainbowGreen guifg=#86a87e
hi RainbowCyan guifg=#a1e7eb
hi RainbowBlue guifg=#4c6a84
hi RainbowViolet guifg=#d89fff

" Data languages (YAML/JSON/TOML/Helm)
hi StringData guifg=#86a87e guibg=NONE gui=NONE cterm=NONE
hi! link @string.yaml StringData
hi! link @string.toml StringData
hi! link @string.json StringData
hi! link @string.helm StringData
hi! link @property Statement
hi! link @property.yaml Statement
hi! link @property.json Statement
hi! link @property.toml Statement
hi! link @property.helm Statement
hi! link @label.json Statement
hi! link @label.yaml Statement
hi! link @field.yaml Statement
hi! link @field.helm Statement

" Helm
hi HelmDirective guifg=#ec8509 guibg=NONE gui=NONE cterm=NONE
hi! link @keyword.conditional.helm HelmDirective
hi! link @keyword.repeat.helm HelmDirective
hi! link @keyword.helm HelmDirective
hi! link @conditional.helm HelmDirective
hi! link @repeat.helm HelmDirective
hi! link @function.helm HelmDirective
hi! link @function.call.helm HelmDirective
hi! link @function.builtin.helm HelmDirective
hi! link @variable.helm Identifier
hi! link @constant.builtin.helm Constant
hi! link @punctuation.bracket.helm Special
