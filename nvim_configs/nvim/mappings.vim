""""""""""""""""""""""""""""""""""""""""""""""""""
" Deleting, copying and pasting
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap d "_d
nnoremap dd "_dd
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap èd d
nnoremap èdd dd
vnoremap èd d
nnoremap èD D
vnoremap èD D
noremap l "_c
noremap L "_C
noremap ll "_cc
noremap èl c
noremap èL C
noremap èll cc
nnoremap x "_x
nnoremap èx x
nnoremap dl "_cc<ESC>

nnoremap Y y$

" noremap <silent> èpp :set paste<CR>
" noremap <silent> èpn :set nopaste<CR>
" noremap èP :tabe %<CR><C-\><C-n>:setlocal signcolumn=no<CR>:setlocal nonumber<CR>:setlocal norelativenumber<CR>:setlocal lcs=tab:\ \ <CR>:IndentLinesToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo and Redo
""""""""""""""""""""""""""""""""""""""""""""""""""
noremap U <C-R>
noremap ù U

""""""""""""""""""""""""""""""""""""""""""""""""""
" Movements
""""""""""""""""""""""""""""""""""""""""""""""""""
noremap ê ge
noremap Ê gE

" easy motions with wrappings
noremap t gj
noremap <Down> gj
noremap s gk
noremap <Up> gk
noremap 0 g0
noremap $ g$
noremap T j
noremap S k
noremap g0 0
noremap g$ $

" When saving, `[ and `] are forgotten, so we cannot select pasted text with auto-save
" In addition, for visual, you mustn't yank text
vnoremap p "_dP`]mq`[mp
nnoremap p p`]mq`[mp
nnoremap <expr> èp '`p' . getregtype()[0] . '`q'

""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap » >gv
vnoremap » >gv
vnoremap « <gv



""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy path
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <c-g><c-g> <cmd>let @+=expand("%")<CR><cmd>echo @+<CR>
nnoremap <c-g>f <cmd>let @+=expand("%:p")<CR><cmd>echo @+<CR>
nnoremap <c-g>n <cmd>let @+=expand("%:t")<CR><cmd>echo @+<CR>
nnoremap <c-g>h <cmd>let @+=expand("%:h")<CR><cmd>echo @+<CR>