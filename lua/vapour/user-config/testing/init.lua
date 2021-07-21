Vapour.plugins.which_key.user_defined.t = {
  name = "Test",
  n = {":TestNearest<cr>", "Nearest"},
  f = {":TestFile<cr>", "File"},
  s = {":TestSuite<cr>", "Suite"},
  l = {":TestLast<cr>", "Rerun"},
  g = {":TestVisit<cr>", "Revisit Test File"},
}

vim.cmd[[let test#php#phpunit#executable = './vendor/bin/phpunit']]
