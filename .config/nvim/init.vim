" Plugin-free magic from https://github.com/changemewtf/no_plugins
" Never touch another dev's vim

" ## Pre-processing
if has("win32") || has("win16")
       " Dude idk
else
       set shell=/bin/bash
       let g:coc_node_path='~/.nvm/versions/node/v16.14.0/bin/node'
endif

let mapleader = "\<Space>"

" ## PLUGINS
call plug#begin()

	" GUI enhancements
	Plug 'sonph/onehalf', { 'rtp': 'vim' } " onehalf color scheme
	Plug 'itchyny/lightline.vim' " enhances the NORMAL/INSERT line thing
	Plug 'machakann/vim-highlightedyank' " highlights what you are yanking

	" Writeroom
	Plug 'junegunn/goyo.vim'

	" File Explorer
	Plug 'scrooloose/nerdtree' " File system sidebar
	Plug 'ryanoasis/vim-devicons' " Adds icons to nerdtree
	" Plug 'airblade/vim-rooter' " Roots searching at project root
	" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finding goodness

	" Semantic language support
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server
	Plug 'rust-lang/rust.vim'
	Plug 'habamax/vim-godot'

call plug#end()

" Stop trying to make vi happen. It's not going to happen.
set nocompatible

syntax enable
filetype plugin indent on

" ## FINDING FILES
" 
" * Hit tab to :find by partial match
" * Use * to make it fuzzy
" * :b lets you autocomplete any open buffer
" * gf goes to the file under the cursor
" 	* <C-6> or :b# goes to previous buffer

" Search down into subfolders
set path+=**
" Display all matching files when we tab complete
set wildmenu

" ## TAGS
"
" * Use ^] to jump to tag under cursor
" * Use g^] for ambiguous tags
" * Use ^t to jump back up the tag stack
"
" [ctags](https://github.com/universal-ctags/ctags) must be installed
" Create the `tags` file
command! MakeTags !ctags -R

" ## AUTOCOMPLETE
"
" Documentation in `:help ins-completion`
" * ^n and ^p navigates through autocomplete list
" * ^x^n just this file
" * ^x^f just filenames
" * ^x^] just tags

" ## BUILD INTEGRATION:
"
" * Run :make to run makeprg
" * :cl to list errors
" * :cc# to jump to error by number
" * :cn and :cp to nagivate forward and back
" * :copen opens the error window
" set makeprg=yo\ mama

" ## COPYING
"
" * yy yanks current line
" * "*y copies selected text into system clipboard register
" * :read <file> copies the contents of a file under the cursor

set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set noshowmode
" set nowrap

set undodir=~/.vimdid
set undofile

set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter

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

set lazyredraw
set relativenumber " show relative line numbers
set number " also show absolute line number for current line
set colorcolumn=80 " colored line for 80 characters
set mouse=a " enable mouse usage (all modes) in terminals

set cmdheight=2
set updatetime=300

" show hidden characters
set listchars=tab:ﲒ\ ,space:·,nbsp:¬,extends:»,precedes:«,trail:•
set list

" Jump to start and end of line using the home row keys
map H ^
map L $

" ==============================================================================
" ## PLUGINS

" ## Onehalf Configuration
syntax on
set cursorline
colorscheme onehalfdark
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" ## Lightline Configuration
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


" ## NERDTree Configuration
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <leader>b :NERDTreeToggle<CR>


" ## Fuzzy Finder Configuration
" nnoremap <C-p> :FZF<CR>
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-h': 'split',
"   \ 'ctrl-s': 'vsplit'
"   \}


" ## Coc Configuration

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
" Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Use K to show documentation in preview window.
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" ## Rust Configuration
let g:rustfmt_autosave = 1

" ## Ripgrep Configuration
" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" if executable('ag')
" 	set grepprg=ag\ --nogroup\ --nocolor
" endif
" if executable('rg')
" 	set grepprg=rg\ --no-heading\ --vimgrep
" 	set grepformat=%f:%l:%c:%m
" endif

" ==============================================================================
