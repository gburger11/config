" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugins')

" Plug 'benlubas/molten-nvim'
Plug 'luk400/vim-jukit'
Plug 'jpalardy/vim-slime'

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-smooth-scroll'
Plug 'vim-scripts/camelcasemotion'
Plug 'majutsushi/tagbar'
Plug 'rbong/vim-vertical'  " Motion block by block (mapped to <C-t> and <C-s>)
Plug 'tpope/vim-unimpaired'
Plug 'Pocco81/auto-save.nvim'
Plug 'jeetsukumaran/vim-pythonsense'  " Motion and selection of python objects
" Colors
Plug 'morhetz/gruvbox'
Plug 'levouh/tint.nvim'

Plug 'luochen1990/rainbow'  " Matching parentheses
Plug 'itchyny/lightline.vim'  " colorized bottom bar
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}  " Show context
" Help syntax
" Plug 'wookayin/vim-autoimport'
Plug 'gburger11/vim-autoimport', {'tag': 'custom_db'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }  " tag 4.1 is necessary because 5.0 is compatible with nvim 0.3+ only, and default in ubuntu 18.04 is nvim 0.2.2
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdcommenter'
Plug 'neomake/neomake'
Plug 'Vimjas/vim-python-pep8-indent'  " Necessary for python indentation
Plug 'psf/black',
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
Plug 'qpkorr/vim-bufkill'
Plug 'vim-scripts/scratch.vim'
Plug 'declancm/maximize.nvim'
Plug 'tpope/vim-fugitive'  " Easy support for git in vim
Plug 'airblade/vim-gitgutter'  " Show git change in the margin + quick preview or reset
Plug 'kdheepak/lazygit.nvim'
Plug 'kshenoy/vim-signature'  " Show marks in the margin
Plug 'scrooloose/nerdtree'
Plug 'gburger11/CurtineIncSw.vim'  " Swap from source file to header file
Plug 'brooth/far.vim'  " Find And Replace very powerful
Plug 'folke/which-key.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.6'}
Plug 'kevinhwang91/nvim-bqf'

Plug 'haya14busa/is.vim'  " IncSearch -> color search only when searching
Plug 'haya14busa/vim-asterisk'  " Does the same for * and # searches
" Language help
" Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' } " Works awesome, but super slow
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'arakashic/chromatica.nvim' " Strange coloring. Maybe need personalization…
Plug 'tyru/open-browser.vim'
Plug 'AndrewRadev/switch.vim'  " Switch between true/false, left/right...
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

" map é <Plug>(easymotion-prefix)
" map éé <Plug>(easymotion-bd-f)
" map éw <Plug>(easymotion-bd-w)
" map ée <Plug>(easymotion-bd-e)
" map én <Plug>(easymotion-vim-n)
" map éN <Plug>(easymotion-vim-N)
" map é/ <Plug>(easymotion-sn)

" " map éW <Plug>(easymotion-W)
" " map éàe <Plug>(easymotion-ge)
" " map éàE <Plug>(easymotion-gE)
" " nmap ét <Plug>(easymotion-j)
" " nmap és <Plug>(easymotion-w)
" " nmap ér <Plug>(easymotion-sn)
" " nmap éy <Plug>(easymotion-bd-t)
" " nmap éx <Plug>(easymotion-bd-n)
" " nmap é* <Plug>(easymotion-next)
" " nmap é# <Plug>(easymotion-prev)
" " nmap én <Plug>(easymotion-bd-n)
" "
" map étt <Plug>(easymotion-sol-j)
" map été <Plug>(easymotion-eol-j)
" map éss <Plug>(easymotion-sol-k)
" map ésé <Plug>(easymotion-eol-k)
" nmap é. <Plug>(easymotion-repeat)

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

call deoplete#custom#option('candidate_marks', ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
for i in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    execute 'inoremap <expr> ' . i .'ê pumvisible() ? deoplete#insert_candidate(' . i . ') : "' . i . '"'
endfor
" for [i, l] in [[0, 'c'], [1, 't'], [2, 's'], [3, 'r'], [4, 'n'], [5, 'm'], [6, 'v'], [7, 'd'], [8, 'l'], [9, 'j']]
    " execute 'inoremap <expr> <M-' . l .'> pumvisible() ? deoplete#insert_candidate(' . i . ') : "' . l . '"'
" endfor

" disable autocomplete on telescope prompts
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

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

let g:neomake_cpp_enable_makers = ['clang', 'cppcheck']


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
" nnoremap <M-f> :FuzzyOpen<CR>
" tnoremap <M-f> <C-\><C-n>:FuzzyOpen<CR>
" nnoremap èg viw"gy:FuzzyGrep <C-r>g
" nnoremap èG :FuzzyGrep 
" vnoremap èg "gy:FuzzyGrep <C-r>g

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
tmap <M-j> <Plug>EditCommand

