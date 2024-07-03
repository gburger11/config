" Terminal escape sequence.
tnoremap <Esc> <C-\><C-n>
tnoremap <C-n> <Esc>

" Prevent exiting nvim unintetionally
" cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
" cabbrev Q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'q' : 'Q')<CR>
function! ConfirmQuit(writeFile)
    if (a:writeFile)
        if (expand('%:t')=="")
            echo "Can't save a file with no name."
            return
        endif
        :write
    endif

    if (winnr('$')==1 && tabpagenr('$')==1)
        if (confirm("Do you really want to quit?", "&Yes\n&No", 2)==1)
            :quit
        endif
    else
        :quit
    endif
endfu

function! s:map_all_modes(mapping, target_action)
    for map_command in ['noremap', 'noremap!', 'tnoremap']
        " noremap -> normal, visual, operator_pending
        " noremap! -> insert and command
        " tnoremap -> terminal mode
        execute map_command . ' <silent> ' . a:mapping . ' <C-\><C-n>' . a:target_action
    endfor
endfunction

call s:map_all_modes('<M-q>', '<C-w>c')  " Close current pannel (don't delete buffer)
call s:map_all_modes('<M-S-o>', '<C-w>o')  " Close all pannels except current (don't delete buffers)

" Enter terminal mode if a pressed
vnoremap a <Esc>a

nnoremap à$ ?\(:G\.burger@.*➭\\|D\|.-.\{,5\}:.*\$\)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window and tab management identical to byobu window and panes.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow
set diffopt+=vertical
" movements
call s:map_all_modes('<M-c>', '<C-W>h')  " Move to left panel
call s:map_all_modes('<M-t>', '<C-W>j')  " Move to down panel
call s:map_all_modes('<M-s>', '<C-W>k')  " Move to up panel
call s:map_all_modes('<M-r>', '<C-W>l')  " Move to right panel
call s:map_all_modes('<M-d>', 'gt')      " Move to next tab
call s:map_all_modes('<M-v>', 'gT')      " Move to previous tab

" Split with last buffer
call s:map_all_modes('<M-S-r>', '<cmd>vsplit<cr><cmd>b#<cr>')
call s:map_all_modes('<M-S-c>', '<cmd>vsplit<cr><C-w>h<cmd>b#<cr>')
call s:map_all_modes('<M-S-t>', '<cmd>split<cr><cmd>b#<cr>')
call s:map_all_modes('<M-S-s>', '<cmd>vsplit<cr><C-w>k<cmd>b#<cr>')
" normal splits
call s:map_all_modes('<M-n><M-l>', '<cmd>tabnew<CR>')                " Open new tab with empty file
call s:map_all_modes('<M-n><M-r>', '<cmd>vsplit<CR>:enew<CR>')       " Open new pane on the right with empty file
call s:map_all_modes('<M-n><M-c>', '<cmd>vsplit<CR><C-w>h:enew<CR>') " Open new pane on the left with empty file
call s:map_all_modes('<M-n><M-t>', '<cmd>split<CR>:enew<CR>')        " Open new pane on the bottom with empty file
call s:map_all_modes('<M-n><M-s>', '<cmd>split<CR><C-w>k:enew<CR>')  " Open new pane on the top with empty file
" open terminal
call s:map_all_modes('<M-S-n><M-S-n>', '<cmd>:te<CR>')
call s:map_all_modes('<M-S-n><M-S-l>', '<CR><cmd>te<CR>')
call s:map_all_modes('<M-S-n><M-S-r>', '<cmd>vsplit<CR><cmd>te<CR>')
call s:map_all_modes('<M-S-n><M-S-c>', '<cmd>vsplit<CR><C-w>h<cmd>te<CR>')
call s:map_all_modes('<M-S-n><M-S-t>', '<cmd>split<CR><cmd>te<CR>')
call s:map_all_modes('<M-S-n><M-S-s>', '<cmd>split<CR><C-w>k<cmd>te<CR>')
" scratch
call s:map_all_modes('<M-C-n><M-C-n>', '<cmd>Scratch<CR>')
call s:map_all_modes('<M-C-n><M-C-l>', '<cmd>tabnew<CR><cmd>Scratch<CR>')
call s:map_all_modes('<M-C-n><M-C-r>', '<cmd>vsplit<CR><cmd>Scratch<CR>')
call s:map_all_modes('<M-C-n><M-C-c>', '<cmd>vsplit<CR><C-w>h<cmd>Scratch<CR>')
call s:map_all_modes('<M-C-n><M-C-t>', '<cmd>split<CR><cmd>Scratch<CR>')
call s:map_all_modes('<M-C-n><M-C-s>', '<cmd>split<CR><C-w>k<cmd>Scratch<CR>')
" resizing
call s:map_all_modes('<M-+>', '<C-w>+')
call s:map_all_modes('<M-->', '<C-w>-')
call s:map_all_modes('<M->>', '<C-w>>')
call s:map_all_modes('<M-<>', '<C-w><')

" other operations
call s:map_all_modes('<M-m>', '<cmd>file term:://T-')  " Rename current pane with term name
call s:map_all_modes('<M-x>', '<cmd>BD<CR>')           " Delete current buffer
call s:map_all_modes('<M-S-x>', '<cmd>BD!<CR>')
call s:map_all_modes('<M-w>', '<cmd>BW<CR>')
call s:map_all_modes('<M-S-w>', '<cmd>BW!<CR>')

" Quick change bufferts to terminal buffers
call s:map_all_modes('àt', '<cmd>b1<CR>')
call s:map_all_modes('às', '<cmd>b2<CR>')
call s:map_all_modes('àr', '<cmd>b3<CR>')
call s:map_all_modes('àn', '<cmd>b4<CR>')
call s:map_all_modes('àm', '<cmd>b5<CR>')
call s:map_all_modes('àv', '<cmd>b6<CR>')
call s:map_all_modes('àd', '<cmd>b7<CR>')
call s:map_all_modes('àl', '<cmd>b8<CR>')
call s:map_all_modes('àj', '<cmd>b9<CR>')

" Go to last buffer
call s:map_all_modes('àc', '<cmd>b#<CR>')
