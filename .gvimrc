" Screen geometry
set lines=50
set columns=100

" Select font based on OS
if has('win32')
	set guifont=Lucida_Console:h10	
else
	set guifont=Ubuntu\ Mono\ for\ Powerline\ 11
endif

" Maximize if in diff mode
if &diff
	if has('win32')
		autocmd GUIEnter * :simalt ~x
	else
	   winpos 0 0
	   set lines=73 columns=235
	endif
endif

" Color scheme
set background=dark
colorscheme solarized

