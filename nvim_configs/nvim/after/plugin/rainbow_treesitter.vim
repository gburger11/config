lua << EOF

-- Necessary for Rainbow with treesitter : https://github.com/luochen1990/rainbow/issues/163
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })

EOF
