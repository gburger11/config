map <buffer> <C-K> :Black<CR>
imap <buffer> <C-K> <C-O>:Black<CR>

" Do things for python icecream
nnoremap <buffer> èO ggO<Esc>ccfrom icecream import ic, install<CR>install()<CR>ic.configureOutput(includeContext=True)<Esc><C-O>
nnoremap <buffer> èoo oic()<Esc>
nnoremap <buffer> èoè viwyOic()<Esc>P
vnoremap <buffer> èoè yOic()<Esc>P
nnoremap <buffer> èoc :g/^\s*ic(.*)$/d<CR>:g/^\s*from icecream import .*\ninstall()\nic.configureOutput(.*)$/d \| d \| d<CR><C-O>


setlocal fileformat=unix
setlocal comments+=:#
setlocal foldmethod=indent
