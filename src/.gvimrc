" Screen geometry
set lines=50
set columns=100

" Font
if has('win32')
	set guifont=Lucida_Console:h10	
else
	set guifont=Ubuntu\ Mono\ for\ Powerline\ 12
endif

" Color scheme
set background=dark
colorscheme solarized

" Source ~/.gvimrc.local if it exists
if filereadable($HOME."/.gvimrc.local")
    source $HOME/.gvimrc.local
endif
