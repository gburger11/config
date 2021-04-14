map <buffer> <C-K> :pyf /usr/share/clang/clang-format-10/clang-format.py<CR>
imap <buffer> <C-K> <C-O>:pyf /usr/share/clang/clang-format-10/clang-format.py<CR>

nnoremap <buffer> èoo ocore::Logger::error() << "DEBUG \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>

setlocal cindent
setlocal cino=(0
setlocal foldmethod=syntax
