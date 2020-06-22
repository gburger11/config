augroup TypeDependentSettings
    au!
    au BufNewFile,BufRead *.tpp
        \ set filetype=cpp

    " au BufNewFile,BufRead *.h,*.c,*.cc,*.tpp
        " \ set cindent |
        " \ set cino=(0 |
        " \ set foldmethod=syntax |

    " au BufNewFile,BufRead *.py
        " \ set fileformat=unix |
        " \ set comments+=:# |
        " \ set foldmethod=indent |

    " ignore tree if it is the last left
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    au TermOpen * call s:termSpecificLocalChanges() | call s:termSpecificChangingChanges()
    au BufEnter,WinEnter * call s:termSpecificChangingChanges()

augroup END


fun! s:termSpecificLocalChanges()
    if &buftype ==# 'terminal'
        setlocal nonumber
        setlocal norelativenumber
    endif
endfun
fun! s:termSpecificChangingChanges()
    if &buftype ==# 'terminal' || &buftype ==# 'nofile'
        hi clear OverLength
    else
        highlight OverLength ctermbg=68 ctermfg=white guibg=#592929
    endif
endfun
