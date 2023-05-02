let mapleader = "\<Space>"
let maplocalleader = "\\"

" To install VimPlug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

	" GUI enhancements
" 	Plug 'sainnhe/everforest'
	Plug 'joshdick/onedark.vim'
	Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" 	Plug 'itchyny/lightline.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'machakann/vim-highlightedyank'
	Plug 'junegunn/goyo.vim'

	Plug 'godlygeek/tabular'
	Plug 'preservim/vim-markdown'

	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

set nocompatible " Stop trying to make vi happen. It's not going to happen.


syntax enable
filetype plugin indent on

" Finding files
set path+=**
set wildmenu

set autoindent
set timeoutlen=300
set encoding=utf-8
set noshowmode

set undodir=~/.vimdid
set undofile

set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab
set nowrap

set hls
set incsearch
set lazyredraw
set relativenumber
set number
set colorcolumn=80
set mouse=a

set cmdheight=2
set updatetime=300

set listchars=tab:ﲒ\ ,nbsp:¬,extends:»,precedes:«,trail:•
set list

" Key bindings
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP
inoremap kjk <esc>
inoremap jfj <esc>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Tag bindings
" * <leader>ctag for generating ctags
" * <leader>t for jumping to a tag
" * <leader>p to pop down the tag stack
nnoremap <leader>uc :!~/ctags/bin/ctags -R .<cr>
nnoremap <leader>t <c-]>
nnoremap <leader>p :pop<cr>

nnoremap <leader>v <c-w>v
nnoremap H ^
nnoremap L $
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>
nnoremap <Left>  <nop>
nnoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>
nnoremap <leader><Tab> :b#<cr>

augroup filetype_markdown
	autocmd!
	autocmd FileType markdown setlocal tabstop=4
	autocmd FileType markdown setlocal softtabstop=4
	autocmd FileType markdown setlocal shiftwidth=4
	autocmd FileType markdown setlocal expandtab
augroup END

augroup filetype_yaml
	autocmd!
	autocmd Filetype yaml setlocal tabstop=2
	autocmd FileType yaml setlocal softtabstop=2
	autocmd FileType yaml setlocal shiftwidth=2
	autocmd FileType yaml setlocal expandtab
augroup END

augroup filetype_python
	autocmd!
	autocmd FileType python nnoremap <buffer> <leader>/ 0i# <esc>j0
	autocmd FileType python iabbrev <buffer> true True
	autocmd FileType python iabbrev <buffer> false False
	autocmd FileType python iabbrev <buffer> testes <esc>:read $HOME/.config/nvim/snippets/unittest_snip.py<cr>jjeea
	autocmd FileType markdown setlocal tabstop=4
	autocmd FileType markdown setlocal softtabstop=4
	autocmd FileType markdown setlocal shiftwidth=4
	autocmd FileType markdown setlocal expandtab
augroup END

augroup filetype_vim
	autocmd!
	autocmd FileType vim nnoremap <buffer> <leader>/ 0i" <esc>j0
augroup END

augroup filetype_bash
	autocmd!
	autocmd FileType sh nnoremap <buffer> <leader>/ 0i# <esc>j0
augroup END

" Plugins

syntax on
if has('termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
set cursorline
set background=dark

" Just colorscheme things
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1

let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1
colorscheme onedark

set laststatus=2
let g:lightline = { 'colorscheme': 'onedark' }
let g:airline_theme = 'onedark'

function! Lightify()
	colorscheme catppuccin_latte
	let g:airline_theme = 'catppuccin_latte'
	set background=light
endfunction

function! Darkify()
	colorscheme onedark
	let g:airline_theme = 'onedark'
	set background=dark
endfunction

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <leader>b :NERDTreeToggle<CR>

" FZF Configuration
nnoremap <leader>f :FZF<CR>
