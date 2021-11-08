if has("win32") || has("win16")
	" Dude idk
else
	set shell=/bin/bash
endif

let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()

" GUI enhancements
Plug 'itchyny/lightline.vim' " enhances the NORMAL/INSERT line thing
Plug 'machakann/vim-highlightedyank' " highlights what you are yanking
Plug 'sonph/onehalf', { 'rtp': 'vim' } " onehalf color scheme

" Writeroom
Plug 'junegunn/goyo.vim'

" File Explorer
Plug 'scrooloose/nerdtree' " File system sidebar
Plug 'ryanoasis/vim-devicons' " Adds icons to nerdtree

" Fuzzy finder
Plug 'airblade/vim-rooter' " Roots searching at project root
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finding goodness

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server
" Plug 'w0rp/ale' " I'm not sure what this does that coc doesn't :/
Plug 'rust-lang/rust.vim'
Plug 'habamax/vim-godot'

call plug#end()

" Theme settings
syntax on
set cursorline
colorscheme onehalfdark
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Plugin settings
let g:rustfmt_autosave = 1

" from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
let g:lightline = {
	\ 'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\		  [ 'cocstatus', 'readonly', 'filename', 'modified'] ]
	\ },
	\ 'component_function': {
	\	'filename': 'LightlineFilename',
	\	'cocstatus': 'coc#status'
	\ },
	\ 'colorscheme': 'onehalfdark',
	\ }
function! LightlineFilename()
	return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use autocmd to force lightline update
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


" Use <tab> for trigger completion and navigate to the next complete item
" NOTE: the <tab> could be remmapped by another plugin, use 
" ':verbose imap <tab>' to check if it's mapped as expected 
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()

" Use Shift + Tab to navigate the list backward
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <leader>b :NERDTreeToggle<CR>

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-s': 'vsplit'
  \}

" =============================================================================
" # Editor settings
" =============================================================================
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set noshowmode
set nowrap

set undodir=~/.vimdid
set undofile

set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter

" use wide tabs
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

autocmd BufRead,BufNewFile *.md setlocal tabstop=4
autocmd BufRead,BufNewFile *.md setlocal softtabstop=4
autocmd BufRead,BufNewFile *.md setlocal shiftwidth=4
autocmd BufRead,BufNewFile *.md setlocal expandtab

autocmd BufRead,BufNewFile *.hs setlocal tabstop=4
autocmd BufRead,BufNewFile *.hs setlocal softtabstop=4
autocmd BufRead,BufNewFile *.hs setlocal shiftwidth=4
autocmd BufRead,BufNewFile *.hs setlocal expandtab

" =============================================================================
" # GUI settings
" =============================================================================
set lazyredraw
set relativenumber " show relative line numbers
set number " also show absolute line number for current line
set colorcolumn=80 " colored line for 80 characters
set mouse=a " enable mouse usage (all modes) in terminals

" completion
set cmdheight=2
set updatetime=300
" show hidden characters
	set listchars=tab:ﲒ\ ,space:·,nbsp:¬,extends:»,precedes:«,trail:•
set list

" =============================================================================
" # Keyboard settings
" =============================================================================
" Jump to start and end of line using the home row keys
map H ^
map L $

" Open hotkeys
"map <C-p> :Files<CR>
nmap <leader>; :buffers<CR>
nmap <leader>v <C-v>
