""""""""""""""""""""""""""""""""""""""""""""""""""
" Autowrapping with par
""""""""""""""""""""""""""""""""""""""""""""""""""
" h1 means the first line has a different syntax
" T8 means that tabs are considered as 8 spaces
set formatprg=par\ 120T4h0

set textwidth=120
" set formatoptions=ronq " r: comment sign after enter in insert / o: comment sign when O or o / q: allow gq formatting comments / n: numbered lists
augroup TypeDependentSettings
    au!
    au BufNewFile,BufRead *.h,*.c,*.cc,*.tpp
        \ set formatoptions=rnq
augroup END

function! s:formatWrap(width)
    let col = virtcol('.') - 1
    execute "set formatprg=par\\ " . a:width . "T4p" . col
endfunction

function! s:formatCppHeaderWrap(width, is_first_symbol, n_header_word)
    " Go to the beginning of the line \keyword
    execute "normal! ^"
    if a:is_first_symbol
        execute "normal! W"
    endif
    let col_0 = virtcol('.') - 1
    "Go to the beginning of the actual text
    execute "normal! " . a:n_header_word . "W"
    let col_1 = virtcol('.') - 1
    let row_0 = line('.')
    " Set formatting with heading width
    call s:formatWrap(a:width)
    " Apply the formatting
    execute "normal! Vgq"
    " Save last line of modified block (we are automatically placed here after the Vgq command)
    let row_1 = line('.')
    let row = row_1
    while (row > row_0)
        " Remove the \keywords in all except first line.
        execute "normal! ^"
        if a:is_first_symbol
            execute "normal! W"
        endif
        execute "normal! " . (col_1 - col_0) . "r "
        " Replaces the spaces at the beginning of the line by tabs.
        " execute "normal! ^hv0r\<tab>:'[,']s.\\t\\{2,4}.\\t.g\<CR>"
        execute "normal! k"
        let row = row - 1
    endwhile
    " Replaces the spaces at the beginning of the line by tabs.
    " execute "normal! ^hv0r\<tab>:'[,']s.\\t\\{2,4}.\\t.g\<CR>k"

    " execute "normal! ^"
    " let col_start_comment = virtcol('.') - 1
    " execute "normal! /\\t\<cr>l"
    " let col_start_text = virtcol('.') - 1
    " let number_tabs = float2nr(ceil((col_start_text - col_start_comment) / 4))
    " execute "set formatprg=par\\ " . a:width . "T4p" . col_start_text
    " execute "normal! $"
    " if virtcol('.') > a:width
        " execute "normal! 0" . a:width . "|F "
        " execute "normal! i\<cr>/\<esc>"
        " execute "normal! " . number_tabs . "a\<tab>\<esc>"
        " " execute "normal! Vgq"
        " echo a:width
    " endif
endfunction
function! s:replaceSpacesByTabs()
    " Save fist row
    execute "normal! '["
    let row_0=line('.')
    " Go to last row
    execute "normal! ']"
    let row=line('.')
    while (row >= row_0)
        " Replaces the spaces at the beginning of the line by tabs.
        execute "normal! ^hv0r\<tab>:'[,']s.\\t\\{2,4}.\\t.g\<CR>k"
        let row = row - 1
    endwhile
endfunction

