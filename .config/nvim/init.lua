-- vim: ts=2 sts=2 sw=2 et
-- https://github.com/nvim-lua/kickstart.nvim/tree/master
-- require("colors.pastoria")
vim.cmd.colorscheme("pastoria")

vim.g.mapleader = "`"
vim.opt.clipboard:append("unnamed")
vim.opt.guifont = "Menlo:h11"

--
--if vim.g.neovide then
--  vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+P') -- Paste normal and visual mode
--  vim.keymap.set({ 'i', 'c' }, '<D-v>', '<C-R>+') -- Paste insert and command mode
--  vim.keymap.set('t', '<D-v>', [[<C-\><C-N>"+P]]) -- Paste terminal mode
--
--  vim.g.neovide_cursor_animation_length = 0
--  vim.g.neovide_cursor_short_animation_length = 0
--  vim.g.neovide_cursor_trail_size = 0
--  vim.g.neovide_cursor_animate_in_insert_mode = false
--  vim.g.neovide_cursor_animate_command_line = false
--  vim.g.neovide_hide_mouse_when_typing = true
--end

--vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
--vim.api.nvim_set_keymap('c', '<D-v>', '<C-R>+', { noremap = true, silent = true})
--vim.keymap.set({ 'i', 'c' }, '<D-v>', '<C-R>+') -- Paste insert and command mode

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.completeopt = { "fuzzy", "menuone", "popup", "longest" }
--vim.opt.iskeyword:append({ "_", "$", "%", "#" })
--vim.opt.whichwrap:append("b,s,h,l,<,>,~,],[")
vim.opt.virtualedit = "block"
--vim.opt.formatoptions:append("rol")
--vim.opt.switchbuf = "usetab"
--vim.opt.syntax = "on"
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·", nbsp = '␣' }
vim.opt.number = true
vim.opt.report = 0
vim.opt.showmatch = true
vim.opt.statusline =
"[%n] %F %(%h%w %) %(%r%m %)[%{&ff}] [%{(&fenc==''?&enc:&fenc).((exists('+bomb') && &bomb)?',B':'')}] %y %=lin:%l/%L %-7scol:%c%V %P"
vim.opt.wrap = false
vim.opt.foldlevel = 99
vim.opt.mouse = "a"

-- Splits
vim.opt.equalalways = false
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Wild menu
vim.opt.wildmenu = true
vim.opt.wildmode = { "list", "longest" }
vim.opt.wildignorecase = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Scroll
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10


local map = vim.keymap.set
--
-- -- plugin toggles
-- -- YCM bindings
-- map("n", "<M-g>", ":YcmCompleter GoToDefinition<CR>", opts)
-- map("n", "<M-f>", ":YcmCompleter GoToReferences<CR>", opts)
-- map("n", "<M-d>", ":YcmCompleter GetDoc<CR>", opts)
-- map("n", "<M-t>", ":YcmCompleter GetType<CR>", opts)
-- map("n", "<M-r>", ":YcmCompleter RefactorRename<SPACE>", opts)
--
--
-- -- editing
map("n", "/", ":nohl<CR>/")
map("n", "<leader>indent", "gg=G``")
map("n", "V", "v$")
map("n", "vv", "V")

--
-- window nav
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-A-H>", "<C-w>H")
map("n", "<C-A-J>", "<C-w>J")
map("n", "<C-A-K>", "<C-w>K")
map("n", "<C-A-L>", "<C-w>L")

map("n", "<C-D-H>", "<C-w>H")
map("n", "<C-D-J>", "<C-w>J")
map("n", "<C-D-K>", "<C-w>K")
map("n", "<C-D-L>", "<C-w>L")
--
-- -- tab nav
-- map("n", "<C-Tab>", ":tabn<CR>")
-- map("n", "<C-S-Tab>", ":tabp<CR>")
--
-- -- misc
-- map("n", "<leader>cd", ":cd %:p:h<CR>")
-- map("n", "<leader>cmd", ":!start cmd<CR>")
map("v", ">", ">gv")
map("v", "<", "<gv")
map("n", "j", "gj")
map("n", "k", "gk")


map('n', '<leader>s', function()
  local view = vim.fn.winsaveview()
  local search = vim.fn.getreg('/')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setreg('/', search)
  vim.fn.winrestview(view)
end)


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "tpope/vim-sleuth",
      version = "*",
      event = { "BufReadPost", "BufNewFile" }
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup()
      end
    },
    {
      "lewis6991/gitsigns.nvim",
      version = "*",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require('gitsigns').setup()
      end
    },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()

        local installable = {}
        for _, lang in ipairs(treesitter.get_available()) do
          installable[lang] = true
        end

        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
            if not lang or not installable[lang] then
              return
            end

            if not pcall(vim.treesitter.language.inspect, lang) then
              treesitter.install({ lang })
              return
            end

            if pcall(vim.treesitter.start, 0, lang) then
              vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
              vim.wo.foldmethod = 'expr'
            end
          end,
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("nvim-treesitter-textobjects").setup({
          select = {
            lookahead = true,
          },
        })

        local select = require("nvim-treesitter-textobjects.select").select_textobject
        vim.keymap.set({ "x", "o" }, "af", function() select("@function.outer", "textobjects") end,
          { desc = "around function" })
        vim.keymap.set({ "x", "o" }, "if", function() select("@function.inner", "textobjects") end,
          { desc = "inner function" })
        vim.keymap.set({ "x", "o" }, "ac", function() select("@class.outer", "textobjects") end,
          { desc = "around class" })
        vim.keymap.set({ "x", "o" }, "ic", function() select("@class.inner", "textobjects") end, { desc = "inner class" })
        vim.keymap.set({ "x", "o" }, "aa", function() select("@parameter.outer", "textobjects") end,
          { desc = "around parameter" })
        vim.keymap.set({ "x", "o" }, "ia", function() select("@parameter.inner", "textobjects") end,
          { desc = "inner parameter" })
      end,
    },
    { -- conform.format()
      "stevearc/conform.nvim",
      version = "*",
      event = { "BufWritePre" },
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            markdown = { "prettierd" },
            xml = { "xmlformatter" },
          },
          format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.conform_disable or vim.b[bufnr].conform_disable then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end,
        })

        vim.api.nvim_create_user_command("Conform", function(args)
          if #args.fargs == 0 then
            -- No arguments like "enable" or "disable" provided, so format.
            local range_spec = nil
            if args.count ~= -1 then -- A range was specified
              local end_line_content = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
              range_spec = {
                start = { args.line1, 0 },
                ["end"] = { args.line2, end_line_content:len() },
              }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range_spec })
            return
          end

          local action = args.fargs[1]
          if action == "disable" then
            if args.bang then
              -- Conform! disable will disable formatting just for this buffer
              vim.b.conform_disable = true
            else
              vim.g.conform_disable = true
            end
          elseif action == "enable" then
            vim.b.conform_disable = false
            vim.g.conform_disable = false
          else
            error("Invalid argument: " .. action .. ". Use 'enable' or 'disable'")
          end
        end, {
          desc = "Format code (selected range or buffer), or enable/disable autoformat-on-save",
          nargs = "?",  -- Allows 0 or 1 argument
          bang = true,
          range = true, -- Process range from visual selection or :'<,'>
          complete = function()
            return { "enable", "disable" }
          end,
        })
      end,
    },
    {
      "mfussenegger/nvim-lint",
      version = "*",
      event = { "BufWritePost", "BufReadPost", "InsertLeave" },
      config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
          python = { "mypy", "ruff" },
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
        }

        -- Re-lint when saving, etc
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
          callback = function()
            lint.try_lint(nil, { ignore_errors = true })
          end,
        })
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup({})
        vim.keymap.set("n", "<F4>", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })
      end,
    },
    {
      "ibhagwan/fzf-lua",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "<C-p>", "<cmd>FzfLua files<cr>",                      desc = "Find files" },
        { "<C-f>", "<cmd>FzfLua live_grep<cr>",                  desc = "Live grep" },
        { "<C-s>", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Lsp live workspace symbols" },
        { "<C-a>", "<cmd>FzfLua<cr>",                            desc = "FzfLua" },
        -- { "grr",   "<cmd>FzfLua lsp_references<cr>",      desc = "LSP references" },
        -- { "gra",   "<cmd>FzfLua lsp_code_actions<cr>",    desc = "LSP code actions" },
        -- { "gri",   "<cmd>FzfLua lsp_implementations<cr>", desc = "LSP implementations" },
      },
      config = function()
        require("fzf-lua").setup({ "hide", })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      branch = "master",
      event = "VeryLazy",
      dependencies = { 'saghen/blink.cmp', 'williamboman/mason.nvim' },
      config = function()
        vim.lsp.config('lua_ls', {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            }
          }
        })

        vim.lsp.enable('lua_ls')
        vim.lsp.enable('basedpyright')
        -- vim.lsp.enable('vtsls')

        vim.lsp.config("roslyn", {
          on_attach = function()
            print("This will run when the server attaches!")
          end,
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        })
        vim.lsp.enable('roslyn')
      end,
    },
    {
      "seblyng/roslyn.nvim"
    },
    {
      'saghen/blink.cmp',
      version = '1',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'default' },
        signature = {
          enabled = true,
          window = {
            show_documentation = false,
          },
        },
        completion = {
          documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        cmdline = { -- https://cmp.saghen.dev/configuration/reference.html#cmdline
          enabled = false,
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
      },
      opts_extend = { "sources.default" },
    },
    {
      'mason-org/mason.nvim',
      version = "*",
      opts = {
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry", -- roslyn ls
        }
      },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
    {
      'echasnovski/mini.hipatterns',
      version = '*',
      config = function()
        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
          highlighters = {
            hex_color = hipatterns.gen_highlighter.hex_color(),
          },
        })
      end,
    },
    {
      'sheerun/vim-polyglot',
      init = function()
        vim.g.polyglot_disabled = { 'sensible' }
      end,
    },
    {
      'tpope/vim-fugitive',
    },
  },
  install = { colorscheme = { "default" } },
})

vim.diagnostic.config({
  signs = false,
  float = true,
  virtual_lines = false,
  virtual_text = false,
})
vim.keymap.set("n", "grd", vim.diagnostic.open_float, { desc = "Show diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});
