" custom colorscheme

set background=dark
hi clear
let g:colors_name = 'custom'

let s:t_Co = &t_Co

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#251e22', '#ffb4ab', '#b8e6b8', '#ecdf63', '#bcccff', '#c9a4ff', '#a8e0e6', '#eddfe4', '#9b8d94', '#ffc9a8', '#cdf0cd', '#f5ea9a', '#d3dcff', '#ddc4ff', '#c8eef2', '#fff8f9']
  for i in range(g:terminal_ansi_colors->len())
    let g:terminal_color_{i} = g:terminal_ansi_colors[i]
  endfor
endif

" Shared colors (TODOs, Headers, Callouts)
hi ColorRed guifg=#ffb4ab guibg=NONE gui=NONE cterm=NONE
hi ColorRedBold guifg=#ffb4ab guibg=NONE gui=bold cterm=bold
hi ColorRedBg guifg=#ffb4ab guibg=#5a3530 gui=bold cterm=bold
hi ColorYellow guifg=#ecdf63 guibg=NONE gui=NONE cterm=NONE
hi ColorYellowBold guifg=#ecdf63 guibg=NONE gui=bold cterm=bold
hi ColorYellowBg guifg=#ecdf63 guibg=#5a5630 gui=bold cterm=bold
hi ColorOrange guifg=#ffc9a8 guibg=NONE gui=NONE cterm=NONE
hi ColorOrangeBold guifg=#ffc9a8 guibg=NONE gui=bold cterm=bold
hi ColorOrangeBg guifg=#ffc9a8 guibg=#5a4030 gui=bold cterm=bold
hi ColorGreen guifg=#b8e6b8 guibg=NONE gui=NONE cterm=NONE
hi ColorGreenBold guifg=#b8e6b8 guibg=NONE gui=bold cterm=bold
hi ColorGreenBg guifg=#b8e6b8 guibg=#305a30 gui=bold cterm=bold
hi ColorCyan guifg=#a8e0e6 guibg=NONE gui=NONE cterm=NONE
hi ColorCyanBold guifg=#a8e0e6 guibg=NONE gui=bold cterm=bold
hi ColorCyanBg guifg=#a8e0e6 guibg=#30565a gui=bold cterm=bold
hi ColorPurple guifg=#c9a4ff guibg=NONE gui=NONE cterm=NONE
hi ColorPurpleBold guifg=#c9a4ff guibg=NONE gui=bold cterm=bold
hi ColorPurpleBg guifg=#c9a4ff guibg=#41305a gui=bold cterm=bold
hi ColorGray guifg=#c9bcc2 guibg=NONE gui=NONE cterm=NONE
hi ColorGrayBold guifg=#c9bcc2 guibg=NONE gui=bold cterm=bold
hi ColorGrayBg guifg=#c9bcc2 guibg=#5a3043 gui=bold cterm=bold

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
hi RenderMarkdownH1Bg guibg=#5a3530
hi! link RenderMarkdownH2 ColorYellowBold
hi RenderMarkdownH2Bg guibg=#5a5630
hi! link RenderMarkdownH3 ColorGreenBold
hi RenderMarkdownH3Bg guibg=#305a30
hi! link RenderMarkdownH4 ColorCyanBold
hi RenderMarkdownH4Bg guibg=#30565a
hi! link RenderMarkdownH5 ColorPurpleBold
hi RenderMarkdownH5Bg guibg=#41305a
hi! link RenderMarkdownH6 ColorGrayBold
hi RenderMarkdownH6Bg guibg=#5a3043

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
hi RenderMarkdownTableHead guifg=#ddbecf
hi RenderMarkdownTableFill guifg=#9b8d94
hi RenderMarkdownTableRow guifg=#9d828e
hi @markup.heading.markdown guifg=#f7b1de gui=bold
hi! link RenderMarkdownBullet Constant
hi! link RenderMarkdownDash Constant
hi! link RenderMarkdownQuote Constant
hi! link RenderMarkdownLink Constant
hi! link RenderMarkdownWikiLink Constant
hi! link RenderMarkdownUnchecked Constant
hi! link RenderMarkdownChecked String
hi RenderMarkdownCode guibg=#362b46 gui=NONE cterm=NONE blend=20
hi RenderMarkdownCodeInline guifg=#a8e0e6 guibg=#362b46 gui=NONE cterm=NONE
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
hi Normal guifg=#eddfe4 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#9d828e guibg=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#9d828e guibg=NONE gui=bold cterm=NONE
hi LineNr guifg=#9b8d94 guibg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=#f7b1de guibg=#2f282c gui=bold cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi StatusLine guifg=#eddfe4 guibg=#2f282c gui=bold cterm=NONE
hi StatusLineNC guifg=#9b8d94 guibg=#251e22 gui=NONE cterm=NONE
hi StatusLineTerm guifg=#eddfe4 guibg=#2f282c gui=bold cterm=NONE
hi StatusLineTermNC guifg=#9b8d94 guibg=#251e22 gui=NONE cterm=NONE
hi Pmenu guifg=#eddfe4 guibg=#251e22 gui=NONE cterm=NONE
hi PmenuSel guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#251e22 gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#ddbecf gui=NONE cterm=NONE
hi CmpMenu guifg=NONE guibg=#251e22 gui=NONE cterm=NONE
hi CmpMenuSbar guifg=NONE guibg=#251e22 gui=NONE cterm=NONE
hi CmpMenuThumb guifg=NONE guibg=#ddbecf gui=NONE cterm=NONE
hi TabLine guifg=#9b8d94 guibg=#251e22 gui=NONE cterm=NONE
hi TabLineSel guifg=#181215 guibg=#f7b1de gui=bold cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#2f282c gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#2f282c gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#201a1e gui=NONE cterm=NONE
hi Visual guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi VisualNOS guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi Cursor guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi lCursor guifg=#181215 guibg=#ddbecf gui=NONE cterm=NONE
hi Search guifg=#181215 guibg=#ddbecf gui=NONE cterm=NONE
hi IncSearch guifg=#181215 guibg=#ffc9a8 gui=NONE cterm=NONE
hi MatchParen guifg=#f7b1de guibg=#3b3337 gui=bold cterm=NONE
hi Folded guifg=#c9bcc2 guibg=#251e22 gui=NONE cterm=NONE
hi FoldColumn guifg=#9b8d94 guibg=NONE gui=NONE cterm=NONE
hi Error guifg=#690005 guibg=#ffb4ab gui=NONE cterm=NONE
hi ErrorMsg guifg=#ffdad6 guibg=#93000a gui=bold cterm=NONE
hi WarningMsg guifg=#ffc9a8 guibg=NONE gui=NONE cterm=NONE
hi ModeMsg guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi MoreMsg guifg=#b8e6b8 guibg=NONE gui=NONE cterm=NONE
hi Question guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#9d828e guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#9b8d94 guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guifg=#181215 guibg=#ddbecf gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi WildMenu guifg=#181215 guibg=#f7b1de gui=NONE cterm=NONE
hi Underlined guifg=#f7b1de guibg=NONE gui=underline cterm=underline
hi Todo guifg=#ffc9a8 guibg=NONE gui=bold cterm=NONE
hi SpellBad guifg=NONE guibg=NONE guisp=#ffb4ab gui=undercurl cterm=underline
hi SpellCap guifg=NONE guibg=NONE guisp=#ecdf63 gui=undercurl cterm=underline
hi SpellLocal guifg=NONE guibg=NONE guisp=#a8e0e6 gui=undercurl cterm=underline
hi SpellRare guifg=NONE guibg=NONE guisp=#c9a4ff gui=undercurl cterm=underline

