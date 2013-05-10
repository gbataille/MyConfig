" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Pathogen activation to load plugins. Must be at the start of the file
" runtime bundle/pathogen/autoload/pathogen.vim
" execute pathogen#infect()
" execute pathogen#helptags()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off      "mandatory for vundle init

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'godlygeek/tabular'
Bundle 'kchmck/vim-coffee-script'
Bundle 'airblade/vim-rooter'
Bundle 'tomtom/tcomment_vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'roman/golden-ratio'
Bundle 'tpope/vim-dispatch'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'ciaranm/detectindent'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'

" Gist setup
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Mac specific config
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    " Put the Gist in the clipboard
    let g:gist_clip_command = 'pbcopy'
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

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
  " Configure vim-dispatch
  autocmd FileType ruby let b:dispatch = 'ruby -c %'
  autocmd FileType java let b:dispatch = 'javac %'

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Allows unsaved buffer to exist
set hidden
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set directory=~/.vim_swap//
set backupdir=~/.vim_backup//

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" show line number

if exists('+relativenumber')
  set relativenumber  "show line number relative to cursor position
endif

set ts=2		" set tabstop size
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set nowrap
set smartcase
set autowrite  " Writes on make/shell commands
set timeoutlen=500  " Time to wait after ESC (default causes an annoying delay)

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" colorscheme jellybeans
let g:solarized_diffmode="high"
colorscheme solarized
"let g:solarized_termcolors=256
set background=dark

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Add recently accessed projects menu (project plugin)
set viminfo^=!

set cf  " Enable error files & error jumping.
" set clipboard+=unnamed  " Yanks go on clipboard instead. Does not work in
" tmux
set history=256  " Number of things to remember in history.

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list

" Show $ at end of line and trailing space as ~
set lcs=tab:¬\ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

let mapleader = ","

nmap <silent> <leader>s :set spell!<CR>

if has("autocmd")
  "Automatically close fugitive buffer when browsing Git objects
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif
"Show branch name in the status bar
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set wildmenu
set wildmode=full
set wildignore=*.swp,*.back,*.class

"Shortcuts for Git actions
nnoremap <F3> :Gstatus<CR>
nnoremap <F4> :Gcommit<CR>

"Folding setup
set foldmethod=indent
set foldnestmax=3
set foldcolumn=3
set nofoldenable
"remap toggle folding to the space bar
nnoremap <Space> za

"Remap Ctrl-C to go back to normal mode
inoremap <C-c> <Esc>

"Remap Rails autocompletion
inoremap <C-a> <C-x><C-u>

"Remap CtrlP
nnoremap <leader>e :CtrlP<CR>
"Remap Tcomment
nmap <leader>c <c-_><c-_>
vmap <leader>c <c-_><c-_>
"map a buffer cycling shortcut
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>l :ls<CR>:b<Space>
"map a quick buffer close key
nnoremap <leader>q :BD<CR>
"map a quick window cycle key
nnoremap <leader>w <C-w><C-w>
"Remove spaces on empty lines
nnoremap <leader><Space> :%s/ *$//g<CR>
"remove current highlighted text
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Move between splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Displays the 80 columns in color for wrapping indication
if exists('+colorcolumn')
  set colorcolumn=80
endif

if $TERM == 'xterm-256color'
  "works with a terminal configured with solarized colors.
  highlight ColorColumn ctermbg=15
else
  highlight ColorColumn ctermbg=7
end

"############################################
"###########    Ctrlp setup   ###############
"############################################
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.o$\|\.dylib$\|\.d$\|\.dia$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"############################################
"###########    Syntastic setup   ###########
"############################################
let g:syntastic_check_on_open = 1

"############################################
"##############    YCM setup   ##############
"############################################
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"############################################
"########## DetectIndent setup ##############
"############################################
if has('autocmd')
  autocmd BufReadPost * :DetectIndent
endif
"############################################
"############ UltiSnips setup ###############
"############################################
" Forces Tab to be used for both YCM and UtilSnips
" let g:UltiSnipsExpandTrigger = '<c-l>'
" let g:UltiSnipsJumpForwardTrigger = '<c-l>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-p>'
" let g:UltiSnipsListSnippets = '<c-m>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"

function! g:UltiSnips_Complete()
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

if has('autocmd')
  au BufReadPost,BufNewFile * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
endif
