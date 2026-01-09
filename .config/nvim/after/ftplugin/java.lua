if vim.b.did_java_ftplugin then
	return
end
vim.b.did_java_ftplugin = true

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.colorcolumn = "100"

vim.opt_local.makeprg = "javac %:p && java %:t:r"
vim.opt_local.errorformat = "%f:%l: %m"
