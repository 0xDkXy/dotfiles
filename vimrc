" General
language en_US.utf8
set nu " show the line number
set relativenumber " show relative line number
syntax on
set nocompatible " disable compatibility to old-time vi
set showmode " 
set showcmd
set encoding=utf-8
set t_Co=256
"set mouse=a

" set auto indent and c-sytle indent
set autoindent
"set cindent "will be some wered operating 
if has('filetype')
    filetype indent plugin on "allow auto-indenting depending on file type
endif

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set cuc " cursorcolumn highlight
set cul "highlight the text line of the cursor with cursorLine
if !has('nvim')
    set culopt=both "have no idea about what effect it dose
endif

" set linebreak and textwidth
set wrap
" set textwidth=80
" set linebreak " I prefer enable linebreak but it makes many problems when programming

"minimal number of screen lines to keep above and below the cursor
set scrolloff=5 
set laststatus=2
set ruler "show the line and column number of the cursor position

set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set autochdir
set noerrorbells
set visualbell
set wildmenu
set wildmode=longest:list,full

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start


"colorscheme delek
"colorscheme torte
" the two lines that set hightlight of cursorline and cursorcolumn must be below
" the line that set the colorscheme
" or it won't work
hi CursorLine cterm=NONE ctermbg=darkgrey
hi CursorColumn cterm=NONE ctermbg=darkgrey

autocmd FileType make set noexpandtab 
