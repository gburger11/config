""""""""""""""""""""""""""""""""""""""""""""""""""
" General colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_number_column="bg1"

colorscheme gruvbox
hi Normal ctermbg=16 ctermfg=white guibg=Black guifg=NvimLightGray2
hi NormalNC ctermbg=235 guibg=NvimDarkGray3 guifg=NvimLightGray2
hi link @function GruvboxPurpleBold

set t_Co=256


""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight of errors
""""""""""""""""""""""""""""""""""""""""""""""""""
call matchadd('@special.badspaces', ' \| ', 51)
call matchadd('@special.logerror', '.*\[E\].*', 55)
call matchadd('@special.logerror', '.*#\{4\} ERROR ####.*', 56)
call matchadd('@special.logwarning', '.*\[W\].*', 54)
call matchadd('@special.logwarning', '.*#\{4\} WARNING ####.*', 57)
" **** Trailing spaces and overlength are undesired in terminals -> taken care in types.vim
" call matchadd('@special.trailingspaces', '\s\+$', 1520)
" call matchadd('@special.overlength', '\%121v.\+', 53)

" function! s:color_things()
" highlight unwanted spaces
highlight @special.badspaces ctermbg=214 ctermfg=white guibg=Yellow
highlight @special.trailingspaces ctermbg=142 guibg=LightCyan

" highlight the errors in the terminal
highlight @special.logerror cterm=bold ctermfg=124 guifg=Red
highlight @special.logwarning cterm=bold ctermfg=202 guifg=Orange

" highlight line too long (120 char)
highlight @special.overlength ctermbg=68 ctermfg=white guibg=#592929
" endfunction

" function! s:set_color_term()
    " call s:color_things()
    " highlight @special.overlength guibg=NONE
    " highlight @special.trailingspaces guibg=NONE
" endfunction

" function! s:no_color_long_lines()
    " highlight @special.trailingspaces guibg=NONE
" endfunction


" call s:color_things()
" command! ColorThings call s:color_things()
" command! ColorTerm call s:set_color_term()
" command! NoColorLines call s:no_color_long_lines()

augroup URDF_filetype
    au BufRead,BufNewFile *.urdf set filetype=xml
augroup END
