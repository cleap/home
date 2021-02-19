" "Fish doesn't play all that well with others" - Jon Gjengset
set shell=/bin/bash
let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'rust-lang/rust.vim'

call plug#end()

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

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

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
set shiftwidth=8
set softtabstop=8
set tabstop=8
set noexpandtab

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

" =============================================================================
" # Keyboard settings
" =============================================================================
" Jump to start and end of line using the home row keys
map H ^
map L $

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

