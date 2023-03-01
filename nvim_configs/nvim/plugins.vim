" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugins')

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-smooth-scroll'
Plug 'vim-scripts/camelcasemotion'
Plug 'majutsushi/tagbar'
Plug 'rbong/vim-vertical'  " Motion block by block (mapped to <C-t> and <C-s>)
Plug 'tpope/vim-unimpaired'
Plug 'Pocco81/auto-save.nvim'
" Colors
Plug 'morhetz/gruvbox'
Plug 'blueyed/vim-diminactive'
Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'luochen1990/rainbow'
Plug 'itchyny/lightline.vim'  " colorized bottom bar
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
" Help syntax
" Plug 'wookayin/vim-autoimport'
Plug 'gburger11/vim-autoimport', {'tag': 'custom_db'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }  " tag 4.1 is necessary because 5.0 is compatible with nvim 0.3+ only, and default in ubuntu 18.04 is nvim 0.2.2
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdcommenter'
Plug 'neomake/neomake'
Plug 'Vimjas/vim-python-pep8-indent'  " Necessary for python indentation
Plug 'psf/black', { 'tag': '22.6.0' }  " TODO 30/08/2022 : stable = 21.9b0 raises `got int, expected bool`. Go back to stable when fixed
Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/indentLine'  " displays indentation levels with spaces (with ¦)
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'  " Allow case sensitive replacement with `:Subvert/.../.../`
Plug 'tell-k/vim-autopep8'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'udalov/kotlin-vim'
" Help navigation
" Plug 'wellle/context.vim'  " Awesome, but slow when tested in 02/2023
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'cloudhead/neovim-fuzzy'
Plug 'guibur/bufexplorer'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-scripts/scratch.vim'
Plug 'declancm/maximize.nvim'
Plug 'tpope/vim-fugitive'  " Easy support for git in vim
Plug 'airblade/vim-gitgutter'  " Show git change in the margin + quick preview or reset
Plug 'kdheepak/lazygit.nvim'
Plug 'kshenoy/vim-signature'  " Show marks in the margin
Plug 'scrooloose/nerdtree'
Plug 'guibur/CurtineIncSw.vim'  " Swap from source file to header file
Plug 'brooth/far.vim'
Plug 'haya14busa/incsearch.vim'
" Language help
" Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' } " Works awesome, but super slow
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'arakashic/chromatica.nvim' " Strange coloring. Maybe need personalization…
Plug 'tyru/open-browser.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'craigemery/vim-autotag'
Plug 'bergercookie/vim-debugstring'
" Terminal plugins
Plug 'brettanomyces/nvim-editcommand'

" Specific visualizers
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'

" Sudo write and read
Plug 'lambdalisue/suda.vim'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:jedi#auto_initialization = 0
let g:jedi#goto_command = 'èo'
""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste'],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified'],
    \             [ 'filetype' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'cwd', 'tmuxname' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'cwd': 'GetShortCwd',
    \   'tmuxname': 'GetTmuxSessionName'
    \ }
\}
function! GetTmuxSessionName()
    return systemlist("tmux display-message -p \"#W\"")[0]
endfunction
function! GetShortCwd()
    return substitute(expand(getcwd()), $HOME, "~", "")
endfunction


""""""""""""""""""""""""""
" Autoimport (Python)
"""""""""""""""""""""""""

nmap <silent> èj :ImportSymbol<CR>:Isort<CR>
imap <silent> èj <Esc>:ImportSymbol<CR>:Isort<CR>a
nmap <silent> è<S-J> :ImportSymbol<CR>
imap <silent> è<S-J> <Esc>:ImportSymbol<CR>a

let g:autoimport#python#db_import_as = {
            \ 'typing': 'tp',
            \ 'multiprocessing': 'mp',
            \ 'nevergrad': 'ng'
            \ }

" let g:autoimport#python#db_import = {
            " \ 'tiger': v:null,
            " \ 'pinocchio': ['Quaternion', 'SE3']
            " \ }

""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy-motion
""""""""""""""""""""""""""""""""""""""""""""""""""

map é <Plug>(easymotion-prefix)
map éé <Plug>(easymotion-bd-f)
map éw <Plug>(easymotion-bd-w)
map ée <Plug>(easymotion-bd-e)
map én <Plug>(easymotion-vim-n)
map éN <Plug>(easymotion-vim-N)
map é/ <Plug>(easymotion-sn)

