" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off      "mandatory for vundle init

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tomtom/tcomment_vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'ciaranm/detectindent'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-eunuch'
Plugin 'mattn/calendar-vim'
Plugin 'vim-scripts/utl.vim'
Plugin 'jceb/vim-orgmode'
Plugin 'jnwhiteh/vim-golang'
Plugin 'airblade/vim-rooter'
Plugin 'airblade/vim-gitgutter'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'mileszs/ack.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'bitc/vim-hdevtools'
Plugin 'raichoo/haskell-vim'
Plugin 'enomsg/vim-haskellConcealPlus'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-scripts/gitignore'
Plugin 'int3/vim-extradite'
Plugin 'majutsushi/tagbar'
Plugin 'lukaszkorecki/CoffeeTags'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'osyo-manga/vim-over'
" Typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
" Editorconfig
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tmhedberg/SimpylFold'
" Python
Plugin 'hynek/vim-python-pep8-indent'
" RGB
Plugin 'lilydjwg/colorizer'

call vundle#end()            " required
filetype plugin indent on    " required

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
let g:solarized_visibility = "low"
let g:solarized_contrast = "high"
let g:solarized_termcolors=16
let g:solarized_termtrans = 1
" colorscheme solarized
colorscheme base16-solarized-dark
let base16colorspace=256
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

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Regexp magic by default
set magic

set cf  " Enable error files & error jumping.
" tmux
set history=256  " Number of things to remember in history.

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list

