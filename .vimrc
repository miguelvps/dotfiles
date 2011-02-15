call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" PT Keyboard layout
"set langmap+=º'
"set langmap+=ª~
"set langmap+=~`

" General options:
    set nocompatible " Use Vim settings, rather then Vi settings.
    set nobackup " Do not keep a backup file.
    set nowritebackup " Do not write backup file before saving.
    set updatetime=2000 " Update time for autocommand events (ms).
    " set directory=$VIM/swp// " List of directory names for the swap files.
    " set viminfo+=n$VIM\\_viminfo " Set where the _viminfo file is to be saved.
    " set viminfo+=% " Save and restore the buffer list.
    set history=100 " A history of : commands and previous search patterns.
    " set autochdir " Change to the current file directory.
    set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
    set clipboard+=unnamed " Set clipboard register to the unnamed register.
    set mouse=a " Enable the use of the mouse in every mode.
    filetype plugin indent on " Enable file type detection.
    syntax on " Enable syntax highlighting.
    set omnifunc=syntaxcomplete#Complete " Set the omni completion function.
    set completeopt=menuone,longest " Options for Insert mode completion.
    " set infercase " Infer case when doing keyword completion.
    set hidden " Make buffers become hidden when abandoned.
    set iskeyword+=_,$,%,# " None of these are word dividers.
    set whichwrap=b,s,h,l,<,>,~,[,] " Allow all keys to move the cursor to the previous/next line.
    set virtualedit=block
    set formatoptions+=rol
    set switchbuf=useopen,usetab

    if has("multi_byte")
        if &termencoding == ""
            let &termencoding = &encoding
        endif
        set encoding=utf-8
    endif


" ui:
    set linespace=0 " Number of pixel lines inserted between characters.
    set list " Display unprintable characters.
    set listchars=tab:▸\ ,trail:¬ " Which and how to display unprintable characters.
    set number " Print the line number in front of each line.
    set numberwidth=1 " Minimal number of columns to use for the line number.
    set report=0 " Threshold for reporting number of lines changed. (0 means always)
    set showmatch " When a bracket is inserted, briefly jump to the matching one.
    set wildmenu " Enable command-line completion wild menu.
    set wildmode=list:longest " Completion mode to use in wild menu.
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " A list of file patterns for wild menu to ignore.
    set showcmd " Show (partial) command in the last line of the screen.
    set ruler " Show the line and column number of the cursor position.
    set laststatus=2 " Always display the status line.
    set statusline=[%n]\ %F\ \ %(%h%w\ \ %)%(%r%m\ \ %)[%{&ff}]\ \ [%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}]\ \ %y\ \ %=lin:%l/%L\ \ %-7(col:%c%V%)\ \ %P
    set nowrap " Disable wrap.
    " set noequalalways
    " set guitablabel=%M\ %t

" search:
    set incsearch " Incremental searching.
    set hlsearch " Highlight search matches.
    set ignorecase " Ignore case in search patterns.
    set smartcase " Override ignorecase option if the search pattern contains upper case characters.
    set gdefault " When on, the ":substitute" flag 'g' is default on.

" Tab
    set tabstop=4 " Number of spaces that a <Tab> in the file counts for.
    set shiftwidth=4 " Number of spaces to use for each step of indent.
    set softtabstop=4 " Number of spaces that a <Tab> counts for, so N spaces feel like tabs.
    set shiftround " Round indent to multiple of shiftwidth option.
    set expandtab " Use the appropriate number of spaces to insert a <TAB>.

" Vertical/Horizontal scroll off settings
    set scrolloff=5 " Minimal number of screen lines to keep above and below the cursor.
    set sidescrolloff=10 " Minimal number of screen columns to keep to the left and right of the cursor.
    set sidescroll=1 " The minimal number of columns to scroll horizontally.

" Sessions
    " set sessionoptions+=localoptions " Options and mappings local to a window or buffer (not global values for local options).
    set sessionoptions+=resize " Size of the Vim window: 'lines' and 'columns'.
    set sessionoptions+=winpos " Position of the whole Vim window.


