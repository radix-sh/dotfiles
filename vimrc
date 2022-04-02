let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'
call plug#end()

if has('nvim')
    let tokyonight_style = "night"
    colorscheme tokyonight
else
    colorscheme iceberg
endif

" tabs
set tabstop=4           " set number of spaces to display for <Tab>
set shiftwidth=4        " set number of spaces for a shift operation (>> or <<) 
" set softtabstop=4       " set number of columns for a <Tab> 
set expandtab           " expand <Tab>s to spaces
set autoindent          " indent next line as same as current line
set smartindent         " use code syntax/style to align  
filetype plugin indent on
set cindent
set cinoptions=(0,u0,U0

" general settings
set showmatch           " highlight matching [], {}, () 
set hlsearch            " highlight searches
set incsearch           " search as you type 
set colorcolumn=80
set textwidth=80
set wrapmargin=2
syntax on
set number
set clipboard=unnamed   " unnamedplus for linux
set cursorline
set showmode showcmd
set laststatus=2        " permanent status bar  
autocmd BufReadPost *bash* set syntax=sh
set encoding=utf-8
set visualbell
set nobackup
set autochdir           " automatically change working directory 
set autoread
autocmd FocusGained,BufEnter * :silent! !

" makefile settings
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" syntax-highlight google scripts like javascript
au BufRead,BufNewFile *.gs set filetype=javascript

" preserve last editing position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" persistent undo
if has('persistent_undo') && has('nvim')
    let target_path = expand('/tmp/.vim-undo-dir') " ~/.config/undo/') 
    if !isdirectory(target_path)
        call mkdir(target_path, "", 0700)
    endif
    let &undodir = target_path 
    set undofile
endif

" leader 
let mapleader = " "

" paste below current line
nmap <leader>p o<ESC>p

" folding 
autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax
autocmd FileType js setlocal foldmethod=syntax
autocmd BufRead * normal zR
set foldnestmax=1
set foldlevel=0
set foldmethod=indent

" use <Tab> for trigger completion with coc.nvim
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

" map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

set noshowmode " because lightline