" Code syntax
if get(g:, 'custom_token_bg', 1)
  hi Comment guifg=#c9bcc2 guibg=#3a2c32 gui=italic cterm=NONE
  hi String guifg=#b8e6b8 guibg=#2b462b gui=NONE cterm=NONE
else
  hi Comment guifg=#c9bcc2 guibg=NONE gui=italic cterm=NONE
  hi String guifg=#b8e6b8 guibg=NONE gui=NONE cterm=NONE
endif
hi Constant guifg=#a8e0e6 guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#eddfe4 guibg=NONE gui=NONE cterm=NONE
hi Function guifg=#ffc9a8 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi Structure guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#ffc9a8 guibg=NONE gui=NONE cterm=NONE
hi Define guifg=#ffc9a8 guibg=NONE gui=bold cterm=bold
hi Operator guifg=#d3c2ca guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#c9a4ff guibg=NONE gui=NONE cterm=NONE
hi Directory guifg=#f7b1de guibg=NONE gui=bold cterm=bold
hi Title guifg=#f7b1de guibg=NONE gui=bold cterm=bold
hi Conceal guifg=#9b8d94 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IblIndent guifg=#9d828e guibg=NONE gui=NONE cterm=NONE

" Diagnostics & Diff
hi DiagnosticError guifg=#ffb4ab guibg=NONE gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#ffc9a8 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticHint guifg=#a8e0e6 guibg=NONE gui=NONE cterm=NONE
hi! link DiagnosticInfo Constant
hi DiffAdd guifg=#b8e6b8 guibg=#1c2a1e gui=NONE cterm=NONE
hi DiffChange guifg=#ecdf63 guibg=#2a2618 gui=NONE cterm=NONE
hi DiffText guifg=#181215 guibg=#ecdf63 gui=bold cterm=NONE
hi DiffDelete guifg=#ffb4ab guibg=#2f1c1e gui=NONE cterm=NONE

" Notify
hi NotifyBackground guibg=#181215

" NeoTree
hi NeoTreeDirectoryIcon guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi NeoTreeDirectoryName guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi! link NeoTreeRootName NeoTreeDirectoryName
hi NeoTreeFloatBorder guifg=#ddbecf guibg=NONE gui=NONE cterm=NONE
hi NeoTreeFloatTitle guifg=#f7b1de guibg=NONE gui=NONE cterm=NONE
hi NeoTreeFloatNormal guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi! link NormalFloat NeoTreeFloatNormal
hi NeoTreeVertSplit guifg=#9d828e guibg=NONE gui=NONE cterm=NONE blend=0
hi NeoTreeDotfile guifg=#9b8d94 guibg=NONE gui=NONE cterm=NONE
hi NeoTreeHiddenByName guifg=#9b8d94 guibg=NONE gui=NONE cterm=NONE

" Rainbow delimiters
hi RainbowRed guifg=#ffb4ab
hi RainbowOrange guifg=#ffc9a8
hi RainbowYellow guifg=#ecdf63
hi RainbowGreen guifg=#b8e6b8
hi RainbowCyan guifg=#a8e0e6
hi RainbowBlue guifg=#bcccff
hi RainbowViolet guifg=#c9a4ff

" Data languages (YAML/JSON/TOML/Helm)
hi StringData guifg=#b8e6b8 guibg=NONE gui=NONE cterm=NONE
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
hi HelmDirective guifg=#ffc9a8 guibg=NONE gui=NONE cterm=NONE
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
