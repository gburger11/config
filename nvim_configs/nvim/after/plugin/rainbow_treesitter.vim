lua << EOF

-- Necessary for Rainbow with treesitter : https://github.com/luochen1990/rainbow/issues/163
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })

-- IndentMini needs that. It doesn't work when put with the rest
vim.cmd.highlight('IndentLine guifg=#545454')
vim.cmd.highlight('IndentLineCurrent guifg=#999999')

EOF
