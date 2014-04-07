" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

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
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomtom/tcomment_vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/syntastic'
" Bundle 'Lokaltog/vim-easymotion'
Bundle 'roman/golden-ratio'
" Bundle 'tpope/vim-dispatch'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'ciaranm/detectindent'
Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-speeddating'
Bundle 'mattn/calendar-vim'
Bundle 'vim-scripts/utl.vim'
Bundle 'jceb/vim-orgmode'
Bundle 'jnwhiteh/vim-golang'
Bundle 'itchyny/lightline.vim'
Bundle 'airblade/vim-rooter'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'jelera/vim-javascript-syntax'

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

  " Configure vim-dispatch
  autocmd FileType ruby let b:dispatch = 'ruby -c %'
  autocmd FileType java let b:dispatch = 'javac %'

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufRead *
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
  autocmd BufRead fugitive://* set bufhidden=delete
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
set foldmethod=manual
set foldcolumn=3
" Intelligently set the fold to syntax before opening a buffer to compute the
" syntax folds and then revert to manual to allow custom folds creation
" Also expands all the folds at the start
if has('autocmd')
  au BufReadPre * setlocal foldmethod=syntax
  au BufRead * set foldlevel=99
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
endif

function! MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub . ' :  ' . (v:foldend - v:foldstart) . ' lines '
endfunction
set foldtext=MyFoldText()

"remap toggle folding to the space bar
nnoremap <Space> za

"Remap Ctrl-C to go back to normal mode
inoremap <C-c> <Esc>
inoremap hh <Esc>

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
nnoremap <leader><Space> mz:%s/ *$//g<CR>:nohlsearch<CR>`z
"remove current highlighted text
nnoremap <silent> <leader>/ :nohlsearch<CR>
"map a quick recursive grep
nnoremap <leader>g :grep -R<Space>
"reindent the entire buffer
nnoremap <leader>= gg=G

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
"######## Special file configuration ########
"############################################
if has('autocmd')
  au BufRead Guardfile set ft=ruby
  au BufRead *.thor set ft=ruby
endif

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
let g:syntastic_javascript_checkers = ['jsl']

"############################################
"##############    YCM setup   ##############
"############################################
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"############################################
"########## DetectIndent setup ##############
"############################################
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

if has('autocmd')
  autocmd BufRead * :DetectIndent
endif

"############################################
"############ UltiSnips setup ###############
"############################################
" Forces Tab to be used for both YCM and UtilSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

if has('autocmd')
  au BufRead,BufNewFile * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
endif

"############################################
"############ Org-mode setup ################
"############################################
let g:org_indent=0
let g:org_todo_keywords = [['TODO(t)', 'WIP(w)', '|', 'DONE(d)'],
    \ ['REPORT(r)', 'BUG(b)', 'KNOWNCAUSE(k)', '|', 'FIXED(f)'],
    \ ['CANCELED(c)']]

"############################################
"############## Gist setup ##################
"############################################
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

"############################################
"############## Rooter setup ################
"############################################
let g:rooter_patterns = ['.root', '.git/', '.git', '_darcs/', '.hg/', '.bzr/', '.svn/']
"For a reason that I have not explained, this same autocmd in the vim-rooter
"plugin does not always work. Forcing it in there
if has('autocmd')
  augroup gxbRooter
    autocmd BufEnter *.rb,*.py,
          \*.html,*.haml,*.erb,
          \*.css,*.scss,*.sass,*.less,
          \*.js,*.rjs,*.coffee,
          \*.php,*.xml,*.yaml,
          \*.markdown,*.md
          \ :Rooter
  augroup END
endif

"############################################
"############ javascript setup ##############
"############################################
if has('autocmd')
  au BufRead *.js call JavaScriptFold()
endif

"############################################
"############ Lightline setup ###############
"############################################
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'mode_map': { 'c': 'NORMAL' },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'MyModified',
  \   'readonly': 'MyReadonly',
  \   'fugitive': 'MyFugitive',
  \   'filename': 'MyFilename',
  \   'fileformat': 'MyFileformat',
  \   'filetype': 'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode': 'MyMode',
  \ },
  \ 'separator': { 'left': '⮀', 'right': '⮂' },
  \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
  \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') : 
        \ '' != expand('%t') ? expand('%t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  return &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head()) ? '⭠ '.fugitive#head() : ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction
