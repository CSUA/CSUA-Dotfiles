if version < 700
    set noloadplugins
endif

if 1 " Skip this file unless we have +eval

""" Settings
imap \ymd <C-R>=strftime("%Y.%m.%d")
imap \date <C-R>=strftime("%c")
imap \vimss :s/\s\+$//<CR>i

set nocompatible                    " Don't care about vi compatibility
set backupdir=~/.vim/backup         " Backup - specify directory
set directory=~/.vim/backup
set backup

""Display
set showcmd         " display incomplete commands at bottom of screen
set ruler           " show the cursor position all the time
set number          " show line numbers
set showmatch       " highlight matching parens
set scrolloff=3     " keep 3 lines above and below cursor

syntax on           " syntax highlighting
colorscheme default
set wildmenu
"set background=dark  "use if background is dark

""Windows
if exists(":tab")
    set switchbuf=useopen,usetab
else
    set switchbuf=useopen
endif

""Searching

set incsearch       " do incremental searching
set hlsearch        " highlight searches

""Editing

" So delete isn't broken
set backspace=indent,eol,start
set formatoptions-=tc " autoformatting is inconvenient
set tabstop=4       "width of tabs
set softtabstop=4
set shiftwidth=4    "indent width
set expandtab
set smarttab
set smartindent

" Folding stuff
set foldmethod=syntax
set foldlevelstart=99

""Misc.
set history=100     " keep 100 lines of command line history
set wildignore+=*.log,*.out,*.o    "completion ignores these extensions
set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov

"""Movement

nnoremap ; gt
nnoremap ' gT

" sensibly navigate wrapped lines
noremap j gj
noremap k gk

" Just a few emacs bindings...
inoremap <C-A> <Home>
inoremap <C-E> <End>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
nnoremap <C-A> <Home>
nnoremap <C-E> <End>
vnoremap <C-A> <Home>
vnoremap <C-E> <End>

" Don't use Ex mode, use Q for formatting
map Q gq

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    autocmd! bufwritepost .vimrc source %

    " Syntax Checking entire file
    " Usage: :make (check file)
    " :clist (view list of errors
    " :cn, :cp (move around list of errors)
    autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
    autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " cwd is always that of the current file
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        autocmd BufEnter * set fo-=r


        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    augroup END

    au! BufRead,BufNewFile *.phpt setfiletype php
    " Autocompletion
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete    " install CompleteCpp sometime, for cpp support

else

    set autoindent        " always set autoindenting on

endif " has("autocmd")


" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin,*.dat let &bin=1
    au BufReadPost *.bin,*.dat if &bin | %!xxd
    au BufReadPost *.bin,*.dat set ft=xxd | endif
    au BufWritePre *.bin,*.dat if &bin | %!xxd -r
    au BufWritePre *.bin,*.dat endif
    au BufWritePost *.bin,*.dat if &bin | %!xxd
    au BufWritePost *.bin,*.dat set nomod | endif
augroup END
endif
