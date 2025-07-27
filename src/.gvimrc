" Screen geometry
set lines=50
set columns=100

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
set background=dark
colorscheme solarized

" Source ~/.gvimrc.local if it exists
if filereadable($HOME."/.gvimrc.local")
    source $HOME/.gvimrc.local
endif
