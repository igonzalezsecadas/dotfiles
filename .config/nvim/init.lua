-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.winborder = "rounded"
vim.o.cursorline = true
vim.o.scrolloff = 999
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.guicursor = "n-v-i-c:block-Cursor"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.diagnostic.config({ virtual_text = true })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Package management
vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/AlphaTechnolog/pywal.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mini.nvim/mini.pick" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.comment" },
})

-- Plugin setup
require("nvim-tree").setup()
require("nvim-autopairs").setup()
require("nvim-highlight-colors").setup({})
require("mason").setup()
vim.lsp.enable("lua_ls")
require("mini.pick").setup()
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()
require("mini.surround").setup()
require("mini.comment").setup()

require("blink.cmp").setup({
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	completion = {
		documentation = { auto_show = true },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
})



-- Keymaps
local map = vim.keymap
vim.g.mapleader = " "
map.set('n', '<leader>o', ':update<CR> :source<CR>')
map.set('n', '<leader>w', ':write<CR>')
map.set('n', '<leader>q', ':quit<CR>')
map.set('n', '<leader>r', ':make<CR>')
map.set('n', '<leader>lf', vim.lsp.buf.format)
map.set('n', '<leader>cd', ":NvimTreeToggle<CR>")
map.set('n', 'ff', MiniPick.builtin.files)
map.set('n', 'fg', MiniPick.builtin.grep_live)
map.set('n', 'fh', MiniPick.builtin.help)
map.set('n', 'grd', vim.lsp.buf.definition)
-- grr (go to lsp references)
-- grn (lsp rename)
-- grt (go to type definition)
-- Copy paste shortcuts
map.set({ 'n', 'v', 'x' }, '<M-y>', '"+y<CR>')
map.set({ 'n', 'v', 'x' }, '<M-d>', '"+d<CR>')
map.set({ 'n', 'v', 'x' }, '<M-p>', '"+p<CR>')
map.set({ 'i', 'c' }, '<M-p>', '<C-r>+')
map.set("n", "<leader>i", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
end)
map.set({"t", "n"}, "<Esc>", [[<C-\><C-n>]])

-- Navigate windows
map.set("n", "<M-h>", "<C-w>h")
map.set("n", "<M-j>", "<C-w>j")
map.set("n", "<M-k>", "<C-w>k")
map.set("n", "<M-l>", "<C-w>l")
map.set("n", "<leader>sv", ":vsplit<CR>")
map.set("n", "<leader>sh", ":split<CR>")

-- Resize windows
map.set("n", "<M-Up>", ":resize +1<CR>")
map.set("n", "<M-Down>", ":resize -1<CR>")
map.set("n", "<M-Left>", ":vertical resize -1<CR>")
map.set("n", "<M-Right>", ":vertical resize +1<CR>")
