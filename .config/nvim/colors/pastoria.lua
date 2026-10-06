vim.cmd("highlight clear")
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "pastoria"

local highlight = vim.api.nvim_set_hl

local colors = {
    bg       = "#1c1c1c",
    fg       = "#d0d0d0",

    cursor   = "#ffaf00",

    error_bg = "#800000",
    error_fg = "#ffffff",



    fold_bg        = "#5f5f87",

    search_bg      = "#afdf5f",
    linenr_fg      = "#9e9e9e",

    matchparen_fg  = "#dfdfdf",
    matchparen_bg  = "#5f87df",
    pmenu_fg       = "#000000",
    pmenu_bg       = "#949494",
    pmenu_sel_bg   = "#767676",
    pmenu_thumb    = "#d0d0d0",
    statusline     = "#4e4e4e",
    statusline_nc  = "#3a3a3a",
    tabline_bg     = "#666666",
    tablinefill_bg = "#4e4e4e",
    title_fg       = "#ffdfff",
    todo_fg        = "#000000",
    todo_bg        = "#dfdf00",
    underline_fg   = "#00afff",
    visual_fg      = "#eeeeee",
    visual_bg      = "#5f875f",
    visualnos_bg   = "#5f5f87",
    wildmenu_bg    = "#afdf87",

    comment        = "#808080",
    constant       = "#ffffaf",
    identifier     = "#dfafdf",
    ignore         = "#444444",
    number         = "#dfaf87",
    preproc        = "#afdf87",
    special        = "#df8787",
    statement      = "#87afdf",
    type           = "#afafdf",
    diffadd        = "#afdfaf",
    diffdel        = "#949494",
    diffchange     = "#dfafaf",
    difftext       = "#df8787",
}

-- Base editor
highlight(0, "Normal", { bg = colors.bg, fg = colors.fg })
highlight(0, "Visual", { bg = colors.visual_bg, fg = colors.error_fg })

highlight(0, "Cursor", { bg = colors.cursor, fg = colors.bg })
highlight(0, "lCursor", { bg = colors.cursor, fg = colors.bg })

highlight(0, "Error", { bg = colors.error_bg, fg = colors.error_fg })
highlight(0, "ErrorMsg", { bg = colors.error_bg, fg = colors.error_fg })

highlight(0, "Folded", { bg = colors.fold_bg, fg = colors.fg })

highlight(0, "IncSearch", { bg = colors.search_bg, fg = colors.bg })
highlight(0, "Search", { bg = colors.search_bg, fg = colors.bg })

highlight(0, "MatchParen", { bg = colors.matchparen_bg, fg = colors.bg })

highlight(0, "LineNr", { bg = colors.bg, fg = colors.linenr_fg })

highlight(0, "NonText", { fg = colors.linenr_fg })

highlight(0, "Pmenu", { fg = colors.pmenu_fg, bg = colors.pmenu_bg })
highlight(0, "PmenuSbar", { bg = "#767676" })
highlight(0, "PmenuSel", { fg = colors.pmenu_fg, bg = colors.pmenu_sel_bg })
highlight(0, "PmenuThumb", { bg = colors.pmenu_thumb })

highlight(0, "SignColumn", { fg = "#a8a8a8", bg = colors.bg })
highlight(0, "SpecialKey", { fg = colors.linenr_fg })
highlight(0, "SpellBad", { underline = true, sp = "#df0000" })
highlight(0, "SpellCap", { fg = "#d0d0ff", underline = true })
highlight(0, "SpellRare", { fg = "#d75f87", underline = true })
highlight(0, "StatusLine", { bg = colors.statusline, bold = true })
highlight(0, "StatusLineNC", { bg = colors.statusline_nc })
highlight(0, "TabLine", { fg = colors.fg, bg = colors.tabline_bg })
highlight(0, "TabLineFill", { fg = colors.fg, bg = colors.tablinefill_bg })
highlight(0, "Title", { fg = colors.title_fg })
highlight(0, "Todo", { fg = colors.todo_fg, bg = colors.todo_bg })
highlight(0, "Underlined", { fg = colors.underline_fg, underline = true })
highlight(0, "VertSplit", { fg = colors.statusline, bg = colors.statusline })
highlight(0, "VisualNOS", { fg = colors.visual_fg, bg = colors.visualnos_bg })
highlight(0, "WildMenu", { fg = colors.todo_fg, bg = colors.wildmenu_bg, bold = true })

-- Syntax
highlight(0, "Comment", { fg = colors.comment })
highlight(0, "Constant", { fg = colors.constant })
highlight(0, "Identifier", { fg = colors.type })
highlight(0, "Ignore", { fg = colors.ignore })
highlight(0, "Number", { fg = colors.number })
highlight(0, "PreProc", { fg = colors.fg })
highlight(0, "Special", { fg = colors.special })
highlight(0, "Statement", { fg = colors.statement })
highlight(0, "String", { fg = colors.constant })
highlight(0, "Function", { fg = colors.identifier })
highlight(0, "Type", { fg = colors.type })

-- Diff
highlight(0, "diffAdd", { bg = colors.diffadd, fg = colors.bg })
highlight(0, "diffDelete", { bg = colors.diffdel, fg = colors.bg })
highlight(0, "diffChange", { bg = colors.diffchange, fg = colors.bg })
highlight(0, "diffText", { bg = colors.difftext, fg = colors.bg })

-- Diagnostics
highlight(0, "DiagnosticError", { fg = colors.red })
highlight(0, "DiagnosticWarn", { fg = colors.yellow })
highlight(0, "DiagnosticInfo", { fg = colors.blue })
highlight(0, "DiagnosticHint", { fg = colors.cyan })

-- NvimTree
highlight(0, "NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
highlight(0, "NvimTreeFolderName", { fg = colors.blue })
highlight(0, "NvimTreeOpenedFolderName", { fg = colors.green })
highlight(0, "NvimTreeRootFolder", { fg = colors.yellow, bold = true })
highlight(0, "NvimTreeExecFile", { fg = colors.green })
highlight(0, "NvimTreeSpecialFile", { fg = colors.magenta, underline = true })


-- Python
vim.api.nvim_set_hl(0, "pythonBuiltin", { link = "Type" })
highlight(0, "pythonInclude", { fg = "#afdf87" })


highlight(0, "PreProc", { fg = colors.preproc })
highlight(0, "PreProc", { fg = colors.preproc })
highlight(0, "@Variable", { fg = colors.fg })

vim.api.nvim_set_hl(0, "@keyword.import.typescript", { link = "Special" })
