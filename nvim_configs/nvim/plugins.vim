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
" Colors
Plug 'morhetz/gruvbox'
Plug 'blueyed/vim-diminactive'
Plug 'luochen1990/rainbow'
Plug 'itchyny/lightline.vim'  " colorized bottom bar
" Help syntax
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }  " tag 4.1 is necessary because 5.0 is compatible with nvim 0.3+ only, and default in ubuntu 18.04 is nvim 0.2.2
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'neomake/neomake'
Plug 'Vimjas/vim-python-pep8-indent'  " Necessary for python indentation
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'Yggdroot/indentLine'  " displays indentation levels with spaces (with ¦)
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'  " Allow case sensitive replacement with `:Subvert/.../.../`
Plug 'tell-k/vim-autopep8'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'udalov/kotlin-vim'
" Help navigation
Plug 'cloudhead/neovim-fuzzy'
Plug 'guibur/bufexplorer'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-scripts/scratch.vim'
Plug 'szw/vim-maximizer'
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
    \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'filetype', 'cwd', 'tmuxname' ] ]
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
" Highlighter
""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:highlighter#auto_update = 0
" nmap gc :HighlighterUpdate<CR>
" let g:Highlighter#disabled_languages = ['py']
" let g:highlighter#project_root_signs = ['.git']


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
let g:neomake_py_pylint_maker = {
    \ 'args': ['%:p', '--max-line-length=120']
    \ }
let g:neomake_py_flake_maker = {
    \ 'args': ['%:p', '--max-line-length=120']
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
let g:diminactive_enable_focus = 1

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

let g:black_linelength = 120
" let g:black_targetversion = 'py27'

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
let g:far#mappings = {
    \ "toggle_exclude": "-",
    \ "preview_scroll_up": "<c-s>",
    \ "preview_scroll_down": "<c-t>",
    \ "replace_do": "l"
    \ }
let g:far#source = 'agnvim'

nnoremap èr viwy:Far <C-R>"  %<Left><Left>
nnoremap èR viwy:Far <C-R>"  **/*<Left><Left><Left><Left><Left>