" map éW <Plug>(easymotion-W)
" map éàe <Plug>(easymotion-ge)
" map éàE <Plug>(easymotion-gE)
" nmap ét <Plug>(easymotion-j)
" nmap és <Plug>(easymotion-w)
" nmap ér <Plug>(easymotion-sn)
" nmap éy <Plug>(easymotion-bd-t)
" nmap éx <Plug>(easymotion-bd-n)
" nmap é* <Plug>(easymotion-next)
" nmap é# <Plug>(easymotion-prev)
" nmap én <Plug>(easymotion-bd-n)
"
map étt <Plug>(easymotion-sol-j)
map été <Plug>(easymotion-eol-j)
map éss <Plug>(easymotion-sol-k)
map ésé <Plug>(easymotion-eol-k)
nmap é. <Plug>(easymotion-repeat)

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


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
        \   }
        \]
nnoremap gc :call switch#Switch({'definitions': g:case_switch_custom_definitions})<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Chromatica
""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:chromatica#libclang_path='/usr/lib/llvm-3.9/lib/'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab>
    \ pumvisible() ? "\<C-n>" : "<TAB>"
inoremap <expr> <S-Tab>
    \ pumvisible() ? "\<C-p>" : "<S-TAB>"
" inoremap <expr> <Esc>
    " \ pumvisible() ? deoplete#close_popup() : "\<Esc>"

""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
""""""""""""""""""""""""""""""""""""""""""""""""""
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nrw', 100)
" let g:neomake_py_pylint_maker = {
    " \ 'args': ['%:p', '--max-line-length=100']
    " \ }
" let g:neomake_py_flake_maker = {
    " \ 'args': ['%:p', '--max-line-length=100']
    " \ }
let g:neomake_py_mypy_maker = {
    \ 'args': ['%:p', '--python-version=3.8']
    \ }
let g:neomake_python_enabled_makers = ['pylint', 'mypy']

let g:neomake_cpp_enable_makers = ['clang']


""""""""""""""""""""""""""""""""""""""""""""""""
" Tag bar
""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <silent> àg :TagbarOpen fj<CR>
" nmap <silent> àk :TagbarClose<CR>
nmap <silent> àg :TagbarToggle<CR>
let g:tagbar_autofocus=1

let g:tagbar_map_togglesort = 'è'
let g:tagbar_map_togglepause = 'f'
let g:tagbar_map_toggleautoclose = 'a'
let g:tagbar_sort = 0

""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> à] :!ctags -R --exclude='**/build/**' --exclude='**/dist/**'<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerSortBy='number'
nnoremap àà :BufExplorer<CR>
tnoremap àà <C-\><C-n>:BufExplorer<CR>
nmap à. :BufExplorer<CR>b
tmap à. <Esc>:BufExplorer<CR>b
set hidden
set confirm

" Need to change plugging mappings internally


""""""""""""""""""""""""""""""""""""""""""""""""
" Dim inactive: dim inactive windows.
""""""""""""""""""""""""""""""""""""""""""""""""
" let g:diminactive_enable_focus = 1
let g:diminactive_enable_focus = 0


""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow parenthesis configuration
""""""""""""""""""""""""""""""""""""""""""""""""

let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'firebrick'],
\	'ctermfgs': ['brown', 45, 207, 'lightgreen', 98],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\	}
\}

let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast and smooth movements
""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Camel case and undercore motion and text objects
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDisableDefaultKeyMapping = 1  " Avoid conflicts for <leader>b… mapping

map <nowait> <space>w <Plug>CamelCaseMotion_w
map <nowait> <space>b <Plug>CamelCaseMotion_b
map <nowait> <space>e <Plug>CamelCaseMotion_e

omap i<space>w <Plug>CamelCaseMotion_iw
xmap i<space>w <Plug>CamelCaseMotion_iw
omap i<space>b <Plug>CamelCaseMotion_ib
xmap i<space>b <Plug>CamelCaseMotion_ib
omap i<space>e <Plug>CamelCaseMotion_ie
xmap i<space>e <Plug>CamelCaseMotion_ie

""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd commenter: comment and uncomment easily
""""""""""""""""""""""""""""""""""""""""""""""""""
map ècc <plug>NERDCommenterComment
map ècl <plug>NERDCommenterAlignLeft
map ècu <plug>NERDCommenterUncomment
map ècb <plug>NERDCommenterMinimal
map ècy <plug>NERDCommenterYank
map èc$ <plug>NERDCommenterToEOL
map <silent> èca A <esc>:execute "normal \<plug>NERDCommenterAppend"<CR>A

