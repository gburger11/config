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
    if a:n_header_word > 0
        execute "normal! " . a:n_header_word . "W"
    endif
    let col_1 = virtcol('.') - 1
    let row_0 = line('.')
    " Set formatting with heading width
    call s:formatWrap(a:width)
    " Apply the formatting
    execute "normal! Vgq"
    " Save last line of modified block (we are automatically placed here after the Vgq command)
    let row_1 = line('.')
    let row = row_1
    if a:n_header_word > 0
        while (row > row_0)
            " Remove the \keywords in all except first line.
            execute "normal! ^"
            if a:is_first_symbol
                execute "normal! W"
            endif
            execute "normal! " . (col_1 - col_0) . "r "
            execute "normal! k"
            let row = row - 1
        endwhile
    endif
endfunction

" " Wrapping for comments (ignore the first commenting sign)
" nnoremap <script> èqq ^W:call <SID>formatWrap(120)<CR>gqq
" vnoremap <script> èqq <Esc>^W:call <SID>formatWrap(120)<CR>gvgq
" " Wrapping with repetition previous columns
" nnoremap <script> èQQ :call <SID>formatWrap(120)<CR>gqq
" vnoremap <script> èQQ <Esc>:call <SID>formatWrap(120)<CR>gvgq
" " Wrapping with header (first line diffent from others
" " nnoremap <script> èqh :call <SID>formatCppHeaderWrap(120)<CR>:call <SID>replaceSpacesByTabs()<CR>
" nnoremap <script> èqh :call <SID>formatCppHeaderWrap(120, 1, 1)<CR>
" nnoremap <script> èq( :call <SID>formatCppHeaderWrap(120, 0, 1)<CR>
" nnoremap <script> èq) :call <SID>formatCppHeaderWrap(120, 0, 2)<CR>
" " vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>:call <SID>replaceSpacesByTabs()<CR>
" " vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq:call <SID>replaceSpacesByTabs()<CR>
" vnoremap <script> èqh ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq
" vnoremap <script> èq( ^E3lW<Esc>:call <SID>formatWrap(120)<CR>gvgq
nnoremap <script> èqc :call <SID>formatCppHeaderWrap(120, 0, 0)<CR>
nnoremap <script> èqt :call <SID>formatCppHeaderWrap(120, 0, 1)<CR>
nnoremap <script> èqs :call <SID>formatCppHeaderWrap(120, 0, 2)<CR>
nnoremap <script> èqhc :call <SID>formatCppHeaderWrap(120, 1, 0)<CR>
nnoremap <script> èqht :call <SID>formatCppHeaderWrap(120, 1, 1)<CR>
nnoremap <script> èqhs :call <SID>formatCppHeaderWrap(120, 1, 2)<CR>

" For visual mapping, do the same, but join all lines in one first.
vnoremap <script> èqc :j<CR>:call <SID>formatCppHeaderWrap(120, 0, 0)<CR>
vnoremap <script> èqt :j<CR>:call <SID>formatCppHeaderWrap(120, 0, 1)<CR>
vnoremap <script> èqs :j<CR>:call <SID>formatCppHeaderWrap(120, 0, 2)<CR>
vnoremap <script> èqhc :j<CR>:call <SID>formatCppHeaderWrap(120, 1, 0)<CR>
vnoremap <script> èqht :j<CR>:call <SID>formatCppHeaderWrap(120, 1, 1)<CR>
vnoremap <script> èqhs :j<CR>:call <SID>formatCppHeaderWrap(120, 1, 2)<CR>


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
    exe 'S/left/XXXtmp_footXXX/ge'
    exe 'S/right/left/ge'
    exe 'S/XXXtmp_footXXX/right/ge'
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
    for i in range(1, 1000)
        if buflisted(i) && getbufvar(i, 'terminal_job_id', 'NO_TERM') !=# 'NO_TERM'
            let is_docker = (getbufline(i, "$")[0][0:1] ==# "D|")  " Ugly way of checking if in Docker. More robust ??
            if is_docker
                call chansend(getbufvar(i, 'terminal_job_id'), [
                            \ "\<C-q>exit",
                            \ "" ])
                sleep 20m
            endif

            let is_dipython = (getbufline(i, "$")[0][0:3] ==# "In [")  " Ugly way of checking if in Docker. More robust ??
            if is_dipython
                call chansend(getbufvar(i, 'terminal_job_id'), [
                        \ "\<C-q>exit",
                        \ "",
                        \ ])
                sleep 200m
            endif

            call chanclose(getbufvar(i, 'terminal_job_id'))
        endif
    endfor
    execute "qa"
endfunction

nnoremap <script> <M-S-Q> :call <SID>kill_all_terminal()<CR>

function! s:switch_env(n_env)
    for i in range(1, 1000)
        if buflisted(i) && getbufvar(i, 'terminal_job_id', 'NO_TERM') !=# 'NO_TERM'
            let is_docker = (getbufline(i, "$")[0][0:1] ==# "D|")  " Ugly way of checking if in Docker. More robust ??
            if is_docker
                call chansend(getbufvar(i, 'terminal_job_id'), [
                        \ "\<C-q>switchEnv ".a:n_env,
                        \ "",
                        \ ])
                sleep 20m
            endif

            let is_dipython = (getbufline(i, "$")[0][0:3] ==# "In [")  " Ugly way of checking if in dipython. More robust ??
            if is_dipython
                call chansend(getbufvar(i, 'terminal_job_id'), [
                        \ "\<C-q>exit",
                        \ "",
                        \ ])
                sleep 200m
            endif

            call chansend(getbufvar(i, 'terminal_job_id'), [
                        \ "\<C-q>switchEnv ".a:n_env,
                        \ "",
                        \ ])
        endif
    endfor
    execute "cd ~/workspaces/".a:n_env."/src/wandercode/"
    echo "Switched to env ".a:n_env
endfunction

function Send_commands(cmd)
    for i in range(1, 1000)
        if buflisted(i) && getbufvar(i, 'terminal_job_id', 'NO_TERM') !=# 'NO_TERM' 
            call chansend(getbufvar(i, 'terminal_job_id'), [
                        \ "\<C-q>".a:cmd,
                        \ "",
                        \ ])
            sleep 20m
        endif
    endfor
endfunction

function Cd(folder)
    call Send_commands("cd ".a:folder)
    execute "cd ".a:folder
endfunction

command -nargs=1 -complete=file CD call Cd(<f-args>)

nnoremap <silent> <script> <M-S-S>c :call <SID>switch_env('c')<CR>
nnoremap <silent> <script> <M-S-S>t :call <SID>switch_env('t')<CR>
nnoremap <silent> <script> <M-S-S>s :call <SID>switch_env('s')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""
" GO TO FILE WITH DOCKER AND LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap gf :let @/=substitute(expand('<cfile>'), '^/src/', '', '') <bar>normal gngf<CR>
nnoremap g<c-f> Bf:lviw"lyf:lviw"cyB:let @/=substitute(expand('<cfile>'), '^/src/', '', '') <bar>normal gngf<CR>:call cursor(<C-R>l, <C-R>c)<CR>
nnoremap g<m-f> B/ line \zs<CR>lviw"lyBB:let @/=substitute(expand('<cfile>'), '^/src/', '', '') <bar>normal gngf<CR>:call cursor(<C-R>l, 0)<CR>
