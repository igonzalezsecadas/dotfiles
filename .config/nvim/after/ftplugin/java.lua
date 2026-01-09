if vim.b.did_java_ftplugin then
  return
end
vim.b.did_java_ftplugin = true

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.colorcolumn = "100"

local function find_pom()
  local files = vim.fs.find("pom.xml", { upward = true })
  return files[1]
end

local pom_path = find_pom()

if pom_path then
  local project_root = vim.fs.dirname(pom_path)

  local mvn_compile = "mvn -f " .. project_root .. "/pom.xml -q compile"
  local mvn_run     = "mvn -f " .. project_root .. "/pom.xml -q exec:java"

  vim.opt_local.makeprg = mvn_compile .. " && " .. mvn_run

  vim.opt_local.errorformat = "%f:%l: %m"

else
  vim.opt_local.makeprg = "javac % && java %:t:r"
  vim.opt_local.errorformat = "%f:%l: %m"
end

