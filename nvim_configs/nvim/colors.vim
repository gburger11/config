""""""""""""""""""""""""""""""""""""""""""""""""""
" General colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_number_column="bg1"

colorscheme gruvbox
hi Normal ctermbg=16 ctermfg=white
hi NormalNC ctermbg=235

set t_Co=256


""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight of errors
""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight unwanted spaces
highlight UnwantedSpaces ctermbg=214 ctermfg=white
highlight TrailingSpaces ctermbg=142

" highlight the errors in the terminal
highlight MakeErrors cterm=bold ctermfg=124
highlight MakeWarnings cterm=bold ctermfg=202

" highlight line too long (120 char)
highlight OverLength ctermbg=68 ctermfg=white guibg=#592929

function! s:color_things()
    call matchadd('UnwantedSpaces', ' \| ', 51)
    call matchadd('TrailingSpaces', '\s\+$', 52)
    call matchadd('MakeErrors', '.*\[E\].*', 55)
    call matchadd('MakeErrors', '.*#\{4\} ERROR ####.*', 56)
    call matchadd('MakeWarnings', '.*\[W\].*', 54)
    call matchadd('MakeWarnings', '.*#\{4\} WARNING ####.*', 57)
    call matchadd('OverLength', '\%121v.\+', 53)
endfunction

function! s:no_color_long_lines()
    call matchdelete('OverLength')
endfunction


call s:color_things()
command! ColorThings call s:color_things()
command! NoColorLines call s:no_color_long_lines()
