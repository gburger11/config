" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugins')

" Plug 'easymotion/vim-easymotion'
" Plug 'folke/flash.nvim'

Plug 'AndrewRadev/switch.vim'  " Switch between true/false, left/right...
Plug 'vim-scripts/camelcasemotion'

Plug 'haya14busa/is.vim'  " IncSearch -> color search only when searching
Plug 'haya14busa/vim-asterisk'  " Does the same for * and # searches

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" " nnoremap éé <Plug>(easymotion-bd-f)
" nnoremap éé <cmd>lua require("flash").jump()<CR>
" vnoremap é <cmd>lua require("flash").jump()<CR>
" onoremap é <cmd>lua require("flash").remote()<CR>
" nnoremap é/ <cmd>lua require("flash").toggle()<CR>

nnoremap èc <Plug>VSCodeCommentaryLine
vnoremap èc <Plug>VSCodeCommentary


nnoremap àq <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap àh viw<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
vnoremap àh <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
nnoremap àg <Cmd>call VSCodeNotify('outline.focus')<CR>
nnoremap : <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>

map <C-s> <C-w>+
map <C-t> <C-w>-
map <C-r> <C-w>>
map <C-c> <C-w><
nnoremap <M-S-c> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <M-S-t> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <M-S-s> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <M-S-r> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nnoremap gh< <cmd>

" nnoremap <M-h> <cmd>call VSCodeNotify("lazygit-vscode.toggle")<CR>

" nnoremap àà <cmd>b#<CR>
" nnoremap àc <cmd>call VSCodeNotify('openIntegratedTerminal')<cr>
" nnoremap àt <cmd>call VSCodeNotify('workbench.action.openEditorAtIndex1')<cr>

" Copy to outside programs
" for copy with ^C
set clipboard+=unnamedplus
" for copy with middle mouse button
set clipboard+=unnamed

" Ignore case for searches
set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:case_switch_custom_definitions =
            \ [
            \   {
            \     '\<\(\l\)\(\l\+\(\u\l\+\)\+\)\>': '\=toupper(submatch(1)) . submatch(2)',
            \     '\<\(\u\l\+\)\(\u\l\+\)\+\>': "\\=tolower(substitute(submatch(0), '\\(\\l\\)\\(\\u\\)', '\\1_\\2', 'g'))",
            \     '\<\(\l\+\)\(_\l\+\)\+\>': '\U\0',
            \     '\<\(\u\+\)\(_\u\+\)\+\>': "\\=tolower(substitute(submatch(0), '_', '-', 'g'))",
            \     '\<\(\l\+\)\(-\l\+\)\+\>': "\\=substitute(submatch(0), '-\\(\\l\\)', '\\u\\1', 'g')",
            \   }
            \ ]
let g:switch_custom_definitions = [
            \   {
            \     '\CRight': 'Left',
            \     '\CLeft' : 'Right',
            \     '\Cright': 'left',
            \     '\Cleft' : 'right',
            \     '\CRIGHT': 'LEFT',
            \     '\CLEFT' : 'RIGHT',
            \     '\Cmin'  : 'max',
            \     '\CMin'  : 'Max',
            \     '\CMIN'  : 'MAX',
            \     '\CUpper': 'Lower',
            \     '\Cupper': 'lower',
            \     '\CUPPER': 'LOWER',
            \     '\CLower': 'Upper',
            \     '\Clower': 'upper',
            \     '\CLOWER': 'UPPER',
            \     '\CFLYING': 'FLAT',
            \     '\CFLAT': 'FLYING',
            \     '\CTop': 'Bottom',
            \     '\Ctop': 'bottom',
            \     '\CBottom': 'Top',
            \     '\Cbottom': 'top',
            \   }
            \]

""""""""""""""""""""""""""""""""""""""""""""""""""
" Camel case and undercore motion and text objects
""""""""""""""""""""""""""""""""""""""""""""""""""
map <nowait> <space>w <Plug>CamelCaseMotion_w
map <nowait> <space>b <Plug>CamelCaseMotion_b
map <nowait> <space>e <Plug>CamelCaseMotion_e

omap i<space>w <Plug>CamelCaseMotion_iw
xmap i<space>w <Plug>CamelCaseMotion_iw
omap i<space>b <Plug>CamelCaseMotion_ib
xmap i<space>b <Plug>CamelCaseMotion_ib
omap i<space>e <Plug>CamelCaseMotion_ie
xmap i<space>e <Plug>CamelCaseMotion_ie

""""""""""""""""""""""""""""
" asterisk
""""""""""""""""""""""""""""

map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

let g:asterisk#keeppos = 1