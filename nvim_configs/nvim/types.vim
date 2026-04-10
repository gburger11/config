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
    au TermOpen term://*lazygit* tnoremap <buffer> <esc> <esc>| tnoremap <buffer> <c-n> <c-\><c-n>

augroup END


fun! s:termSpecificLocalChanges()
    if &buftype ==# 'terminal'
        setlocal nonumber
        setlocal norelativenumber
    endif
endfun
let g:match_trailingspace_id = -1
let g:match_overlength_id = -1
fun! s:termSpecificChangingChanges()
    if &buftype ==# 'terminal' || &buftype ==# 'nofile'
        " ColorTerm
        " hi clear @special.overlength
        " hi clear @special.trailingspaces
        " highlight! @special.trailingspaces guibg=NONE
        " if &filetype ==# 'lazygit' || &filetype ==# 'TelescopePrompt'
        if &filetype ==# 'lazygit'
            hi NormalFloat ctermbg=NONE ctermfg=white
        endif
        let matches = getmatches()
        for match in matches
            if match.group ==# '@special.trailingspaces' || match.group ==# '@special.overlength'
                call matchdelete(match.id)
            endif
            " if g:match_trailingspace_id > 0
                " trylet g:match_trailingspace_id = -1
                    " call matchdelete(g:match_trailingspace_id)
                " catch
                    " " Do nothing
                " endtry
                " let g:match_trailingspace_id = -1
            " endif
            " if g:match_overlength_id > 0
                " try
                    " call matchdelete(g:match_overlength_id)
                " catch
                    " " Do nothing
                " endtry
                " let g:match_overlength_id = -1
            " endif
        endfor
    else
        " ColorThings
        " highlight OverLength ctermbg=68 ctermfg=white guibg=#592929
        " highlight TrailingSpaces ctermbg=142
        " highlight! @special.trailingspaces guibg=LightCyan

        " if g:match_trailingspace_id < 0
            " let g:match_trailingspace_id = matchadd('@special.trailingspaces', '\s\+$', 150)
        " endif
        " if g:match_overlength_id < 0
            " let g:match_overlength_id = matchadd('@special.overlength', '\%121v.\+', 150)
        " endif
        call matchadd('@special.trailingspaces', '\s\+$', 150)
        call matchadd('@special.overlength', '\%121v.\+', 150)

        hi! link NormalFloat Pmenu
    endif
endfun
