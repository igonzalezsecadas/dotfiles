if vim.b.did_python_ftplugin then
  return
end
vim.b.did_python_ftplugin = true

vim.opt_local.makeprg = "python3 %:p"

vim.opt_local.errorformat = table.concat({
  "%E  File \"%f\"\\, line %l",
  "%E%*[^\\ ]Error: %m",
  "%Z%p^",
  "%-G%.%#",
}, ",")

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
