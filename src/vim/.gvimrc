" Screen geometry
set lines=50
set columns=130

" Font
if has('win32')
    " Font
    set guifont=Consolas\ NF:h11

    " Line height
    set linespace=-2

    " Show menu
    set guioptions+=m
else
    " Font
    "set guifont=Ubuntu\ Mono\ for\ Powerline\ 12

    set guifont=Menlo-Regular:h12
    set linespace=1

endif

" Color scheme
"set background=dark
"colorscheme solarized

set background=light
colorscheme lunaperche
