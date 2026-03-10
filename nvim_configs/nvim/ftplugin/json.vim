map <buffer> <C-K> <cmd>%!jq . --indent 4<cr><cmd>%!sed 's/{/{\n    /'<CR>
set <buffer> conceallevel=0
