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
Plug 'SUSTech-data/neopyter'
Plug 'AbaoFromCUG/websocket.nvim'  " Dependency of neopyter
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

Plug 'luochen1990/rainbow'  " Matching parentheses
Plug 'itchyny/lightline.vim'  " colorized bottom bar
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}  " Show context
" Help syntax
Plug 'gburger11/vim-autoimport', {'tag': 'custom_db'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }  " tag 4.1 is necessary because 5.0 is compatible with nvim 0.3+ only, and default in ubuntu 18.04 is nvim 0.2.2
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdcommenter'
Plug 'neomake/neomake'
Plug 'Vimjas/vim-python-pep8-indent'  " Necessary for python indentation
Plug 'psf/black',
Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvimdev/indentmini.nvim'  " Show indentation
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'  " Allow case sensitive replacement with `:Subvert/.../.../`
Plug 'tell-k/vim-autopep8'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'udalov/kotlin-vim'

Plug 'NyxVim/nvim-colorizer.lua'

" Help navigation
" Plug 'wellle/context.vim'  " Awesome, but slow when tested in 02/2023
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-scripts/scratch.vim'
Plug 'declancm/maximize.nvim'
Plug 'tpope/vim-fugitive'  " Easy support for git in vim
Plug 'lewis6991/gitsigns.nvim'
Plug 'rhysd/conflict-marker.vim'  " Highlight conflict, allow jump and selection
Plug 'kdheepak/lazygit.nvim'
Plug 'kshenoy/vim-signature'  " Show marks in the margin
Plug 'scrooloose/nerdtree'
Plug 'gburger11/ouroboros.nvim'  " Swap from source file to header file, better
Plug 'folke/which-key.nvim'
Plug 'rbong/vim-flog'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'echasnovski/mini.icons'  " Require by which-key
Plug 'nvim-telescope/telescope.nvim'
Plug 'kevinhwang91/nvim-bqf'

Plug 'haya14busa/is.vim'  " IncSearch -> color search only when searching
Plug 'haya14busa/vim-asterisk'  " Does the same for * and # searches
" Language help
" Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' } " Works awesome, but super slow
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'arakashic/chromatica.nvim' " Strange coloring. Maybe need personalization…
Plug 'tyru/open-browser.vim'
Plug 'AndrewRadev/switch.vim'  " Switch between true/false, left/right...
" Plug 'craigemery/vim-autotag'
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
            \   'cwd': 'GetShortCwd',
            \   'tmuxname': 'GetTmuxSessionName'
            \ }
            \}

            "\   'gitbranch': 'fugitive#head',
function! GetTmuxSessionName()
    return systemlist("tmux display-message -p \"#W\"")[0]
endfunction
function! GetShortCwd()
    return substitute(expand(getcwd()), $HOME, "~", "")
endfunction

" Disable lightline on all floating windows (Telescope, lazygit)
augroup LightlineFloatingFix
    autocmd!
    autocmd WinEnter,BufEnter *
        \ if nvim_win_get_config(win_getid())['relative'] != '' |
        \   call lightline#disable() |
        \ else |
        \   call lightline#enable() |
        \ endif
augroup END


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

" disable autocomplete on telescope prompts
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
""""""""""""""""""""""""""""""""""""""""""""""""""
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nrw', 100)
let g:neomake_py_mypy_maker = {
            \ 'args': ['%:p', '--python-version=3.8']
            \ }
let g:neomake_python_enabled_makers = ['pylint', 'mypy']


""""""""""""""""""""""""""""""""""""""""""""""""
" Tag bar
""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <silent> àg :TagbarOpen fj<CR>
" nmap <silent> àk :TagbarClose<CR>
nmap <silent> àf :TagbarToggle<CR>
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
\	'guifgs': ['royalblue3', 'darkorange3', 'DarkCyan', 'DarkRed', 'Purple', 'SeaGreen'],
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
" map ècl <plug>NERDCommenterAlignLeft
map ècu <plug>NERDCommenterUncomment
map ècb <plug>NERDCommenterMinimal
map ècy <plug>NERDCommenterYank
map èc$ <plug>NERDCommenterToEOL
map <silent> èca A <esc>:execute "normal \<plug>NERDCommenterAppend"<CR>A

