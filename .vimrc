" ~/.vimrc
" vim:set ft=vim et tw=78 sw=2:
" mostly stolen from tpope

" Section: Options {{{1
" ---------------------

set nocompatible       " this is vim, not vi: set this first

filetype plugin indent on

"set autoindent        " uses the indent from the previous line
set autoread           " detect changes outside of vim
set backspace=2        " make backspaces normal
"set backup            " backup files are good
"set backupskip+=*.tmp " don't backup .tmp files
set cmdheight=2        " little more room down there
set complete-=i        " searching includes can be slow
set display=lastline   " always show the last line
set foldmethod=marker  " set markers for fols
set incsearch          " incremental search
set laststatus=2       " always show status line
set lazyredraw         " don't redraw screen after a macro
set listchars=tab:>\   " show tabs as >
set listchars+=trail:- " show trailing whitespace as -
set listchars+=nbsp:+  " show non breaking spaces as +
set scrolloff=1        " always keep one line above and below cursor
set showcmd            " show (partial) command in status line
set showmatch          " show matching brackets
set smartcase          " case insensitive searches become sensitive with capitals
set smarttab           " sw at the start of the line, sts everywhere else
set splitbelow         " split windows at bottom
set suffixes+=.dvi     " lower priority in wildcards
set t_Co=16            " set 16bit color
set ttimeoutlen=50     " make esc work faster
set visualbell         " flash instead of beep
set virtualedit=block  " allow virtual editing in visual block mode
set wildmenu           " show file matches as they appear on command line
set wildmode=longest:full,full " wildmenu: complete till longest common string
set wildignore+=*~     " wildmenu: filetypes to ignore

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%#ErrorMsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%=%-16(\ %l,%c-%v\ %)%P
" end Options
" }}}1
" Section: Plugin Settings {{{1
" -----------------------------
if has("eval")
  let g:is_bash = 1
  let g:lisp_rainbow = 1
  " let g:rubyindent_match_parentheses = 0
  let g:ruby_minlines = 500
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_rails = 1
  let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

  let g:NERDCreateDefaultMappings = 0
  let g:NERDSpaceDelims = 1
  let g:NERDShutUp = 1
  let g:NERDTreeHijackNetrw = 0
  let g:ragtag_global_maps = 1
  let g:space_disable_select_mode = 1
  let g:syntastic_enable_signs = 1
  let g:syntastic_auto_loc_list = 1
  let g:VCSCommandDisableMappings = 1
  let g:surround_{char2nr('-')} = "<% \r %>"
  let g:surround_{char2nr('=')} = "<%= \r %>"
  let g:surround_{char2nr('8')} = "/* \r */"
  let g:surround_{char2nr('s')} = " \r"
  let g:surround_{char2nr('^')} = "/^\r$/"
  let g:surround_indent = 1
endif
" end Plugin Settings
" }}}1

" end Commands
" }}}1
" Section: Mappings {{{1
" ----------------------
"
inoremap <C-C> <Esc>`^
inoremap <C-A> <Home>
inoremap <C-E> <End>

map <C-j> <C-W><Down>
map <C-k> <C-W><Up>
map <C-h> <C-W><Left>
map <C-l> <C-W><Right>

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" end Mappings
" }}}1
" }}}1
" Section: Visual {{{1
" --------------------
syntax on
set list
set hlsearch
colorscheme vividchalk
" end Visual
" }}}1