let NERDSpaceDelims=1
" need to change plugin:
" - remove space after # in python comment symbols to avoid a double space
"   after # (need to keep NERDSpaceDelims at 1 for double space before end
"   of line comment

"""""""""""""""""""""""""""""""""""""""""""""""""
" Vim surround refactor mapping for bépo
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:surround_no_mappings = 1
let g:surround_no_insert_mappings = 1
nmap dk  <Plug>Dsurround
nmap lk  <Plug>Csurround
nmap lK  <Plug>CSurround
nmap yk  <Plug>Ysurround
nmap yK  <Plug>YSurround
nmap ykk <Plug>Yssurround
nmap yKk <Plug>YSsurround
nmap yKK <Plug>YSsurround
xmap K   <Plug>VSurround
xmap gK  <Plug>VgSurround

""""""""""""""""""""""""""""""""""""""""""""""""
" configuration for nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""
" active tree shortcut
" map <silent> àf :NERDTreeFocus<CR>
" map <silent> àx :NERDTreeClose<CR>

" Open NERDTree in the directory of the current file (or cwd if no file is open)
map <silent> àf :call NERDTreeToggleInCurDir()<cr>
map <silent> àF :NERDTreeToggle<CR>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction


let g:NERDTreeMapOpenInTab = 'l'
let g:NERDTreeMapOpenInTabSilent = 'gl'
let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapJumpFirstChild = 'S'
let g:NERDTreeMapJumpLastChild = 'T'
let g:NERDTreeMapJumpNextSibling = '<C-N>'
let g:NERDTreeMapJumpPrevSibling = '<C-J>'

" ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" ignore tree if it is the last left
augroup NerdTreeGroup
	autocmd!
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""
" Vertical moving with indents
""""""""""""""""""""""""""""""""""""""""""""""""""

" vertically look for non-empty character
noremap <silent> <c-t> :Vertical f<CR>
noremap ]& <c-t>
noremap <silent> <c-s> :Vertical b<CR>
" require 'stty -ixon' in the .bashrc to disable the freezing behaviour of <c-s>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim unimpaired
""""""""""""""""""""""""""""""""""""""""""""""""""

