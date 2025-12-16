-- Option configuration
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 999
vim.opt.winborder = "rounded"
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.signcolumn = "number"
vim.opt.guicursor = "n-v-i-c:block-Cursor"

-- Plugins manager
vim.pack.add({
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/AlphaTechnolog/pywal.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp" },
})

-- Standalone plugis with no config
require("nvim-autopairs").setup()
require("nvim-highlight-colors").setup()
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()

-- Telescope config
local telescope = require("telescope")
telescope.setup({
    pickers = {
        find_files = {
            hidden = true
        }
    }
})

-- Mason config
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
        "jdtls",
        "html",
    },
    auto_install = { enable = true},
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

require("blink.cmp").setup({
    signature = { enabled = true },
    completion = {
        documentation = { auto_show = false },
        menu = {
            auto_show = true,
            draw = {
                treesitter = { "lsp" },
                columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
            },
        },
    },
})

-- Treesitter
local treesitter = require("nvim-treesitter")
treesitter.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    autotage = { enable = true },
    ensure_installed = {
        "lua",
        "java",
        "c",
        "python",
        "cpp",
        "css",
        "html",
        "php",
        "markdown",
    },
    auto_install = { enable = false },
})

-- Theme and lualine config
require("pywal").setup()
vim.api.nvim_set_hl(0, "CursorLine", {
    bg = "#3c3f41", -- JetBrains Darcula style background for cursor line
})
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFCC66", bold = true })
local fg_colors = {
    Normal     = "#A9B7C6", -- texto normal
    Comment    = "#808080", -- comentarios
    Keyword    = "#CC7832", -- palabras clave
    Identifier = "#A9B7C6", -- nombres de variables
    Function   = "#FFC66D", -- funciones
    Statement  = "#CC7832", -- declaraciones
    Type       = "#A9B7C6", -- tipos
    Constant   = "#6897BB", -- constantes
    String     = "#6A8759", -- cadenas
    Number     = "#6897BB", -- números
    Operator   = "#A9B7C6", -- operadores
}

for group, color in pairs(fg_colors) do
    vim.api.nvim_set_hl(0, group, { fg = color })
end

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
        component_separators = { '', '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- Keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

local colors = {}
local ls = require("luasnip")
local builtin = require("telescope.builtin")
local map = vim.keymap.set
local current = 1

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>")
map("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>")
map("n", "<leader>ff", builtin.find_files)