""""""""""""""""""""""""""""""""""""""""""""""""""
" Debug strings  -> to not use in C++ and Python. Prefer èo mappings
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
" Abolish -> :Subvert
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:abolish_no_mappings = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch source / header
""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> ès :call CurtineIncSw()<CR>

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
\   {'name': 'firefox',
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

nnoremap èr :let @p = expand("%")<CR>viwy:Far <C-R>" <C-R>" <C-R>p<S-Left><Left>
nnoremap èR viwy:Far <C-R>" <C-R>" **/*<S-Left><Left>

""""""""""""""""""""""""""""
" maximize.nvim
""""""""""""""""""""""""""""
nnoremap <silent> <M-b> <Cmd>lua require('maximize').toggle()<CR>
tnoremap <silent> <M-b> <C-\><C-n><Cmd>lua require('maximize').toggle()<CR>
inoremap <silent> <M-b> <Esc><Cmd>lua require('maximize').toggle()<CR>
xnoremap <silent> <M-b> <Esc><Cmd>lua require('maximize').toggle()<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""
"  Telescope
"""""""""""""""""""""""""""""""""""""""""""""""
for map_command in ['noremap', 'noremap!', 'tnoremap']
    " noremap -> normal, visual, operator_pending
    " noremap! -> insert and command
    " tnoremap -> terminal mode
    execute map_command . ' <silent> <M-f> <C-\><C-n><cmd>Telescope find_files<cr>'
    execute map_command . ' <silent> <M-g> <C-\><C-n><cmd>Telescope live_grep<cr>'
    execute map_command . " <silent> <M-'> <cmd>Telescope buffers<cr>"
    execute map_command . ' <silent> <M-’> <cmd>Telescope buffers<cr>'
    execute map_command . ' <silent> <M-k> <cmd>Telescope quickfix<cr>'
    execute map_command . ' <silent> <M-s-h> <cmd>Telescope resume<cr>'
    execute map_command . ' <silent> <M-s-g> <cmd>Telescope pickers<cr>'
endfor

nnoremap <M-h> <cmd>Telescope grep_string<cr>
tnoremap <M-h> <C-\><C-n><cmd>Telescope grep_string<cr>
noremap! <M-h> <C-\><C-n><cmd>Telescope grep_string<cr>
vnoremap <M-h> "sy<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.getreg('s')})<cr>

""""""""""""""""""""""""""""
" vim-signature
""""""""""""""""""""""""""""
let g:SignatureIncludeMarks='abcdefghijklmnorstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'  " Remove pq from visible marks


""""""""""""""""""""""""""""
"  Jukit (Jupyter adapter) and Slime (send to ipython)
"""""""""""""""""""""""""""
let g:jukit_mpl_block = 1  " plt.show with block=False
let g:jukit_mappings = 0
let g:jukit_shell_cmd = 'ipython3'


function! s:activate_jukit_mappings()
    nnoremap koh :call jukit#splits#output_and_history()<cr>
    nnoremap k<space> :call jukit#send#section(1)<cr>
    nnoremap kk :call jukit#send#line()<cr>
    vnoremap k :<C-U>call jukit#send#selection()<cr>
    nnoremap kg :call jukit#send#until_current_section()<cr>
    nnoremap ka :call jukit#send#all()<cr>
    nnoremap kt :call jukit#cell#jump_to_next_cell()<cr>
    nnoremap ks :call jukit#cell#jump_to_previous_cell()<cr>

    nnoremap kco :call jukit#cells#create_below(0)<cr>
    "   - Create new code cell below. Argument: Whether to create code cell (0) or markdown cell (1)
    nnoremap kcO :call jukit#cells#create_above(0)<cr>
    "   - Create new code cell above. Argument: Whether to create code cell (0) or markdown cell (1)
    nnoremap kcp :call jukit#cells#create_below(1)<cr>
    "   - Create new textcell below. Argument: Whether to create code cell (0) or markdown cell (1)
    nnoremap kcP :call jukit#cells#create_above(1)<cr>
    "   - Create new textcell above. Argument: Whether to create code cell (0) or markdown cell (1)
    nnoremap kcd :call jukit#cells#delete()<cr>
    "   - Delete current cell
    nnoremap kcs :call jukit#cells#split()<cr>
    "   - Split current cell (saved output will then be assigned to the resulting cell above)
    nnoremap kcM :call jukit#cells#merge_above()<cr>
    "   - Merge current cell with the cell above
    nnoremap kcm :call jukit#cells#merge_below()<cr>
    "   - Merge current cell with the cell below
    nnoremap kck :call jukit#cells#move_up()<cr>
    "   - Move current cell up
    nnoremap kcj :call jukit#cells#move_down()<cr>
    "   - Move current cell down
endfunction


let g:slime_python_ipython = 1
let g:slime_target = "neovim"
let g:slime_menu_config=1
let g:slime_input_pid=1
let g:slime_no_mappings = 1


function! s:activate_slime_mappings()
    "send visual selection
    xnoremap k <Plug>SlimeRegionSend
    "send based on motion or text object
    nnoremap k <Plug>SlimeMotionSend
    "send line
    nnoremap kk <Plug>SlimeLineSend
endfunction


command! JukitActivate call s:activate_jukit_mappings()
command! SlimeActivate call s:activate_slime_mappings()

""""""""""""""""""""""""""""
" " Send
"""""""""""""""""""""""""""
" let g:send_disable_mapping=1

" nmap kk <Plug>SendLine
" nmap kà <Plug>Send
" vmap kk <Plug>Send
" nmap K s$


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
    debounce_delay = 200,
    execution_message = {}
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
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "cpp" },

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

-- ["<S-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.previewers").vim_buffer_qflist.new,
-- ["<S-q>"] = require("telescope.actions").smart_send_to_qflist + require('telescope.actions').open_qflist,
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-s>"] = "preview_scrolling_up",
                ["<C-t>"] = "preview_scrolling_down",
                ["<C-p>"] = {"<C-r>\"", type = "command"},
                ["<M-k>"] = require("telescope.actions").smart_send_to_qflist,
                ["<M-q>"] = require("telescope.actions").close,
            },
            n = {
                ["<M-k>"] = require("telescope.actions").smart_send_to_qflist,
                ["<M-q>"] = require("telescope.actions").close,
                ["t"] = "move_selection_next",
                ["s"] = "move_selection_previous",
                ["<S-s>"] = "preview_scrolling_up",
                ["<S-t>"] = "preview_scrolling_down",
                ["<C-s>"] = "preview_scrolling_up",
                ["<C-t>"] = "preview_scrolling_down",
                ["<C-h>"] = "file_split",
            },
        },
        prompt_prefix="🔍 ",
        cache_picker={
            num_pickers = 10,
        },
    },
    pickers = {
        find_files = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
            mappings = {
                i = {
                    ["<M-'>"] = {
                        "<Esc>02<right>v$hy:lua require('telescope.builtin').buffers { default_text = require('telescope.actions.state').get_current_line() }<CR>",
                        type="command"},
                },
                n = {
                    ["<M-'>"] = {
                        "02<right>v$hy:lua require('telescope.builtin').buffers { default_text = require('telescope.actions.state').get_current_line() }<cr>",
                        type="command"},
                },
            },
        },
        grep_string = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
        },
        buffers = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
                height = 30,
                preview_height = 15,
            },
            mappings = {
                i = {
                    ["<M-f>"] = {
                        "<Esc>02<right>v$hy:lua require('telescope.builtin').find_files { default_text = require('telescope.actions.state').get_current_line() }<CR>",
                        type="command"},
                },
                n = {
                    ["x"] = "delete_buffer",
                    ["<M-f>"] = {
                        "02<right>v$hy:lua require('telescope.builtin').find_files { default_text = require('telescope.actions.state').get_current_line() }<cr>",
                        type="command"},
                },
            },
        },
        live_grep = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
            mappings = {
                i = {
                    ["<M-h>"] = "to_fuzzy_refine",
                },
                n = {
                    ["<M-h>"] = "to_fuzzy_refine",
                },
            },
        },
        quickfix = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
        },
    },
}

-- Make quickfix more beautiful

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

-- Adapt fzf's delimiter in nvim-bqf
require('bqf').setup({
    func_map = {
        pscrollup = "<S-s>",
        pscrolldown = "<S-t>",
        -- set to empty string to disable
        tab = '',
        tabb = '',
        tabc = '',
    },
    filter = {
        fzf = {
            action_for = {},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│', '--prompt', '> '}
        }
    }
})


-- which key
local wk = require("which-key")

wk.register({

  é = {
    name = "Movements", -- optional group name
    é = {"<Plug>(easymotion-bd-f)", "[easy] Move to char"},
    w = {"<Plug>(easymotion-bd-w)", "[easy] Move to start word"},
    e = {"<Plug>(easymotion-bd-e)", "[easy] Move to end word"},
    ["."] = {"<Plug>(easymotion-repeat)", "[easy] Repeat last move"},
    n = {"<Plug>(easymotion-vim-n)", "[easy] Next search"},
    N = {"<Plug>(easymotion-vim-N)", "[easy] previous search"},
    ["/"] = {"<Plug>(easymotion-sn)", "[easy] search"},
    d = "Next git conflict position",
  },
  è = {
      name = "Débug",
  },
})
local presets = require("which-key.plugins.presets")
presets.operators["c"] = nil


-- """"""""""""""""""""""""""""
-- " REPL
-- """""""""""""""""""""""""""
-- require("nvim-python-repl").setup()

-- vim.keymap.set("n", "kk", function() require('nvim-python-repl').send_statement_definition() end, { desc = "Send semantic unit to REPL"})
-- vim.keymap.set("v", "kk", function() require('nvim-python-repl').send_visual_to_repl() end, { desc = "Send visual selection to REPL"})
-- vim.keymap.set("n", "kp", function() require('nvim-python-repl').send_buffer_to_repl() end, { desc = "Send entire buffer to REPL"})
-- vim.keymap.set("n", "ke", function() require('nvim-python-repl').toggle_execute() end, { desc = "Automatically execute command in REPL after sent"})
-- vim.keymap.set("n", "kv", function() require('nvim-python-repl').toggle_vertical() end, { desc = "Create REPL in vertical or horizontal split"})
-- vim.keymap.set("n", "ko", function() require('nvim-python-repl').open_repl() end, { desc = "Opens the REPL in a window split"})


require('maximize').setup()
require('tint').setup()

EOF
