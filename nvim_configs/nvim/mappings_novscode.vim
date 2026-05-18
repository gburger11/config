nnoremap <silent> éd /\v[<=>]{7}(<space>\|$)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" Swap cleaning
""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap àw :!rm -r ~/.local/share/nvim/swap/*<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Diffing buffers
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:diffed_buffers=[]
function! DiffText(a, b, diffed_buffers)
    enew
    setlocal buftype=nowrite
    call add(a:diffed_buffers, bufnr('%'))
    call setline(1, split(a:a, "\n"))
    diffthis
    vnew
    setlocal buftype=nowrite
    call add(a:diffed_buffers, bufnr('%'))
    call setline(1, split(a:b, "\n"))
    diffthis
endfunction
function! WipeOutDiffs(diffed_buffers)
    for buffer in a:diffed_buffers
        execute 'bwipeout! '.buffer
    endfor
    let g:diffed_buffers=[]
endfunction
vnoremap <special> èf "fy:call DiffText(@0, @f, g:diffed_buffers)<CR>
nnoremap <special> èF :call WipeOutDiffs(g:diffed_buffers)<CR>

" Show buffer path
" nnoremap èpt :echo @%<CR>  " Useless <C-g> prints details on file !!


" """"""""""""""""""""""""""""""""""""""""""""""""""
" " Autowrapping with par
" """"""""""""""""""""""""""""""""""""""""""""""""""
" " h1 means the first line has a different syntax
" " T8 means that tabs are considered as 8 spaces
" set formatprg=par\ 120T4h0

" set textwidth=120
" " set formatoptions=ronq " r: comment sign after enter in insert / o: comment sign when O or o / q: allow gq formatting comments / n: numbered lists
" augroup TypeDependentSettings
    " au!
    " au BufNewFile,BufRead *.h,*.c,*.cc,*.tpp
        " \ set formatoptions=rnq
" augroup END

" function! s:formatWrap(width)
    " let col=virtcol('.') - 1
    " execute "set formatprg=par\\ " . a:width . "T4p" . col
" endfunction

" function! s:formatCppHeaderWrap(width)
    " " Go to the beginning of the line \keyword
    " execute "normal! ^W"
    " let col_0=virtcol('.') -1
    " "Go to the beginning of the actula text
    " execute "normal! W"
    " let col_1=virtcol('.') - 1
    " let row_0=line('.')
    " " Set formatting with heading width
    " call s:formatWrap(a:width)
    " " Apply the formatting
    " execute "normal! Vgq"
    " " Save last line of modified block (we are automatically placed here after the Vgq command)
    " let row_1=line('.')
    " let row=row_1
    " while (row > row_0)
        " " Remove the \keywords in all except first line.
        " execute "normal! ^W" . (col_1 - col_0) . "r "
        " " Replaces the spaces at the beginning of the line by tabs.
        " execute "normal! ^hv0r\<tab>:'[,']s.\\t\\{2,4}.\\t.g\<CR>k"
        " let row = row - 1
    " endwhile
    " " Replaces the spaces at the beginning of the line by tabs.
    " execute "normal! ^hv0r\<tab>:'[,']s.\\t\\{2,4}.\\t.g\<CR>k"
    " " execute "normal! ^"
    " " let col_start_comment = virtcol('.') - 1
    " " execute "normal! /\\t\<cr>l"
    " " let col_start_text = virtcol('.') - 1
    " " let number_tabs = float2nr(ceil((col_start_text - col_start_comment) / 4))
    " " execute "set formatprg=par\\ " . a:width . "T4p" . col_start_text
    " " execute "normal! $"
    " " if virtcol('.') > a:width
        " " execute "normal! 0" . a:width . "|F "
        " " execute "normal! i\<cr>/\<esc>"
        " " execute "normal! " . number_tabs . "a\<tab>\<esc>"
        " " " execute "normal! Vgq"
        " " echo a:width
    " " endif
" endfunction
" function! s:replaceSpacesByTabs()
    " " Save fist row
    " execute "normal! '["
    " let row_0=line('.')
    " " Go to last row
    " execute "normal! ']"
    " let row=line('.')
    " while (row >= row_0)
        " " Replaces the spaces at the beginning of the line by tabs.
        " execute "normal! ^hv0r\<tab>:'[,']s.\\t\\{2,4}.\\t.g\<CR>k"
        " let row = row - 1
    " endwhile
" endfunction

" " Wrapping for comments (ignore the first commenting sign)
" nnoremap <script> èqq ^W:call <SID>formatWrap(120)<CR>gqq
" vnoremap <script> èqq <Esc>^W:call <SID>formatWrap(120)<CR>gvgq
" " Wrapping with repetition previous columns
" nnoremap <script> èQQ :call <SID>formatWrap(120)<CR>gqq
" vnoremap <script> èQQ <Esc>:call <SID>formatWrap(120)<CR>gvgq
" " Wrapping for comments with tabs (par replaces tabs with 8 spaces)
" nnoremap <script> èqt ^W:call <SID>formatWrap(120)<CR>gqq:'[,']s. \{2,4}.\t.g<CR>
" vnoremap <script> èqt <Esc>^W:call <SID>formatWrap(120)<CR>gvgq:'[,']s. \{2,4}.\t.g<CR>
" " Wrapping with répétion previous columns with tabs
" nnoremap <script> èQT :call <SID>formatWrap(120)<CR>gqq:'[,']s. \{2,4}.\t.g<CR>
" vnoremap <script> èQT <Esc>:call <SID>formatWrap(120)<CR>gvgq:'[,']s. \{2,4}.\t.g<CR>
" " Wrapping with header (first line diffent from others
" " nnoremap <script> èqh :call <SID>formatCppHeaderWrap(120)<CR>:call <SID>replaceSpacesByTabs()<CR>
" nnoremap <script> èqh :call <SID>formatCppHeaderWrap(120)<CR>
" " vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>:call <SID>replaceSpacesByTabs()<CR>
" vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq:call <SID>replaceSpacesByTabs()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Cpp miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""
" to do the couple of curly brackets automatically
inoremap {<CR> {<CR>}<Esc>ko

" function! SwitchSourceHeader()
  " "update!
  " if (expand ("%:e") == "cc")
    " find **/%:t:r.h
  " else
    " find **/%:t:r.cc
  " endif
" endfunction

" nmap ès :call SwitchSourceHeader()<CR>

" Avoid accidental exit from vim.
nmap ZZ ==
