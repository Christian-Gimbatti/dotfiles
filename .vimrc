set nocompatible              " be iMproved, required

" PLUGINS
set runtimepath^=~/.vim/plugged

"Auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

  CocInstall coc-snippets
endif

call plug#begin('~/.vim/plugged')
" Plug 'sheerun/vim-polyglot'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle','NERDTreeFind']}
Plug 'https://github.com/BurntSushi/ripgrep'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' "Git tools
Plug 'mhinz/vim-signify'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'stevearc/vim-arduino'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

" GENERAL
set hidden
set backup " tell vim where to put its backup files
set backupdir=/tmp " tell vim where to put swap files
set dir=/tmp
set timeoutlen=1000        " speed vim up
set ttimeoutlen=0          " https://stackoverflow.com/questions/37644682/why-is-vim-so-slow/37645334
set ttyfast                " Rendering
set tw=500
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  " Disable Autocommenting

filetype indent on      " load filetype-specific indent files
set smartindent  
set wildmenu            " visual autocomplete for command menu
set wildignorecase
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set clipboard=unnamedplus

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1


" KEYMAP
let mapleader = ","
set encoding=UTF-8
set updatetime=300

let $FZF_DEFAULT_COMMAND = 'rg --files '

" general
nnoremap <C-B> :Buffers<CR>
nnoremap <C-G> :Gstatus<CR>

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
map <C-\> :NERDTreeToggle<CR>
nmap <C-E> :NERDTreeFind<CR>
nnoremap <C-P> :Files<CR>
" nnoremap <C-F> :Rg<CR>
map * *``

" nnoremap <C-w> :tabclose<CR>
" nnoremap <C-n> :tabnew<CR>
noremap <C-S-PageUp>  :-tabmove<CR>
noremap <C-S-PageDown>  :+tabmove<CR>

" line movement
nnoremap <C-j> :move +1<CR>
nnoremap <C-k> :move -2<CR>
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nmap <leader>* *cgn
nnoremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>


" screen movement 
nnoremap <leader>h <C-W>h
nnoremap <leader>l <C-W>l
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k

nnoremap <leader>H <C-W>H
nnoremap <leader>L <C-W>L
nnoremap <leader>J <C-W>J
nnoremap <leader>K <C-W>K

" map foward jump cause remapping of tab/c-i
nnoremap <leader><c-O> <c-I>

" tab indent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

nnoremap <leader>hp :SignifyHunkDiff<CR>
nnoremap = :SignifyHunkDiff<CR>
nnoremap <leader>hu :SignifyHunkUndo<CR>
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>


" custom text object line
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

autocmd ColorScheme * hi multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
autocmd CursorHold * silent call CocActionAsync('highlight')


let g:UltiSnipsExpandTrigger="<space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" THEME
color dracula

:set termguicolors
set signcolumn=yes
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction





" COC

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <F2> <Plug>(coc-rename)
nmap <leader>rn <Plug>(coc-rename)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:coc_snippet_next = '<tab>'

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
