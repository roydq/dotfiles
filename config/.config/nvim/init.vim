" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-bundler'
Plug 'roxma/vim-tmux-clipboard'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"if (!has("termguicolors"))
"  Plug 'vim-scripts/CSApprox'
"end

" Initialize plugin system
call plug#end()

" -- Behavior

" Background buffers
set hidden

" flip the default split directions
set splitright
set splitbelow

" only autocomplete using current file and included files
set complete-=i

" highlight trailing whitespace and tabs
set listchars=tab:»·,trail:-,extends:>,precedes:<,nbsp:+
set list

" make history big
set history=10000

" tabs
set smarttab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" auto indent
set autoindent
set copyindent

" search options
set incsearch
set hlsearch

" disable swap/backup files
set noswapfile
set nobackup
set nowritebackup

" fold on syntax
set foldenable
set foldmethod=syntax
set foldlevelstart=99

" vertical diff
set diffopt+=vertical

" make timeout not annoying
set timeoutlen=1000 ttimeoutlen=0

" auto-reload file if changed externally
set autoread

" always global replace
set gdefault

" use clipboard
set clipboard=unnamed

" make backspace not dumb
set backspace=indent,eol,start

" -- Visual
set novisualbell
set noerrorbells
set ruler
set laststatus=2
set showcmd
set showmatch
set number

" enable truecolor if terminal supports it
if (has("termguicolors"))
  set termguicolors
endif

" Color scheme
set background=dark
colorscheme ir_black

" Show lines that don't fit, instead of @
set display+=lastline

" Don't wrap
set nowrap

" Enable mouse
set mouse=a

" -- Plugin settings/bindings

" Enable deoplete
let g:deoplete#enable_at_startup = 1

" Toggle NERDTree with shift+tab
nnoremap <S-Tab> :NERDTreeToggle<CR>

" CtrlP fuzzy file finder
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'E'
nmap <Leader>f :CtrlPClearCache<CR>

" Tab to list buffers using CtrlP
nnoremap <Tab> :CtrlPBuffer<CR>

" Silver searcher instead of ack - for use with Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" -- Key Bindings

" use , as leader
let mapleader=","

" directional arrows for switching between splits
nnoremap <Up> <C-w><Up>
nnoremap <Down> <C-w><Down>
nnoremap <Left> <C-w><Left>
nnoremap <Right> <C-w><Right>

" ctrl+left and ctrl+right to switch between buffers
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>

" ,q and ,q! to close buffers without closing vim
nnoremap <Leader>q<CR> :Bclose<CR>
nnoremap <Leader>q!<CR> :Bclose!<CR>

" space to toggle folds
nnoremap <space> za

" ,cw to clear trailing whitespace
nnoremap <Leader>cw :%s/\s\+$//<CR>

" ,cd to cd current file's dir
nnoremap <Leader>cd :cd %:p:h<CR>

" ,p to paste from 0 buffer, since yanks always go to 0.
" makes it easier to paste the same thing multiple times.
noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p
