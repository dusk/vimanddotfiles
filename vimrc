" ~/.vimrc

" Section: Options {{{1
" ---------------------

set nocompatible                  " must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

set autoindent
set autoread
set backspace=indent,eol,start    " Intuitive backspacing.
set cmdheight=2        " little more room down there

"set ttyfast
set modelines=0
set laststatus=2                  " Show the status line all the time
set list
set listchars=tab:▸\
set listchars+=trail:- " show trailing whitespace as -
"set listchars+=nbsp:+  " show non breaking spaces as +
set hidden                        " Handle multiple buffers better.
set ignorecase                    " Case-insensitive searching.
set foldmethod=marker  " set markers for folds
set smartcase                     " But case-sensitive if expression contains a capital letter.
set ruler                         " Show cursor position.
set number                        " Show line numbers.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set title                         " Set the terminal's title
set visualbell                    " No beeping.
set nobackup                      " Don't make a backup before overwriting a file.
set splitbelow         " split windows at bottom
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set tabstop=2                    " Global tab width.
set expandtab                    " Use spaces instead of tabs

set shiftround
set shiftwidth=2                 " And again, related.
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set smartindent
set softtabstop=2

set virtualedit=block  " allow virtual editing in visual block mode

set wildignore+=*~     " wildmenu: filetypes to ignore
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wrap                          " Turn on line wrapping.

" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%{exists('*rails#statusline')?rails#statusline():''}%{exists('*fugitive#statusline')?fugitive#statusline():''}%#ErrorMsg#%{exists('*SyntasticStatuslineFlag')?SyntasticStatuslineFlag():''}%*%=%-16(\ %l,%c-%v\ %)%P
" end Options
" }}}}1

let g:molokai_original = 0
colorscheme molokai

let mapleader=","

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

"nnoremap <leader>a :Ack

" Uncomment to use Jamis Buck's file opening plugin
"map <Leader>f :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;
"

"vnoremap ; :
"vnoremap : ;

nnoremap <leader><space> :noh<cr>
" match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
"autocmd BufNewFile,BufRead *_spec.rb compiler rspec

nnoremap j gj
nnoremap k gk
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_



"let g:LustyExplorerSuppressRubyWarning = 1