let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'
let g:NERDCreateDefaultMappings = 0
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
" configuration for indentLine for conceallevel in json
""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_json_conceal = 0
let g:vim_markdown_conceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""
" configuration for nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""

" Open NERDTree in the directory of the current file (or cwd if no file is open)
map <silent> àq :call NERDTreeToggleInCurDir()<cr>
map <silent> àQ :NERDTreeToggle<CR>
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


""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter
""""""""""""""""""""""""""""""""""""""""""""""""""

nmap gha <cmd>Gitsigns stage_hunk<CR>
nmap ghp <cmd>Gitsigns preview_hunk_inline<CR>
nmap ghw <cmd>Gitsigns toggle_word_diff<CR>

nmap ghh <cmd>Gitsigns next_hunk<CR>
nmap ghg <cmd>Gitsigns prev_hunk<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Git Conflict Marker
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:conflict_marker_enable_mappings = 0

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<<\+ .*$'
let g:conflict_marker_common_ancestors = '^|||||||\+ .*$'
let g:conflict_marker_end   = '^>>>>>>>\+ .*$'

nnoremap gho <cmd> ConflictMarkerOurselves<CR>
nnoremap ght <cmd> ConflictMarkerThemselves<CR>
nnoremap ghb <cmd> ConflictMarkerBoth<CR>
nnoremap gh<S-B> <cmd> ConflictMarkerBoth!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
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

nnoremap <script> àg <cmd>Flog -open-cmd=edit -all<CR>
tnoremap <silent> àg <C-\><C-n>:Flog -open-cmd=edit -all<CR>

nnoremap <script> àG <cmd>Flog -open-cmd=edit -all -path=%<CR>
tnoremap <silent> àG <C-\><C-n>:Flog -open-cmd=edit -all -path=%<CR>
" nnoremap <script> àG <cmd>Flog -open-cmd=vsplit -all<CR>
" tnoremap <silent> àG <C-\><C-n>:Flog -open-cmd=vsplit -all<CR>


augroup FlogMappings
    " Override the `cc` and `rr` mappings to allow movement in bépo
    au!
    au BufNewFile,BufRead *flog*
        \ nmap <buffer> <C-c><C-c> <Plug>(FlogCommit)|
        \ nmap <buffer> <C-r> <Plug>(FlogRebaseContinue)|
        \ nmap <buffer> <C-c>rc <Plug>(FlogRevert)|
        \ nmap <buffer> <C-c>rn <Plug>(FlogRevertNoEdit)|
        \ nmap <buffer> <C-c>r<space> <Plug>(FlogGitRevert)
augroup END

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
" noremap <silent> ès :call CurtineIncSw()<CR>
noremap <silent> ès :Ouroboros<CR>


let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:tex_fast=0
let g:vimtex_quickfix_mode=0
let g:tex_no_error=1

set conceallevel=1

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
let g:black_linelength = 100

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

" nnoremap èr :let @p = expand("%")<CR>viwy:Far <C-R>" <C-R>" <C-R>p<S-Left><Left>
" nnoremap èR viwy:Far <C-R>" <C-R>" **/*<S-Left><Left>
nnoremap èr viw"ry:%s/\<<C-R>r\>/<C-R>r/gc<Left><Left><Left>

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
    execute map_command . " <silent> <M-'> <cmd>Telescope buffers sort_lastused=true<cr>"
    execute map_command . ' <silent> <M-’> <cmd>Telescope buffers sort_lastused=true<cr>'
    execute map_command . ' <silent> <M-k> <cmd>Telescope quickfix<cr>'
    execute map_command . ' <silent> <M-s-h> <cmd>Telescope resume<cr>'
    execute map_command . ' <silent> <M-s-g> <cmd>Telescope pickers<cr>'
endfor

nnoremap <M-h> viw"sy<cmd>Telescope grep_string<cr>
tnoremap <M-h> viw"sy<C-\><C-n><cmd>Telescope grep_string<cr>
noremap! <M-h> viw"sy<C-\><C-n><cmd>Telescope grep_string<cr>
vnoremap <M-h> "sy<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.getreg('s')})<cr>
noremap è<S-r> :cdo s.<c-r>s.<c-r>s.g \| update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

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
    nnoremap <S-k><S-k> <Plug>SlimeParagraphSend
endfunction


command! JukitActivate call s:activate_jukit_mappings()
command! SlimeActivate call s:activate_slime_mappings()
