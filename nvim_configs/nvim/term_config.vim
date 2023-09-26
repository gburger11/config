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

cnoremap <silent> q<CR>  :call ConfirmQuit(0)<CR>
nnoremap <M-q> <C-w>c
nnoremap <M-S-o> <C-w>o
tnoremap <M-q> <C-\><C-n><C-w>c
tnoremap <M-S-o> <C-\><C-n><C-w>o
inoremap <M-q> <Esc><C-w>c
inoremap <M-S-o> <Esc><C-w>o
xnoremap <M-q> <Esc><C-w>c
xnoremap <M-S-o> <Esc><C-w>o
" cnoremap <silent x<CR>  :call ConfirmQuit(1)<CR>

" Enter in insert mode terminal
" augroup TerminalInsert
    " au!
    " autocmd BufWinEnter,WinEnter term://* startinsert
    " autocmd BufLeave term://* stopinsert
" augroup END

" Enter terminal mode if a pressed
vnoremap a <Esc>a

nnoremap à$ ?\(-G@PC-Burger.*➭\\|-builder:.*\$\)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window and tab management identical to byobu window and panes.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow
set diffopt+=vertical
" movements
nnoremap <M-c> <C-W>h
nnoremap <M-t> <C-W>j
nnoremap <M-s> <C-W>k
nnoremap <M-r> <C-W>l
nnoremap <M-d> gt
nnoremap <M-v> gT
tnoremap <M-c> <C-\><C-n><C-W>h
tnoremap <M-t> <C-\><C-n><C-W>j
tnoremap <M-s> <C-\><C-n><C-W>k
tnoremap <M-r> <C-\><C-n><C-W>l
tnoremap <M-d> <C-\><C-n>gt
tnoremap <M-v> <C-\><C-n>gT
inoremap <M-c> <Esc><C-W>h
inoremap <M-t> <Esc><C-W>j
inoremap <M-s> <Esc><C-W>k
inoremap <M-r> <Esc><C-W>l
inoremap <M-d> <Esc>gt
inoremap <M-v> <Esc>gT
xnoremap <M-c> <Esc><C-W>h
xnoremap <M-t> <Esc><C-W>j
xnoremap <M-s> <Esc><C-W>k
xnoremap <M-r> <Esc><C-W>l
xnoremap <M-d> <Esc>gt
xnoremap <M-v> <Esc>gT
" normal splits
nnoremap <silent> <M-n><M-l>  :tabnew<CR>
nnoremap <silent> <M-n><M-r>  :vsplit<CR>:enew<CR>
nnoremap <silent> <M-n><M-c>  :vsplit<CR><C-w>h:enew<CR>
nnoremap <silent> <M-n><M-t>  :split<CR>:enew<CR>
nnoremap <silent> <M-n><M-s>  :split<CR><C-w>k:enew<CR>
tnoremap <silent> <M-n><M-l>  <C-\><C-n>:tabnew<CR>
tnoremap <silent> <M-n><M-r>  <C-\><C-n>:vsplit<CR>:enew<CR>
tnoremap <silent> <M-n><M-c>  <C-\><C-n>:vsplit<CR><C-w>h:enew<CR>
tnoremap <silent> <M-n><M-t>  <C-\><C-n>:split<CR>:enew<CR>
tnoremap <silent> <M-n><M-s>  <C-\><C-n>:split<CR><C-w>k:enew<CR>
inoremap <silent> <M-n><M-l>  <Esc>:tabnew<CR>
inoremap <silent> <M-n><M-r>  <Esc>:vsplit<CR>:enew<CR>
inoremap <silent> <M-n><M-c>  <Esc>:vsplit<CR><C-w>h:enew<CR>
inoremap <silent> <M-n><M-t>  <Esc>:split<CR>:enew<CR>
inoremap <silent> <M-n><M-s>  <Esc>:split<CR><C-w>k:enew<CR>
xnoremap <silent> <M-n><M-l>  <Esc>:tabnew<CR>
xnoremap <silent> <M-n><M-r>  <Esc>:vsplit<CR>:enew<CR>
xnoremap <silent> <M-n><M-c>  <Esc>:vsplit<CR><C-w>h:enew<CR>
xnoremap <silent> <M-n><M-t>  <Esc>:split<CR>:enew<CR>
xnoremap <silent> <M-n><M-s>  <Esc>:split<CR><C-w>k:enew<CR>
" open terminal
nnoremap <silent> <M-S-n><M-S-n>  :te<CR>
nnoremap <silent> <M-S-n><M-S-l>  :tabnew<CR>:te<CR>
nnoremap <silent> <M-S-n><M-S-r>  :vsplit<CR>:te<CR>
nnoremap <silent> <M-S-n><M-S-c>  :vsplit<CR><C-w>h:te<CR>
nnoremap <silent> <M-S-n><M-S-t>  :split<CR>:te<CR>
nnoremap <silent> <M-S-n><M-S-s>  :split<CR><C-w>k:te<CR>
tnoremap <silent> <M-S-n><M-S-n>  <C-\><C-n>:te<CR>
tnoremap <silent> <M-S-n><M-S-l>  <C-\><C-n>:tabnew<CR>:te<CR>
tnoremap <silent> <M-S-n><M-S-r>  <C-\><C-n>:vsplit<CR>:te<CR>
tnoremap <silent> <M-S-n><M-S-c>  <C-\><C-n>:vsplit<CR><C-w>h:te<CR>
tnoremap <silent> <M-S-n><M-S-t>  <C-\><C-n>:split<CR>:te<CR>
tnoremap <silent> <M-S-n><M-S-s>  <C-\><C-n>:split<CR><C-w>k:te<CR>
inoremap <silent> <M-S-n><M-S-n>  <Esc>:te<CR>
inoremap <silent> <M-S-n><M-S-l>  <Esc>:tabnew<CR>:te<CR>
inoremap <silent> <M-S-n><M-S-r>  <Esc>:vsplit<CR>:te<CR>
inoremap <silent> <M-S-n><M-S-c>  <Esc>:vsplit<CR><C-w>h:te<CR>
inoremap <silent> <M-S-n><M-S-t>  <Esc>:split<CR>:te<CR>
inoremap <silent> <M-S-n><M-S-s>  <Esc>:split<CR><C-w>k:te<CR>
xnoremap <silent> <M-S-n><M-S-n>  <Esc>:te<CR>
xnoremap <silent> <M-S-n><M-S-l>  <Esc>:tabnew<CR>:te<CR>
xnoremap <silent> <M-S-n><M-S-r>  <Esc>:vsplit<CR>:te<CR>
xnoremap <silent> <M-S-n><M-S-c>  <Esc>:vsplit<CR><C-w>h:te<CR>
xnoremap <silent> <M-S-n><M-S-t>  <Esc>:split<CR>:te<CR>
xnoremap <silent> <M-S-n><M-S-s>  <Esc>:split<CR><C-w>k:te<CR>
" scratch
nnoremap <silent> <M-C-n><M-C-n>  :Scratch<CR>
nnoremap <silent> <M-C-n><M-C-l>  :tabnew<CR>:Scratch<CR>
nnoremap <silent> <M-C-n><M-C-r>  :vsplit<CR>:Scratch<CR>
nnoremap <silent> <M-C-n><M-C-c>  :vsplit<CR><C-w>h:Scratch<CR>
nnoremap <silent> <M-C-n><M-C-t>  :split<CR>:Scratch<CR>
nnoremap <silent> <M-C-n><M-C-s>  :split<CR><C-w>k:Scratch<CR>
tnoremap <silent> <M-C-n><M-C-n>  <C-\><C-n>:Scratch<CR>
tnoremap <silent> <M-C-n><M-C-l>  <C-\><C-n>:tabnew<CR>:Scratch<CR>
tnoremap <silent> <M-C-n><M-C-r>  <C-\><C-n>:vsplit<CR>:Scratch<CR>
tnoremap <silent> <M-C-n><M-C-c>  <C-\><C-n>:vsplit<CR><C-w>h:Scratch<CR>
tnoremap <silent> <M-C-n><M-C-t>  <C-\><C-n>:split<CR>:Scratch<CR>
tnoremap <silent> <M-C-n><M-C-s>  <C-\><C-n>:split<CR><C-w>k:Scratch<CR>
inoremap <silent> <M-C-n><M-C-n>  <Esc>:Scratch<CR>
inoremap <silent> <M-C-n><M-C-l>  <Esc>:tabnew<CR>:Scratch<CR>
inoremap <silent> <M-C-n><M-C-r>  <Esc>:vsplit<CR>:Scratch<CR>
inoremap <silent> <M-C-n><M-C-c>  <Esc>:vsplit<CR><C-w>h:Scratch<CR>
inoremap <silent> <M-C-n><M-C-t>  <Esc>:split<CR>:Scratch<CR>
inoremap <silent> <M-C-n><M-C-s>  <Esc>:split<CR><C-w>k:Scratch<CR>
xnoremap <silent> <M-C-n><M-C-n>  <Esc>:Scratch<CR>
xnoremap <silent> <M-C-n><M-C-l>  <Esc>:tabnew<CR>:Scratch<CR>
xnoremap <silent> <M-C-n><M-C-r>  <Esc>:vsplit<CR>:Scratch<CR>
xnoremap <silent> <M-C-n><M-C-c>  <Esc>:vsplit<CR><C-w>h:Scratch<CR>
xnoremap <silent> <M-C-n><M-C-t>  <Esc>:split<CR>:Scratch<CR>
xnoremap <silent> <M-C-n><M-C-s>  <Esc>:split<CR><C-w>k:Scratch<CR>
" resizing
nnoremap <silent> <M-+> <C-w>+
inoremap <silent> <M-+> <Esc><C-w>+
tnoremap <silent> <M-+> <C-\><C-n><C-w>+
xnoremap <silent> <M-+> <Esc><C-w>+
nnoremap <silent> <M--> <C-w>-
inoremap <silent> <M--> <Esc><C-w>-
tnoremap <silent> <M--> <C-\><C-n><C-w>-t
xnoremap <silent> <M--> <Esc><C-w>-
nnoremap <silent> <M->> <C-w>>
inoremap <silent> <M->> <Esc><C-w>>
tnoremap <silent> <M->> <C-\><C-n><C-w>>
xnoremap <silent> <M->> <Esc><C-w>>
nnoremap <silent> <M-<> <C-w><
inoremap <silent> <M-<> <Esc><C-w><
tnoremap <silent> <M-<> <C-\><C-n><C-w><
xnoremap <silent> <M-<> <Esc><C-w><
" other operations
nnoremap <silent> <M-l> :MaximizerToggle<CR>
inoremap <silent> <M-l> <Esc>:MaximizerToggle<CR>i
tnoremap <silent> <M-l> <C-\><C-n>:MaximizerToggle<CR>A
xnoremap <silent> <M-l> <Esc>:MaximizerToggle<CR>
nnoremap <M-m> :file term:://T-
tnoremap <M-m> <C-\><C-n>:file term:://T-
nnoremap <silent> <M-x> :BD<CR>
inoremap <silent> <M-x> <Esc>:BD<CR>
xnoremap <silent> <M-x> <Esc>:BD<CR>
tnoremap <silent> <M-x> <C-\><C-n>:BD<CR>
nnoremap <silent> <M-S-x> :BD!<CR>
inoremap <silent> <M-S-x> <Esc>:BD!<CR>
xnoremap <silent> <M-S-x> <Esc>:BD!<CR>
tnoremap <silent> <M-S-x> <C-\><C-n>:BD!<CR>
nnoremap <silent> <M-w> :BW<CR>
inoremap <silent> <M-w> <Esc>:BW<CR>
xnoremap <silent> <M-w> <Esc>:BW<CR>
tnoremap <silent> <M-w> <C-\><C-n>:BW<CR>
nnoremap <silent> <M-S-w> :BW!<CR>
inoremap <silent> <M-S-w> <Esc>:BW!<CR>
xnoremap <silent> <M-S-w> <Esc>:BW!<CR>
tnoremap <silent> <M-S-w> <C-\><C-n>:BW!<CR>

