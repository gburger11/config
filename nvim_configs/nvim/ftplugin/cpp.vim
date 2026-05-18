if exists('g:vscode')
    " do stuff
else
    map <buffer> <C-K> :pyf /usr/share/clang/clang-format-10/clang-format.py<CR>
    imap <buffer> <C-K> <C-O>:pyf /usr/share/clang/clang-format-10/clang-format.py<CR>

    setlocal cindent
    setlocal cino=(0
    setlocal foldmethod=syntax
endif

nnoremap <buffer> èoo ocore::Logger::error() << "DEBUG \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o><S-o> Ocore::Logger::error() << "DEBUG \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>

" nnoremap <buffer> èoè viwyOic()<Esc>P
nnoremap <buffer> èoè viwyocore::Logger::error() << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o>è viwyOcore::Logger::error() << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o><S-è> viwyOcore::Logger::error() << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> èoè yocore::Logger::error() << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> è<S-o>è yOcore::Logger::error() << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> è<S-o><S-è> yOcore::Logger::error() << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> èov viwyocore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o>v viwyOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o><S-v> viwyOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> èov yocore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> è<S-o>v yOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> è<S-o><S-v> yOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> èot viwyocore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa.translation() << "\n" << <Esc>pa.rotation() << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o>t viwyOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa.translation() << "\n" << <Esc>pa.rotation() << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> è<S-o><S-t> viwyOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa.translation() << "\n" << <Esc>pa.rotation() << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> èot yocore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa.translation() << "\n" << <Esc>pa.rotation() << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> è<S-o>t yOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa.translation() << "\n" << <Esc>pa.rotation() << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
vnoremap <buffer> è<S-o><S-t> yOcore::Logger::error() << "DEBUG \| <Esc>pa : \n" << <Esc>pa.translation() << "\n" << <Esc>pa.rotation() << "\n \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__;<Esc>
nnoremap <buffer> èoc :g/^\s*core::Logger::error() << "DEBUG \|/d<CR><C-O>

nnoremap <buffer> èbb ostd::cerr << "DEBUG \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__ << std::endl;<Esc>
nnoremap <buffer> èbè viwyostd::cerr << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__ << std::endl;<Esc>
vnoremap <buffer> èbè yostd::cerr << "DEBUG \| <Esc>pa : " << <Esc>pa << " \| <C-r>=expand("%:t")<CR> : " << __LINE__ << " in " << __func__ << std::endl;<Esc>
nnoremap <buffer> èbc :g/^\s*std::cerr << "DEBUG \|/d<CR><C-O>
nnoremap <buffer> èB ggO<Esc>cc#include <iostream><Esc><C-O>

nnoremap <buffer> èob <cmd>%s/core::Logger::error() \(<< "DEBUG \|.*\);/std::cerr \1 << std::endl;/<cr>
nnoremap <buffer> èbo <cmd>%s/std::cerr \(<< "DEBUG \|.*\) << std::endl;/core::Logger::error() \1;/<cr>