" make shortcuts easier
nmap ]ê <Plug>unimpairedMoveDown
xmap ]ê <Plug>unimpairedMoveSelectionDown
xmap [ê <Plug>unimpairedMoveSelectionUp
nmap [ê <Plug>unimpairedMoveUp
" nmap ]œ& & :call <SNR>170_setup_paste()<CR>o
" nmap ]œ& & :call <SNR>170_setup_paste()<CR>O
" unmap >p
" unmap >P
" unmap <p
" unmap <P

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <M-f> :FuzzyOpen<CR>
tnoremap <M-f> <C-\><C-n>:FuzzyOpen<CR>
nnoremap èg viw"gy:FuzzyGrep <C-r>g
nnoremap èG :FuzzyGrep 
vnoremap èg "gy:FuzzyGrep <C-r>g

let g:fuzzy_bindkeys = 0
autocmd FileType fuzzy tnoremap <silent> <buffer> <Esc> <C-\><C-n>:FuzzyKill<CR>
autocmd FileType fuzzy tnoremap <silent> <buffer> <M-S-T> <C-\><C-n>:FuzzyOpenFileInTab<CR>
autocmd FileType fuzzy tnoremap <silent> <buffer> <C-H> <C-\><C-n>:FuzzyOpenFileInSplit<CR>
autocmd FileType fuzzy tnoremap <silent> <buffer> <C-V> <C-\><C-n>:FuzzyOpenFileInVSplit<CR>

autocmd FileType fuzzy tnoremap <silent> <buffer> <C-T> <down>
autocmd FileType fuzzy tnoremap <silent> <buffer> <C-s> <up>


""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_map_keys = 0

nmap gha <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

nmap ghh <Plug>(GitGutterNextHunk)
nmap ghg <Plug>(GitGutterPrevHunk)

nmap <silent> ghv :GitGutterLineHighlightsToggle<CR>

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

command! Glist GitGutterQuickFix | copen

""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter
""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:lazygit_launch()
    if &buftype ==# 'terminal'
        let cwd = getcwd()
        let command = "lua require'lazygit'.lazygit('".cwd."')"
        execute command
    else
        lua require'lazygit'.lazygit()
    endif
endfunction

nnoremap <script> àh :call <SID>lazygit_launch()<CR>
tnoremap <silent> àh <C-\><C-n>:call <SID>lazygit_launch()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit command from terminal
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:editcommand_prompt = '[➭$:]'
let g:editcommand_no_mappings = 1
tmap <M-e> <Plug>EditCommand

""""""""""""""""""""""""""""""""""""""""""""""""""
" Debug strings
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> èbb :execute "normal \<Plug>DumpDebugStringVar"<CR>
nnoremap èbr :ResetDebugCounter<CR>
nnoremap <silent> èbs viw"vy
vnoremap <silent> èbs "vy
nnoremap <silent> èbv :execute "normal \<Plug>DumpDebugStringVar"<CR>:AddDebugStringExpr('@@@myvar@@@')<CR>/@@@myvar@@@<CR>hhv0k$?\d<CR>lc@@@mysep@@@<ESC>?DEBUGGING<CR>v3ec<{1:@@@myvartoreplace@@@}><ESC>la[<ESC>llv/\d<CR>h"sy/@@@mysep@@@<CR>v10l"sp/@@@myvar@@@<CR>vEc]<Space>=<ESC>:s.cout.cerr.e<CR>/@@@myvar@@@<CR>v10lc<\|1\|><ESC>A<`0`><ESC>?@@@myvartoreplace@@@<CR>v19lc
nnoremap <silent> èbV :execute "normal \<Plug>DumpDebugStringVar"<CR>:AddDebugStringExpr('<C-R>v')<CR>/<C-R>v<CR>hhv0k$?\d<CR>lc@@@mysep@@@<ESC>?DEBUGGING<CR>v3e"vpla[<ESC>llv/\d<CR>h"sy/@@@mysep@@@<CR>v10l"sp/<C-R>v<CR>vEc]<Space>=<ESC>:s.cout.cerr.e<CR>
nnoremap <silent> èbt viw"vy:execute "normal \<Plug>DumpDebugStringVar"<CR>:AddDebugStringExpr('<C-R>v')<CR>:s.cout.cerr<CR>/<C-R>v<CR>hhv0k$?\d<CR>lc@@@mysep@@@<ESC>?DEBUGGING<CR>v3e"vpla[<ESC>llv/\d<CR>h"sy/@@@mysep@@@<CR>v10l"sp/<C-R>v<CR>vEc]<Space>=<ESC>:s.cout.cerr.e<CR>
vnoremap <silent> èbt "vy:execute "normal \<Plug>DumpDebugStringVar"<CR>:AddDebugStringExpr('<C-R>v')<CR>:s.cout.cerr<CR>/<C-R>v<CR>hhv0k$?\d<CR>lc@@@mysep@@@<ESC>?DEBUGGING<CR>v3e"vpla[<ESC>llv/\d<CR>h"sy/@@@mysep@@@<CR>v10l"sp/<C-R>v<CR>vEc]<Space>=<ESC>:s.cout.cerr.e<CR>
nnoremap <silent> èbT viw"vyk:execute "normal \<Plug>DumpDebugStringVar"<CR>:AddDebugStringExpr('<C-R>v')<CR>:s.cout.cerr<CR>/<C-R>v<CR>hhv0k$?\d<CR>lc@@@mysep@@@<ESC>?DEBUGGING<CR>v3e"vpla[<ESC>llv/\d<CR>h"sy/@@@mysep@@@<CR>v10l"sp/<C-R>v<CR>vEc]<Space>=<ESC>:s.cout.cerr.e<CR>
vnoremap <silent> èbT "vyk:execute "normal \<Plug>DumpDebugStringVar"<CR>:AddDebugStringExpr('<C-R>v')<CR>:s.cout.cerr<CR>/<C-R>v<CR>hhv0k$?\d<CR>lc@@@mysep@@@<ESC>?DEBUGGING<CR>v3e"vpla[<ESC>llv/\d<CR>h"sy/@@@mysep@@@<CR>v10l"sp/<C-R>v<CR>vEc]<Space>=<ESC>:s.cout.cerr.e<CR>
nnoremap <silent> èbe :execute "normal \<Plug>DumpDebugStringExpr"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Abolish
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:abolish_no_mappings = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch source / header
""""""""""""""""""""""""""""""""""""""""""""""""""
map ès :call CurtineIncSw()<CR>

let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:tex_fast=0
let g:vimtex_quickfix_mode=0
let g:tex_no_error=1

set conceallevel=1

" xmap  ésD <Plug>(vimtex-delim-toggle-modifier-reverse)
" nmap  ésD <Plug>(vimtex-delim-toggle-modifier-reverse)
" xmap  ésd <Plug>(vimtex-delim-toggle-modifier)
" nmap  ésd <Plug>(vimtex-delim-toggle-modifier)
" nmap  ésc <Plug>(vimtex-cmd-toggle-star)
" nmap  ése <Plug>(vimtex-env-toggle-star)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap  lsd <Plug>(vimtex-delim-change-math)
nmap  lsc <Plug>(vimtex-cmd-change)
nmap  lse <Plug>(vimtex-env-change)
nmap  ls$ <Plug>(vimtex-env-change-math)

xmap lsm <plug>(vimtex-cmd-create)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""

imap g<TAB>     <Plug>(neosnippet_expand_or_jump)
smap g<TAB>     <Plug>(neosnippet_expand_or_jump)
xmap g<TAB>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'


""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown-preview
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mkdp_auto_close = 0

""""""""""""""""""""""""""""""""""""""""""""""""""
" Black
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:black_linelength = 120

""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenBrowser
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:openbrowser_search_engines = {
            \   'lilo': 'https://search.lilo.org/searchweb.php?q={query}'
            \}
let g:openbrowser_default_search = 'lilo'
let g:openbrowser_browser_commands = [
\   {'name': 'chromium-browser',
\    'args': ['{browser}', '{uri}']}
\]
nmap gx <plug>(openbrowser-smart-search)
vmap gx <plug>(openbrowser-smart-search)


""""""""""""""""""""""""""""""""""""""""""""""""""
" Far shortcut
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:far#default_mappings = 1
let g:far#mapping = {
    \ "exclude": ["x"],
    \ "include": ["i"],
    \ "toggle_exclude": ["-"],
    \ "toggle_exclude_all": ["_"],
    \ "preview_scroll_up": ["<s-s>"],
    \ "preview_scroll_down": ["<s-t>"],
    \ "replace_do": ["l"],
    \ }

let g:far#source = 'agnvim'
let g:far#debug = 1
let g:far#auto_preview = 0

nnoremap èr :let @p = expand("%")<CR>viwy:Far <C-R>"  <C-R>p<S-Left><Left>
nnoremap èR viwy:Far <C-R>"  **/*<S-Left><Left>

""""""""""""""""""""""""""""
" maximize.nvim
""""""""""""""""""""""""""""
nnoremap <silent> <M-b> <Cmd>lua require('maximize').toggle()<CR>
tnoremap <silent> <M-b> <C-\><C-n><Cmd>lua require('maximize').toggle()<CR>
inoremap <silent> <M-b> <Esc><Cmd>lua require('maximize').toggle()<CR>
xnoremap <silent> <M-b> <Esc><Cmd>lua require('maximize').toggle()<CR>


""""""""""""""""""""""""""""
"  LUA PLUGINS
"""""""""""""""""""""""""""
lua << EOF
-----------------------
-- auto-save.nvim
-----------------------
require("auto-save").setup {
    -- your config goes here
    -- or just leave it empty :)
    }

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
        },
        haskell = {
            'adt'
        },
        rust = {
            'impl_item',

        },
        terraform = {
            'block',
            'object_elem',
            'attribute',
        },
        scala = {
            'object_definition',
        },
        vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
        },
        markdown = {
            'section',
        },
        elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
        },
        json = {
            'pair',
        },
        typescript = {
            'export_statement',
        },
        yaml = {
            'block_mapping_pair',
        },
        python = {
            'block_mapping_pair',
            'object_definition',
            'entity_declaration',
            'argument_list',
            'parenthesized_expression',
            'dictionary',
            'list',
            'set',
            'tuple',
            'elif',
            'else',
        },
        cpp = {
            'else',
            'else_if',
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "python", "cpp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ---ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    ----- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    ----- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    ----- the name of the parser)
    ----- list of language that will be disabled
    ---disable = { "c", "rust" },
    ----- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    ---disable = function(lang, buf)
    ---    local max_filesize = 100 * 1024 -- 100 KB
    ---    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    ---    if ok and stats and stats.size > max_filesize then
    ---        return true
    ---    end
    ---end,

    ----- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    ----- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    ----- Using this option may slow down your editor, and you may see some duplicate highlights.
    ----- Instead of true it can also be a list of languages
    ---additional_vim_regex_highlighting = false,
  },
}

EOF
