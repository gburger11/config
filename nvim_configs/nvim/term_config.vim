" Terminal escape sequence.
tnoremap <Esc> <C-\><C-n>
tnoremap <C-n> <Esc>


function! s:map_all_modes(mapping, target_action)
    for map_command in ['noremap', 'noremap!', 'tnoremap']
        " noremap -> normal, visual, operator_pending
        " noremap! -> insert and command
        " tnoremap -> terminal mode
        execute map_command . ' <silent> ' . a:mapping . ' <C-\><C-n>' . a:target_action
    endfor
endfunction

function! ClearTerminal()
  set scrollback=1
  let &g:scrollback=1
  echo &scrollback
  call feedkeys("\i")
  call feedkeys("clear\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\i")
  sleep 100m
  let &scrollback=10000
endfunction
call s:map_all_modes('<M-l>', '<cmd>call ClearTerminal()<cr>')  "

" Enter terminal mode if a pressed
vnoremap a <Esc>a

nnoremap à$ ?\(:G\.burger@.*➭\\|D\|.-.\{,5\}:.*\$\)<CR>

" Quick change bufferts to terminal buffers
let id_l = 1
for l in ["t", "s", "r", "n", "m", "v", "d", "l", "j"]
    execute "let g:term_id_".l."=\"".id_l."\""
    let id_l += 1
    " call s:map_all_modes( "à<S-".l.">", "<cmd>let g:term_id_" . l . "=bufnr()<CR>")
    call s:map_all_modes( "à".l, "<cmd>execute \"buffer\" g:term_id_" . l . "<CR>")
    call s:map_all_modes( "à<S-".l.">", "<cmd>execute \"buffer\" g:term_id_" . l . "<CR><cmd>BD!<CR><cmd>terminal<CR><cmd>let g:term_id_" . l . "=bufnr()<CR>")
    call s:map_all_modes( "à<M-".l.">", "<cmd>terminal<CR><cmd>let g:term_id_" . l . "=bufnr()<CR>")
endfor

function! s:print_term_mappings()
    let res = ""
    let id_l = 1
    for l in ["t", "s", "r", "n", "m", "v", "d", "l", "j"]
        execute "let res .= \"" . id_l . ":\" . g:term_id_" . l .".\" - \""
        let id_l += 1
    endfor
    echo res
endfunction
map <script> à. <cmd>call <SID>print_term_mappings()<CR>

" call s:map_all_modes('àt', '<cmd>b1<CR>')
" call s:map_all_modes('às', '<cmd>b2<CR>')
" call s:map_all_modes('àr', '<cmd>b3<CR>')
" call s:map_all_modes('àn', '<cmd>b4<CR>')
" call s:map_all_modes('àm', '<cmd>b5<CR>')
" call s:map_all_modes('àv', '<cmd>b6<CR>')
" call s:map_all_modes('àd', '<cmd>b7<CR>')
" call s:map_all_modes('àl', '<cmd>b8<CR>')
" call s:map_all_modes('àj', '<cmd>b9<CR>')