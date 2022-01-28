call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()

if has('nvim')
    colorscheme tokyonight 
    set termguicolors
else
    colorscheme iceberg
endif

" general settings
syntax on
set number
set clipboard=unnamed
set cursorline
autocmd BufReadPost *bash* set syntax=sh
set showmode showcmd
set showmatch
set hlsearch incsearch ignorecase smartcase
set colorcolumn=80
set expandtab shiftwidth=4 smarttab
set encoding=utf-8
set visualbell
set nobackup
set smartindent
set autochdir
autocmd FocusGained,BufEnter * :silent! !
set autoread

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

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
