set nocompatible " be iMproved, required

" --- PLUGGED ---
set runtimepath^=~/.vim/plugged

"Auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

  CocInstall coc-ultisnips
endif


" --- PLUGINS CONFIG ---
let g:vimwiki_map_prefix = '<Leader><Leader>'
let g:neoterm_default_mod = ''
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:AutoPairsMapCh = 0
let $FZF_DEFAULT_COMMAND = 'rg --files '
let g:http_client_bind_hotkey=0

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1

" --- PLUGINS --- 
call plug#begin('~/.vim/plugged')
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
Plug 'aquach/vim-http-client'
Plug 'luochen1990/rainbow'

Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'
Plug 'kassio/neoterm'
call plug#end()


" GENERAL
set hidden " buffer hidden if abandoned
set backup " tell vim to use backup file of current
set backupdir=/tmp " tell vim where to put backup files
set dir=/tmp " tell vim where to put swap files
set timeoutlen=1000	       " timeout kbd sequence
set ttimeoutlen=0          " https://stackoverflow.com/questions/37644682/why-is-vim-so-slow/37645334
set ttyfast                " Rendering (only for vim)
set tw=500
set encoding=UTF-8
set updatetime=300
set shortmess+=c " dont show messages of insert mode
set splitright
set splitbelow
filetype indent on      " load filetype-specific indent files
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  " Disable Autocommenting
set smartindent  
set wildmode=longest,list,full
set wildignorecase
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set ignorecase          " ignore case when searching
set smartcase           " if searching with Uppercase => ignorecase
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set clipboard=unnamedplus
set laststatus=2 " for showing lightline
set noshowmode " dont show mode on status line
set tags=./tags,tags;
" multiple cursors colors
autocmd ColorScheme * hi multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
autocmd CursorHold * silent call CocActionAsync('highlight') " highlight word on cursor

" --- THEME ---
color dracula
syntax on
set termguicolors
set signcolumn=yes
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number
set showcmd
set cursorline
hi Cursor gui=reverse guibg=NONE guifg=NONE
hi Search guibg=Turquoise4 guifg=wheat
hi IncSearch gui=underline,bold guifg=Turquoise3 guibg=White
hi treeDir guifg=#96CBFE guibg=#00ff00
"" set expandtab       " tabs are spaces
"" set cursorcolumn
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:lightline = {
      \ 'colorscheme': 'darcula',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             ['gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead'
	\ },
    \ }




" --- ROOT CHANGES ---
" dont close vim if last window :q, use :qa to cose vim
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
" * dont go to next word
map * *``
" makes window resizing mappings smoother
nmap          <C-W>+     <C-W>+<SID>ws
nmap          <C-W>-     <C-W>-<SID>ws
nn <script>   <SID>ws+   <C-W>+<SID>ws
nn <script>   <SID>ws-   <C-W>-<SID>ws

nmap          <C-W>>     <C-W>><SID>ws
nmap          <C-W><     <C-W><<SID>ws
nn <script>   <SID>ws>   <C-W>><SID>ws
nn <script>   <SID>ws<   <C-W><<SID>ws

nmap          <SID>ws    <Nop>
" macros over selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction


" --- TEXT OBJECTS ---
" line text object
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>


" --- LEADER ---
let mapleader = ","
let maplocalleader = "/"


" --- CUSTOM COMANDS ---
" snippets
function! Snip()
	execute(":vsplit ~/.vim/UltiSnips/".&filetype.".snippets")
endfunction
command! Snip call Snip()

command! Ve execute ":edit ~/.vimrc"
command! Vs execute ":source ~/.vimrc"

command! StartWeb execute("1T <C-c> cd /home/chris/src/selio/selioweb/docker && docker-compose up")
nnoremap <leader><leader>rw :StartWeb<cr>



" --- NORMAL MAPPINGS ---
" select all
nnoremap <C-a> ggVG$
" write
nnoremap <C-s> :w<CR>
nnoremap <leader>w :w<CR>
" close
nnoremap <leader>q :q<CR>
" open last buffer
nnoremap <leader>B :b#<CR>
" open buffers
nnoremap <leader>b :Buffers<CR>
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" map foward jump cause remapping of tab/c-i
nnoremap <leader><c-o> <c-I>
" tree
noremap <C-\> :NERDTreeToggle<CR>
noremap <C-E> :NERDTreeFind<CR>
" file search
nnoremap <C-P> :Files<CR>
" change search
nmap <leader>* *cgn
" line movement
nnoremap <C-j> :move +1<CR>
nnoremap <C-k> :move -2<CR>
" tab indent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
" navigation & layout
noremap <C-S-PageUp>  :-tabmove<CR>
noremap <C-S-PageDown>  :+tabmove<CR>
nnoremap <C-h> H
nnoremap <C-l> L
nnoremap <leader>j J
nnoremap <leader>k K
nnoremap H ^
nnoremap L $
nnoremap K <C-u>
nnoremap J <C-d>
nnoremap Y Y$
nnoremap U <C-r>
nnoremap Q @q
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>s :split<cr>
" window moving and navigation
if has("nvim")
	nnoremap <M-h> <C-W>h
	nnoremap <M-l> <C-W>l
	nnoremap <M-j> <C-W>j
	nnoremap <M-k> <C-W>k

	nnoremap <M-H> <C-W>H
	nnoremap <M-L> <C-W>L
	nnoremap <M-J> <C-W>J
	nnoremap <M-K> <C-W>K
else
	nnoremap <esc>h <C-W>h
	nnoremap <esc>l <C-W>l
	nnoremap <esc>j <C-W>j
	nnoremap <esc>k <C-W>k

	nnoremap <esc>H <C-W>H
	nnoremap <esc>L <C-W>L
	nnoremap <esc>J <C-W>J
	nnoremap <esc>K <C-W>K
endif
" search
nnoremap <leader>f :Rg 
" git
nnoremap <C-g> :Gstatus<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Gclog<CR>
nnoremap <leader>gfl :Gclog -- %<CR>
nnoremap <leader>gb :Git blame<CR>

nnoremap <leader>gd :SignifyHunkDiff<CR>
nnoremap = :SignifyHunkDiff<CR>
nnoremap <leader>gu :SignifyHunkUndo<CR>
" quickfix menu
nnoremap ]q :cn<cr>
nnoremap [q :cp<cr>
" COC
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>


" --- INSERT MAPPINGS ---
" navigation
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" s-tab
" inoremap <S-Tab> <C-D>
" write
inoremap <C-s> <esc>:w<CR>


" --- VISUAL MAPPINGS ---
" write
vnoremap <C-s> <esc>:w<CR>
" line movement
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" tab indent
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" --- COMMAND MAPPINGS ---
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-p> <C-r>"


" --- TERMINAL MAPPINGS ---
" if has("nvim")
"   au! TermOpen * tnoremap <Esc> <c-\><c-n>
"   au! FileType fzf tunmap <Esc>
" endif

" --- LOCAL MAPPINGS ---
autocmd FileType http nnoremap <buffer> <localleader>tt :HTTPClientDoRequest<CR>
