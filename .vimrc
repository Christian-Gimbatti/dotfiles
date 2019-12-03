set nocompatible              " be iMproved, required

" PLUGINS
set runtimepath^=~/.vim/plugged

"Auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Yggdroot/indentLine'

Plug 'vim-airline/vim-airline' "Status bar
Plug 'vim-airline/vim-airline-themes' "Applicable themes
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/BurntSushi/ripgrep'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' "Git tools
Plug 'mhinz/vim-signify'
" Plug 'ryanoasis/vim-devicons'
call plug#end()

" GENERAL
set backup " tell vim where to put its backup files
set backupdir=/tmp " tell vim where to put swap files
set dir=/tmp
set timeoutlen=1000        " speed vim up
set ttimeoutlen=0          " https://stackoverflow.com/questions/37644682/why-is-vim-so-slow/37645334
set ttyfast                " Rendering
set tw=500
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  " Disable Autocommenting

filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set clipboard=unnamed

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1


" KEYMAP
let $FZF_DEFAULT_COMMAND = 'rg --files '
set encoding=UTF-8
set updatetime=100

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
map <C-\> :NERDTreeToggle<CR>
nmap <C-E> :NERDTreeFind<CR>
nnoremap <C-P> :Files<CR>
nnoremap <C-F> :Rg<CR>
map * *``

" nnoremap <C-w> :tabclose<CR>
nnoremap <C-n> :tabnew<CR>
noremap <C-S-PageUp>  :-tabmove<CR>
noremap <C-S-PageDown>  :+tabmove<CR>
nnoremap <C-j> :move +1<CR>
nnoremap <C-k> :move -2<CR>



" THEME
color dracula

:set termguicolors
syntax on
set tabstop=4
set softtabstop=4
"" set expandtab       " tabs are spaces
set number
set showcmd
set cursorline
"" set cursorcolumn
let g:vim_jsx_pretty_colorful_config = 1
hi Cursor gui=reverse guibg=NONE guifg=NONE
hi Search guibg=Turquoise4 guifg=wheat
highlight IncSearch gui=underline,bold guifg=Turquoise3 guibg=White
hi treeDir guifg=#96CBFE guibg=#00ff00

autocmd InsertEnter,InsertLeave * set cul! " remove cursorline on insert mode
" highlight clear CursorLine " removes cursorline background

let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char_list = ['|', '¦', '┆', '┊']



" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
