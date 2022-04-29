" get vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
" Plug 'rhysd/vim-clang-format'
call plug#end()


" tabs
set tabstop=4           " set number of spaces to display for <Tab>
set shiftwidth=4        " set number of spaces for a shift operation (>> or <<) 
set expandtab           " expand <Tab>s to spaces
set autoindent          " indent next line as same as current line
set smartindent         " use code syntax/style to align  
set cindent
filetype plugin indent on
set cinoptions=(0,u0,U0,(0
" https://stackoverflow.com/questions/11984520/vim-indent-align-function-arguments
" :w
" set cinoptions+=(0            " align parameters if they go across lines 
set cinwords+=for,if

" folding 
autocmd BufRead * normal zR
set foldnestmax=1
set foldlevel=0
set foldmethod=syntax

" general settings 
colorscheme iceberg
let mapleader = " "
" paste below current line
nmap <leader>p o<ESC>p
set showmode showcmd
set showmatch           " highlight matching [], {}, () 
set hlsearch            " highlight searches
set incsearch           " search as you type 
set colorcolumn=80
set textwidth=80
set wrapmargin=2
syntax on
" preserve last editing position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
set number
set clipboard=unnamed   " unnamedplus for linux
set cursorline
autocmd BufReadPost *bash* set syntax=sh
set encoding=utf-8
set nobackup
set autochdir           " automatically change working directory 
set backspace=indent,eol,start
" autoread: https://stackoverflow.com/a/20418591
autocmd FocusGained,BufEnter * :silent! !
" persistent_undo: https://stackoverflow.com/a/22676189
if has('persistent_undo')
    let target_path = expand('/tmp/.vim-undo-dir') " ~/.config/undo/') 
    if has('nvim')
        let target_path = expand('~/.config/undo/')
    endif
    if !isdirectory(target_path)
        call mkdir(target_path, "", 0700)
    endif
    let &undodir = target_path 
    set undofile
endif


" 
" Plugin settings
"

" use <Tab> for trigger completion with coc.nvim
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

" lightline
set laststatus=2        " permanent status bar; also makes lightline work
set noshowmode          " because lightline
let g:lightline = {
            \ 'colorscheme': 'deus',
            \ }
" reduce lag switching to normal mode: https://github.com/itchyny/lightline.vim/issues/389
set ttimeout ttimeoutlen=50

" clang-format
let g:clang_format#style_options = {
            \ "Language" : "Cpp",
            \ "Standard" : "C++11",
            \ "BasedOnStyle" : "Google",
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortLoopsOnASingleLine" : "false"}
" autocmd FileType c,cpp,objc noremap <Leader>F :ClangFormat<CR>

" remove trailing whitespaces
" https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
" equivalent to %s/\s\+$//ge
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap <Leader>W :call TrimWhitespace()<CR>
autocmd BufWritePre *.c,*.cc,*.cpp call TrimWhitespace()

" 
" File-specific settings
"

" makefile settings
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
" syntax-highlight google scripts like javascript
au BufRead,BufNewFile *.gs set filetype=javascript
" autocmd FileType c,cpp set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType py setlocal foldmethod=indent

" autocmd FileType cpp noremap <Leader>f :ClangFormat<CR>
