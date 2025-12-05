return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
	local configs =  require("nvim-treesitter.configs")
	configs.setup({
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
	    },
	    auto_install = { enable = false },
	})
    end
}
