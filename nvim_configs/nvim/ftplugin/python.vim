if exists('g:vscode')
    " do stuff
else
    nnoremap <buffer> <C-K> :Isort --profile black<CR>:Black<CR>

    setlocal fileformat=unix
    setlocal comments+=:#
    setlocal foldmethod=indent
endif

" Do things for python icecream
nnoremap <buffer> èO ggO<Esc>ccfrom icecream import ic, install<CR>install()<CR>ic.configureOutput(includeContext=True)<Esc><C-O>
nnoremap <buffer> èoo oic()<Esc>
nnoremap <buffer> èoè viwyoic()<Esc>P
nnoremap <buffer> èoÈ viwyOic()<Esc>P
vnoremap <buffer> èoè yoic()<Esc>P
vnoremap <buffer> èoÈ yOic()<Esc>P
nnoremap <buffer> èoc :g/^\s*ic(.*)$/d<CR>:g/^\s*from icecream import .*\ninstall()\nic.configureOutput(.*)$/d \| d \| d<CR><C-O>