" Show $ at end of line and trailing space as ~
set lcs=tab:¬\ ,trail:~,extends:>,precedes:<
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
set wildignore+=*.swp,*.back,*.class,*/tmp/*,*.o

"Shortcuts for Git actions
nnoremap <F3> :Gstatus<CR>
nnoremap <F4> :Gcommit<CR>

"Folding setup
set foldmethod=manual
set foldcolumn=3
set nofoldenable
" Intelligently set the fold to syntax before opening a buffer to compute the
" syntax folds and then revert to manual to allow custom folds creation
" Also expands all the folds at the start
if has('autocmd')
  au BufReadPre * setlocal foldmethod=syntax
  au BufRead * set foldlevel=99
  au BufRead * set foldlevelstart=99
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
endif

function! MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub . ' :  ' . (v:foldend - v:foldstart) . ' lines '
endfunction
set foldtext=MyFoldText()

"#############################
"####### SimplyFold ##########
"#############################
let g:SimpylFold_docstring_preview = 0

"remap toggle folding to the space bar
nnoremap <Space> za

"Remap Ctrl-C to go back to normal mode
inoremap <C-c> <Esc>
inoremap hh <Esc>

"Remap Rails autocompletion
inoremap <C-a> <C-x><C-u>

" Tags
" set tags+=gems.tags

"Remove spaces on empty lines
nnoremap <leader><Space> mz:%s/ *$//g<CR>:nohlsearch<CR>`z
"remove current highlighted text
nnoremap <silent> <leader>/ :nohlsearch<CR>
"reindent the entire buffer
nnoremap <leader>= gg=G
"Remap Tcomment
nmap <leader>c <c-_><c-_>
vmap <leader>c <c-_><c-_>
" shortcut for python doc
au BufNewFile,BufRead *.py
      \ nnoremap <leader>d :YcmCompleter GetDoc<CR>
"Remap CtrlP
nnoremap <leader>e :CtrlP<CR>
nnoremap <C-t> :CtrlPTag<CR>
"shortcut to GhcMod
au BufNewFile,BufRead *.hs
      \ nnoremap <leader>f :GhcModTypeClear<CR>
au BufNewFile,BufRead *.hs
      \ nnoremap <leader>g :GhcModType<CR>
"shortcut to Python goto definition
au BufNewFile,BufRead *.py
      \ nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
"map a buffer cycling shortcut
nnoremap <leader>l :ls<CR>:b<Space>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
"shortcut for replace with preview
nnoremap <leader>r :OverCommandLine<CR>:%s/
"shortcut for Tabularize
vnoremap <leader>t :Tabularize /
"map a quick buffer close key
nnoremap <leader>q :BD<CR>
"map a quick window cycle key
nnoremap <leader>w <C-w><C-w>

" Move between splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Displays the 100 columns in color for wrapping indication
if exists('+colorcolumn')
  set colorcolumn=100
endif
" Set it as autocmd to override the ft autocmd from some plugins
au BufRead * set textwidth=100

if $TERM == 'xterm-256color'
  "works with a terminal configured with base16 solarized colors.
  highlight ColorColumn ctermbg=238
  highlight SignColumn ctermbg=19
else
  highlight ColorColumn ctermbg=8
  highlight SignColumn ctermbg=8
end

"################################
"####### :Sw - Sudo save ########
"################################
command! -nargs=0 Sw w !sudo tee % > /dev/null

"######################################################################
"####### Qargs - transform the quickfix list into an args list ########
"######################################################################
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

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
let g:ctrlp_root_markers = ['.root']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|dist$\|bower_components$\|node_modules$\|\.docsets$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.o$\|\.dylib$\|\.d$\|\.dia$\|Icon$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"############################################
"###########    Syntastic setup   ###########
"############################################
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_javascript_checkers = ['jsl']

let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_typescript_tsc_fname = ''

let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']
let g:syntastic_haskell_hdevtools_arg = '-g-isrc -g-Wall'

let g:syntastic_python_python_exec = 'python'
let g:syntastic_python_checkers = ['flake8', 'pylint', 'python']
let g:syntastic_python_pylint_args = '--rcfile=' . findfile(".pylintrc", ".;")
let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'

let g:syntastic_html_tidy_exec = '/usr/local/Cellar/tidy-html5/5.0.0/bin/tidy'
let g:syntastic_html_tidy_ignore_errors = []
let g:syntastic_html_tidy_quiet_messages = {
  \ "regex": '\m^<.*> is not recognized!'
  \ }

"############################################
"##############    YCM setup   ##############
"############################################
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = {
  \ 'typescript': ['.'],
  \ 'haskell': ['.']
  \ }
" Oddly enough, it seems that the semantic completion triggers for ruby while
" YCM has no logic to handle it. Gives odd results
let g:ycm_filetype_specific_completion_to_disable = {
  \ 'gitcommit': 1,
  \ 'ruby': 1
  \ }

"############################################
"##############    Neco-GHC    ##############
"############################################
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"############################################
"########## DetectIndent setup ##############
"############################################
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

if has('autocmd')
  autocmd BufRead * :DetectIndent

  " Python special setup
  au FileType python,htmldjango set tabstop=4
  au FileType python,htmldjango set softtabstop=4
  au FileType python,htmldjango set shiftwidth=4
  au FileType python,htmldjango set expandtab
  au FileType python,htmldjango set autoindent
  au FileType python,htmldjango set fileformat=unix

  " Haskell special setup
  au FileType haskell set tabstop=2
  au FileType haskell set softtabstop=2
  au FileType haskell set shiftwidth=2
  au FileType haskell set expandtab
  au FileType haskell set autoindent
  au FileType haskell set fileformat=unix
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
  au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
endif
"
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
          \*.txt
          \*.hs
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
"########### coffeescript setup ##############
"############################################
if has('autocmd')
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
endif

"############################################
"############ json pretty-print #############
"############################################
function! DoPrettyJson()
  clone the current buffer, we want a scratch buffer.
  badd %
  setlocal buftype=nofile bufhidden=wipe nobuflisted
  noswapfile nowrap
  silent %!python -m json.tool
  silent %<
endfunction
command! Json call DoPrettyJson()

"############################################
"############ XML pretty-print ##############
"############################################
function! DoPrettyXML()
  " clone the current buffer, we want a scratch buffer.
  badd %
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  "read !xml-parser % " This is for Mac os x
  silent %!tidy -xml -utf8 -i -q -
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  "silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! Xml call DoPrettyXML()

"############################################
"########### vim-indent-guides ##############
"############################################

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=8

"############################################
"########### haskell-vim setup ##############
"############################################
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1

let g:haskell_indent_if = 2
let g:haskell_indent_case = 4
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 2
let g:haskell_indent_in = 2

" To let NecoGHC run the omnifunc
let g:haskellmode_completion_ghc = 0

"############################################
"################# tagbar ###################
"############################################
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

"############################################
"############### CoffeeTags #################
"############################################
" let g:CoffeeAutoTagDisabled=0     " Disables autotaging on save (Default: 0 [false])
" let g:CoffeeAutoTagFile=<filename>       " Name of the generated tag file (Default: ./tags)
" let g:CoffeeAutoTagIncludeVars=<0 or 1>  " Includes variables (Default: 0 [false])
" let g:CoffeeAutoTagTagRelative=<0 or 1>  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

"############################################
"################# airline ##################
"############################################
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

"############################################
"############### hdevtools ##################
"############################################

au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

"############################################
"############## editorconfig ################
"############################################

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

"############################################
"############### tsuquyomi ##################
"############################################
let g:tsuquyomi_disable_quickfix = 1

"########################
"####### Python #########
"########################
" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1

"############################################
"############### gitgutter ##################
"############################################
let g:gitgutter_override_sign_column_highlight = 0