" Wrapping for comments (ignore the first commenting sign)
nnoremap <script> èqq ^W:call <SID>formatWrap(120)<CR>gqq
vnoremap <script> èqq <Esc>^W:call <SID>formatWrap(120)<CR>gvgq
" Wrapping with repetition previous columns
nnoremap <script> èQQ :call <SID>formatWrap(120)<CR>gqq
vnoremap <script> èQQ <Esc>:call <SID>formatWrap(120)<CR>gvgq
" Wrapping for comments with tabs (par replaces tabs with 8 spaces)
nnoremap <script> èqt ^W:call <SID>formatWrap(120)<CR>gqq:'[,']s. \{2,4}.\t.g<CR>
vnoremap <script> èqt <Esc>^W:call <SID>formatWrap(120)<CR>gvgq:'[,']s. \{2,4}.\t.g<CR>
" Wrapping with répétion previous columns with tabs
nnoremap <script> èQT :call <SID>formatWrap(120)<CR>gqq:'[,']s. \{2,4}.\t.g<CR>
vnoremap <script> èQT <Esc>:call <SID>formatWrap(120)<CR>gvgq:'[,']s. \{2,4}.\t.g<CR>
" Wrapping with header (first line diffent from others
" nnoremap <script> èqh :call <SID>formatCppHeaderWrap(120)<CR>:call <SID>replaceSpacesByTabs()<CR>
nnoremap <script> èqh :call <SID>formatCppHeaderWrap(120, 1, 1)<CR>
nnoremap <script> èq( :call <SID>formatCppHeaderWrap(120, 0, 1)<CR>
nnoremap <script> èq) :call <SID>formatCppHeaderWrap(120, 0, 2)<CR>
" vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>:call <SID>replaceSpacesByTabs()<CR>
" vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq:call <SID>replaceSpacesByTabs()<CR>
vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq
vnoremap <script> èq( ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq


""""""""""""""""""""""""""""""""""""""""""""""""""
" Alignment with spaces utilities
""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:replaceFollowingTabsBySpaces(width_tabs)
    let n_tabs = col('.') - 1
    let s = 0
    let tab_replacement = ""
    while s < a:width_tabs
        let tab_replacement = tab_replacement . " "
        let s += 1
    endwhile
    execute "s.\\t." . tab_replacement . ".g"
    execute "normal! 0" . (n_tabs * a:width_tabs) . "x" . n_tabs ."i\<tab>\<esc>l"
endfunction

function! s:alignFunctionsWithSpaces(width_tabs)
    execute "?("
    let row_0 = line('.')
    let col_beg_func_name = col('.') - 1
    execute "normal! f("
    let col_open_par = col('.') - 1
    execute "/)"
    let row_1 = line('.')
    let cur_row = row_0 + 1
    execute "?("
    execute "normal! j"
    while cur_row <= row_1
        execute "normal! 0" . col_beg_func_name . "ld^" . (col_open_par - col_beg_func_name + 1) ."i \<esc>j"
        let cur_row += 1
    endwhile
    execute "normal! k"
endfunction

" nnoremap <script> è<TAB> :call <SID>replaceFollowingTabsBySpaces(4)<CR>
nnoremap <script> è<TAB> :call <SID>alignFunctionsWithSpaces(4)<CR>

"""""""""""""
" SWAP WORDS
"""""""""""""
function! Mirror(dict)
    for [key, value] in items(a:dict)
        let a:dict[value] = key
    endfor
    return a:dict
endfunction

function! S(number)
    return submatch(a:number)
endfunction

function! SwapWords(dict, ...)
    let words = keys(a:dict) + values(a:dict)
    let words = map(words, 'escape(v:val, "|")')
    if(a:0 == 1)
        let delimiter = a:1
    else
        let delimiter = '/'
    endif
    let pattern = '\v(' . join(words, '|') . ')'
    exe 's' . delimiter . pattern . delimiter
        \ . '\=' . string(Mirror(a:dict)) . '[S(0)]'
        \ . delimiter . 'ge'
endfunction

function! SwapLR()
    exe 'S/left/foo/ge'
    exe 'S/right/left/ge'
    exe 'S/foo/right/ge'
endfunction

vnoremap <script> gs :call SwapLR()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEEP CURSOR POSITION WHEN SWITCHING BUFFERS
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
    " autocmd BufEnter * silent! normal! g`"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" KILL TERM WHEN EXITING
""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:kill_all_terminal()
    for i in [4, 5, 6, 7, 8, 9, 10, 11, 12]
        try
            call chansend(i, ["exit", "", ""])
        catch /^Vim\%((\a\+)\)\=:E900/
        endtry
    endfor
    execute "q"
endfunction

nnoremap <script> <M-S-Q> :call <SID>kill_all_terminal()<CR>
