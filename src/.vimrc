" Pre-Pathogen infect {

    " Load Pathogen from non-standard location
    runtime bundle/vim-pathogen/autoload/pathogen.vim

	" Disable vi compatibility
	set nocompatible

    " Pathogen {

        let g:pathogen_disabled = []

        " Disable CSApprox until workaround for MobaXterm gnome-terminal
        call add(g:pathogen_disabled, "CSApprox")

        " Disable MiniBufExplorer in diff mode
        if &diff
            call add(g:pathogen_disabled, "minibufexpl.vim")
        endif

        call add(g:pathogen_disabled, "vim-session")
        call add(g:pathogen_disabled, "vim-misc")

    " }
" }

" Load Pathogen {

	call pathogen#infect()
    Helptags
	filetype off
	syntax on
	filetype plugin indent on

" }

" Post-Pathogen infect {

	" Allow deleting of any character with backspace
	set backspace=indent,eol,start

	" Do not wrap long lines
	set nowrap

	" Enable mouse when running in terminal
	set mouse=a

	" Disable spell check
	set nospell

	" Enable syntax highlighting
	syntax enable
	
	" Do not automatically backup files 
	set nobackup

	" Indent (outdent) 4 columns for >> (<<)
	set shiftwidth=4
	
	" Display tabs 4 spaces wide
	set tabstop=4

	" Expand tabs to spaces
	set expandtab

    " Override indent/tab size for some languages
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2

    " Block indent with Tab in visual mode
    vmap <tab> >gv

    " Block dedent with Shift-Tab in visual mode
    vmap <s-tab> <gv

	" Show line numbers
	set number

	" Use incremental search for /
	set incsearch

	" Highlight search
	set hlsearch

    " Toggle highlighting of most recent search
    map <leader>H :nohlsearch<cr>

	" Open horizontal splits below current split
	set splitbelow

	" Open vertical splits to the right of current split
	set splitright

    " Open horizontal split
    noremap <leader>h :split<CR>

    " Open vertical split
    noremap <leader>v :vsplit<CR>

    " Close active split
    noremap <leader>c :close<CR>

	set laststatus=2
	set guioptions-=T
	set guioptions-=m
	set hidden

	" Resize splits on window resize
	autocmd VimResized * wincmd =

    " Suppress reload prompt when file mode changes
    autocmd FileChangedShell * let v:fcs_choice = (v:fcs_reason == "mode") ? "" : "ask"

	" Color scheme
	set t_Co=16
	set background=dark
	colorscheme ir_black

    " Map Alt- to the same behavior in vim and gvim
    let c='a'
    while c <= 'z'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw

    " Disable Esc key multimappings in insert mode
    set noesckeys

    " Maximize Python syntax highlighting
    " let python_highlight_all = 1

	" Movement
    " Cycle buffers in current split
    nmap <f1> :bprev<CR>
    nmap <f2> :bnext<CR>
    imap <f1> <esc>:bprev<CR>
    imap <f2> <esc>:bnext<CR>

    " Splits
    noremap <c-h> <C-w>h
    noremap <c-j> <C-w>j
    noremap <c-k> <C-w>k
    noremap <c-l> <C-w>l
    imap <c-h> <esc><c-h>
    imap <c-j> <esc><c-j>
    imap <c-k> <esc><c-k>
    imap <c-l> <esc><c-l>

    " Scroll window
    noremap <a-j> 3<c-e>3j
    noremap <a-k> 3<c-y>3k
    noremap <a-l> 3zl3l
    noremap <a-h> 3zh3h

    " Scroll page
    noremap <a-J> <c-f>
    noremap <a-K> <c-b>
    noremap <a-L> zL
    noremap <a-H> zH

    " Ignore .pyc files
    set wildignore+=*.pyc

    " Configure session creation
    set sessionoptions=buffers

    " Supertab {

        au FileType python set omnifunc=pythoncomplete#Complete
        let g:SuperTabDefaultCompletionType = "context"
        set completeopt=menuone,longest

    " }

    " Nerd Tree {

        map <leader>n :NERDTreeToggle<CR> | set guioptions-=L
        let NERDTreeIgnore = ['\~$', '\.pyc$']
        let g:NERDTreeWinSize = 40

        function! UpdateNERDTree(...)
            let stay = 0

            if(exists("a:1"))
                let stay = a:1
            end

            if exists("t:NERDTreeBufName")
                let nr = bufwinnr(t:NERDTreeBufName)
                if nr != -1
                    exe nr . "wincmd w"
                    exe substitute(mapcheck("R"), "<CR>", "", "")
                    if !stay
                        wincmd p
                    end
                endif
            endif
        endfunction

    " }

    " Refresh NERDTree and CtrlP
    map <leader>r :call UpdateNERDTree()<cr>:CtrlPClearCache<cr>

    " SQLUtilities {

        let g:sqlutil_align_comma=1

    " }

    " Powerline {

        " Use theme colors
        "let g:Powerline_theme="skwp"
        "let g:Powerline_colorscheme="skwp"
        let g:Powerline_symbols = 'fancy'

    " }

    " MiniBufExplorer {

        " Show buffer list at top of screen
        let g:miniBufExplSplitBelow=0

        " Show buffer list even if only one buffer is open
        let g:miniBufExplorerMoreThanOne=0
        
        " Do not show numbers in buffer list
        let g:miniBufExplShowBufNumbers=0

    " }

    " TagList {

        " Show all buffers in TagList
        let Tlist_Show_One_File=0

        " Hide fold indicators
        let Tlist_Enable_Fold_Column=0

        " Appear on left
        let Tlist_Use_Right_Window=0
        
        " Open with <leader>l
        map <leader>l :TlistToggle<CR>

    " }

    " CursorLienCurrentWindow {
    
        set cursorline

    " }

    " Source ~/.vimrc.local if it exists
    if filereadable($HOME."/.vimrc.local")
        source $HOME/.vimrc.local
    endif

" }