" Plugin Settings {
    " MiniBufExplorer Settings {
        let g:miniBufExplSplitToEdge = 0 " Force window to open up at the edge of the screen.
        let g:miniBufExplMaxSize = 1 " Set Maximum lines height.
        " let g:miniBufExplorerMoreThanOne = 0 " Stop from opening automatically until more than one buffer.
        let g:miniBufExplMapWindowNavVim = 1 " Enable mapping of Control + Direction to window movement commands.
        let g:miniBufExplMapWindowNavArrows = 1 " Enable mapping of Control + Arrows to window movement commands.
        let g:miniBufExplMapCTabSwitchBufs = 1 " Enable <C-TAB> and <C-S-TAB> to iterate through buffers.
        let g:miniBufExplUseSingleClick = 1 " Enable single click on buffers rather than double click.
        let g:miniBufExplModSelTarget = 1 " Force MBE to place buffers into windows that do not have a nonmodifiable buffer.
        "hi link MBENormal % " buffers that have NOT CHANGED and NOT VISIBLE
        "hi link MBEChanged # " buffers that have CHANGED and NOT VISIBLE
        "hi link MBEVisibleNormal " buffers that have NOT CHANGED and are VISIBLE
        "hi link MBEVisibleChanged Error " buffers that have CHANGED and are VISIBLE
    " }
    " Command-T {
        let g:CommandTMaxHeight = 20
        nmap <silent> <Leader>t :CommandT<CR>
        nmap <silent> <Leader>r :CommandTFlush<CR>
    " }
    " bufexplorer Settings {
        let g:bufExplorerDefaultHelp=0       " Do not show default help.
        let g:bufExplorerShowRelativePath = 1  " Show relative paths.
    " }
    " NERDTree Settings {
        let NERDTreeChDirMode=2 " When to change the current working directory
        let NERDTreeHijackNetrw=0 " Open up a 'secondary' NERD tree instead of a netrw in the target window.
        let NERDTreeIgnore=['\.pyc', '\~$'] " Files that NERD tree should ignore. (regex)
        " let NERDTreeBookmarksFile=expand("$VIM\\NERDTreeBookmarks") " This is where bookmarks are saved.
        let NERDTreeMouseMode=3 " Single click will open any node.
        let NERDTreeShowBookmarks=1 " Display bookmarks table.
        let NERDTreeStatusline=" "
        let NERDTreeWinSize=30 " Set the size of the NERD tree when it is loaded.
    " }
    " NERDCommenter {
        let NERDCreateDefaultMappings=0 " If set to 0, none of the default mappings will be created.
        map <silent> <leader>c <plug>NERDCommenterToggle
    " }
    " TagList Settings {
        let Tlist_Auto_Open = 0 " Open the taglist window when Vim starts.
        let Tlist_Compact_Format = 0 " Remove extra information and blank lines from the taglist window.
        " let Tlist_Ctags_Cmd="\"".expand("$VIM\\ctags").".exe\"" " Specifies the path to the ctags utility.
        let Tlist_Display_Prototype = 0 " Show prototypes and not tags in the taglist window.
        let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
        let Tlist_Enable_Fold_Column = 0 " Show the fold indicator column in the taglist window.
        let Tlist_Exist_OnlyWindow = 1 " Close Vim if the taglist is the only window.
        let Tlist_File_Fold_Auto_Close = 1 " Close tag folds for inactive buffers.
        let Tlist_Inc_Winwidth = 0 " Don't resize windows
        let Tlist_Show_One_File = 0 "Show tags for the current buffer only.
        let Tlist_Sort_Type = "name" " Sort method used for arranging the tags.
        let Tlist_Use_Right_Window = 1 " Place the taglist window on the right side.
        let Tlist_Use_SingleClick = 1 " Single click on a tag jumps to it.
        let Tlist_Win_Width=30 " Vertically split taglist window width.

        " Language Specifics {
            " let tlist_aspjscript_settings = 'asp;f:function;c:class' " just functions and classes please
            " let tlist_aspvbs_settings = 'asp;f:function;s:sub' " just functions and subs please
            " let tlist_php_settings = 'php;c:class;d:constant;f:function' " don't show variables in freaking php
            " let tlist_vb_settings = 'asp;f:function;c:class' " just functions and classes please
        " }
    " }
" }


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


" GUI Settings {
if has("gui_running") || &t_Co >=256
    " Basics {
        colorscheme xoria256 " my color scheme
        "Invisible character colors
        highlight NonText guifg=#4a4a59
        highlight SpecialKey guifg=#4a4a59
        "set guifont=consolas:h10 "consolas font
        set guifont=consolas "consolas font
        set guioptions-=m " Remove menu bar
        set guioptions-=T " Remove toolbar
        set guioptions-=L " Remove left-hand scrollbar
        set guioptions-=r " Remove right-hand scrollbar
        set mousehide " hide the mouse cursor when typing
    " }
endif
" }

" MAPS
map <silent> <F4> :NERDTreeToggle<CR>
map <silent> <F5> :TlistToggle<CR>

nnoremap / :nohl<CR>/

" indent buffer
nnoremap <leader>indent gg=G``

nnoremap <leader>ba :bufdo Bclose<CR>

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
map <leader>cd :cd %:p:h<CR>

" start cmd in current working directory
map <silent> <leader>cmd :!start cmd<CR>

" keep visual selection when indent
vnoremap > >gv
vnoremap < <gv

" move by visual lines
noremap j gj
noremap k gk


" Remove trailing whitespace
nnoremap <silent> <leader>s :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>``

" save file with linux EOLs and no EOL in the last
command! W set binary | write | set nobinary


" change font size
nnoremap <silent> <C-kPlus> :let &guifont=substitute(&guifont,':h\zs\d\+','\=eval(submatch(0)+1)','')<CR>:set guifont?<CR>
nnoremap <silent> <C-kMinus> :let &guifont=substitute(&guifont,':h\zs\d\+','\=eval(submatch(0)-1)','')<CR>:set guifont?<CR>

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


" Sets up omni-completion for a django project in a virtualenv.
"
" Copy this file to YOUR_VIRTUALENV_DIR/.vimrc and add the following to your
" ~/.vimrc file:
if filereadable($VIRTUAL_ENV . '/virtualenv.vim')
    source $VIRTUAL_ENV/virtualenv.vim
endif
"
" Thanks, Daniel!
" http://blog.roseman.org.uk/2010/04/21/vim-autocomplete-django-and-virtualenv/


"if getcwd() == $VIMRUNTIME
"    cd $HOME " last because of ugly args bug with set encoding
"endif