" nnoremap <silent> <M-q> :BB<CR>
" inoremap <silent> <M-q> <Esc>:BB<CR>
" xnoremap <silent> <M-q> <Esc>:BB<CR>
" tnoremap <silent> <M-q> <C-\><C-n>:BB<CR>
" nnoremap <silent> <M-g> :BF<CR>
" inoremap <silent> <M-g> <Esc>:BF<CR>
" xnoremap <silent> <M-g> <Esc>:BF<CR>
" tnoremap <silent> <M-g> <C-\><C-n>:BF<CR>

nnoremap <silent> àb :b#<CR>
tnoremap <silent> àb <C-\><C-n>:b#<CR>

nnoremap <silent> àt :b1<CR>
tnoremap <silent> àt <C-\><C-n>:b1<CR>
nnoremap <silent> às :b2<CR>
tnoremap <silent> às <C-\><C-n>:b2<CR>
nnoremap <silent> àr :b3<CR>
tnoremap <silent> àr <C-\><C-n>:b3<CR>
nnoremap <silent> àn :b4<CR>
tnoremap <silent> àn <C-\><C-n>:b4<CR>
nnoremap <silent> àm :b5<CR>
tnoremap <silent> àm <C-\><C-n>:b5<CR>
nnoremap <silent> àv :b6<CR>
tnoremap <silent> àv <C-\><C-n>:b6<CR>
nnoremap <silent> àd :b7<CR>
tnoremap <silent> àd <C-\><C-n>:b7<CR>
nnoremap <silent> àl :b8<CR>
tnoremap <silent> àl <C-\><C-n>:b8<CR>
nnoremap <silent> àj :b9<CR>
tnoremap <silent> àj <C-\><C-n>:b9<CR>

nnoremap <silent> àc :b#<CR>
tnoremap <silent> àc <C-\><C-n>:b#<CR>
