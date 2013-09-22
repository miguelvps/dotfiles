call pathogen#infect()
call pathogen#helptags()

" matchpairs / matchtime
"    set undofile            " Enable persistent undo
"    set undodir=~/.vim/tmp/ " Store undofiles in a tmp dir
" nojoinspaces

" PT Keyboard layout
"set langmap+=º'
"set langmap+=ª~
"set langmap+=~`

" General options
set nocompatible " Use Vim settings, rather then Vi settings.
set nobackup " Do not keep a backup file.
set nowritebackup " Do not write backup file before saving.
set updatetime=2000 " Update time for autocommand events (ms).
" set directory=$VIM/swp// " List of directory names for the swap files.
set directory=$HOME/.vim/.swp//,. " List of directory names for the swap files.
"set viminfo+=n$VIM\\_viminfo " Set where the _viminfo file is to be saved.
"set viminfo+=% " Save and restore the buffer list.
set history=100 " A history of : commands and previous search patterns.
"set autochdir " Change to the current file directory.
set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
set clipboard^=unnamedplus " Set clipboard register to the unnamedplus register.
set mouse=a " Enable the use of the mouse in every mode.
filetype plugin indent on " Enable file type detection.
syntax on " Enable syntax highlighting.
set omnifunc=syntaxcomplete#Complete " Set the omni completion function.
set completeopt=menuone,longest,preview " Options for Insert mode completion.
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set hidden " Make buffers become hidden when abandoned.
set iskeyword+=_,$,%,# " None of these are word dividers.
set whichwrap=b,s,h,l,<,>,~,[,] " Allow all keys to move the cursor to the previous/next line.
set virtualedit=block " Allow virtual editing in Visual block mode.
set formatoptions+=rol
set switchbuf=useopen,usetab

if &termencoding == ""
    let &termencoding = &encoding  " Encoding used for the terminal.
endif
set encoding=utf-8 " Sets the character encoding used inside Vim.


" User Interface
set linespace=0 " Number of pixel lines inserted between characters.
set list " Display unprintable characters.
set listchars=tab:▸\ ,trail:¬ " Which and how to display unprintable characters.
set number " Print the line number in front of each line.
set numberwidth=1 " Minimal number of columns to use for the line number.
set report=0 " Threshold for reporting number of lines changed. (0 means always)
set showmatch " When a bracket is inserted, briefly jump to the matching one.
set showcmd " Show (partial) command in the last line of the screen.
set ruler " Show the line and column number of the cursor position.
set laststatus=2 " Always display the status line.
set statusline=[%n]\ %F\ \ %(%h%w\ \ %)%(%r%m\ \ %)[%{&ff}]\ \ [%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}]\ \ %y\ \ %=lin:%l/%L\ \ %-7(col:%c%V%)\ \ %P
set nowrap " Disable wrap.

" Window splitting
set noequalalways " Splitting a window will reduce the size of the current window and leave the other windows the same.
set splitright " Splitting a window will put the new window right of the current one.
set splitbelow " Splitting a window will put the new window below the current one.

" Command-line completion
set wildmenu " Enable command-line completion wild menu.
set wildmode=list:longest " Completion mode to use in wild menu.
set wildoptions=tagfile " A list of words that change how command line completion is done.
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.class,*.jpg,*.gif,*.png " A list of file patterns for wild menu to ignore.
set wildignorecase " When set case is ignored when completing file names and directories.

" Search
set incsearch " Incremental searching.
set hlsearch " Highlight search matches.
set ignorecase " Ignore case in search patterns.
set smartcase " Override ignorecase option if the search pattern contains upper case characters.
set gdefault " When on, the ":substitute" flag 'g' is default on.

" Indentation
set tabstop=4 " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4 " Number of spaces to use for each step of indent.
set softtabstop=4 " Number of spaces that a <Tab> counts for, so N spaces feel like tabs.
set shiftround " Round indent to multiple of shiftwidth option.
set expandtab " Use the appropriate number of spaces to insert a <TAB>.
set autoindent " Copy indent from current line when starting a new line.

" Vertical/Horizontal scroll off settings
set scrolloff=5 " Minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=10 " Minimal number of screen columns to keep to the left and right of the cursor.
set sidescroll=1 " The minimal number of columns to scroll horizontally.

" Color scheme
colorscheme xoria256 " my color scheme

" Graphical User Interface
"set guifont=consolas:h10 " Consolas font
set guifont=consolas\ 10 " Consolas font
set guioptions-=m " Remove menu bar
set guioptions-=T " Remove toolbar
set guioptions-=L " Remove left-hand scrollbar
set guioptions-=r " Remove right-hand scrollbar
set mousehide " Hide the mouse cursor when typing


" Plugin Settings

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

" bufexplorer Settings
let g:bufExplorerDefaultHelp=0 " Do not show default help.

" NERDTree Settings
let NERDTreeChDirMode=2 " When to change the current working directory
let NERDTreeHijackNetrw=0 " Open up a 'secondary' NERD tree instead of a netrw in the target window.
let NERDTreeIgnore=['\.pyc', '\~$'] " Files that NERD tree should ignore. (regex)
"let NERDTreeBookmarksFile=expand("$VIM\\NERDTreeBookmarks") " This is where bookmarks are saved.
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks") " This is where bookmarks are saved.
let NERDTreeMouseMode=3 " Single click will open any node.
let NERDTreeShowBookmarks=1 " Display bookmarks table.
let NERDTreeStatusline=" "
let NERDTreeWinSize=30 " Set the size of the NERD tree when it is loaded.

" NERDCommenter
let NERDCreateDefaultMappings=0 " If set to 0, none of the default mappings will be created.
let NERDSpaceDelims=1 " Add a space after comment delimeter
map <silent> <leader>c <plug>NERDCommenterToggle

" Tagbar
let g:tagbar_width = 30 " Width of the Tagbar window in characters.
let g:tagbar_compact = 1 " Hide short help at the top.
let g:tagbar_singleclick = 1 " Single click on a tag jumps to it.


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

" MAPS
map <silent> <F4> :NERDTreeToggle<CR>
map <silent> <F5> :TagbarToggle<CR>

nnoremap / :nohl<CR>/

" indent buffer
nnoremap <leader>indent gg=G``

"make Y and V consistent with C and D
nnoremap Y y$
nnoremap V v$
nnoremap vv V

" windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" tabs
nmap <silent> <C-Tab> :tabn<CR>
nmap <silent> <C-S-Tab> :tabp<CR>

" change cwd to current buffer directory
nmap <leader>cd :cd %:p:h<CR>

" start cmd in current working directory
nmap <silent> <leader>cmd :!start cmd<CR>

" keep visual selection when indent
vnoremap > >gv
vnoremap < <gv

" move by visual lines
noremap j gj
noremap k gk

" Delete trailing whitespace
nnoremap <silent> <leader>s :call <SID>DeleteTrailingWhitespace()<CR>
fun! <SID>DeleteTrailingWhitespace()
  if ! &bin
    let l:l = line(".")
    let l:c = col(".")
    silent! :%s/[\r \t]\+$//
    call histdel("search", -1)
    call cursor(l:l, l:c)
  endif
endfun

" save file with linux EOLs and no EOL in the last
command! W set binary | write | set nobinary


" change font size
nnoremap <silent> <C-kPlus> :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')<CR>:set guifont?<CR>
nnoremap <silent> <C-kMinus> :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')<CR>:set guifont?<CR>

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>


" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Settabs call Settabs()
function! Settabs()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction
function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction


" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

"if getcwd() == $VIMRUNTIME
"    cd $HOME " last because of ugly args bug with set encoding
"endif

autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
