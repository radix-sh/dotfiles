" Get vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'rhysd/vim-clang-format'
Plug 'gkeep/iceberg-dark'
Plug 'git-time-metric/gtm-vim-plugin'
call plug#end()

" Tabs
set tabstop=4           " Set number of spaces to display for <Tab>
set shiftwidth=4        " Set number of spaces for a shift operation (>> or <<) 
set expandtab           " Expand <Tab>s to spaces
set autoindent          " Indent next line as same as current line
set smartindent         " Use code syntax/style to align  
set cindent
filetype plugin indent on
set cinoptions=(0,u0,U0,(0
" https://stackoverflow.com/questions/11984520/vim-indent-align-function-arguments
set cinoptions+=(0      " Align parameters if they go across lines 
set cinwords+=for,if
au FileType c,cpp set tabstop=2 shiftwidth=2 softtabstop=2
au FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" Folding 
au BufRead * normal zR
set foldnestmax=2
set foldlevel=0
set foldmethod=syntax
au FileType py set foldmethod=indent

" General settings 
colorscheme iceberg
set background="dark"
syntax on
let mapleader = " "
set showmode showcmd
set showmatch           " highlight matching [], {}, () 
set hlsearch            " highlight searches
set incsearch           " search as you type 
set colorcolumn=80
set textwidth=80
set wrapmargin=2
" Preserve last editing position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
set number
set clipboard=unnamed   " unnamedplus for linux
set cursorline
au BufReadPost *bash* set syntax=sh
set encoding=utf-8
set nobackup
set autochdir           " Automatically change working directory 
set backspace=indent,eol,start
" autoread: https://stackoverflow.com/a/20418591
au FocusGained,BufEnter * :silent! !
" paste below current line
nmap <leader>p o<ESC>p

" Persistent_undo: https://stackoverflow.com/a/22676189
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
set laststatus=2        " Permanent status bar; also makes lightline work
set noshowmode          " Because lightline
let g:lightline = {
            \ 'colorscheme': 'deus',
            \ }
" Reduce lag switching to normal mode: https://github.com/itchyny/lightline.vim/issues/389
set ttimeout ttimeoutlen=50

" clang-format
let g:clang_format#style_options = {
            \ "Language" : "Cpp",
            \ "Standard" : "C++11",
            \ "BasedOnStyle" : "Google",
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortLoopsOnASingleLine" : "false",
            \ "ReflowComments" : "true"}
au FileType cpp noremap <Leader>f :ClangFormat<CR>

" Remove trailing whitespaces
" https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
" Equivalent to %s/\s\+$//ge
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap <Leader>W :call TrimWhitespace()<CR>
au BufWritePre *.c,*.cc,*.cpp call TrimWhitespace()

" https://github.com/git-time-metric/gtm-vim-plugin
" In the status bar see your total time spent for in-process work (uncommitted).
let g:gtm_plugin_status_enabled = 1

function! AirlineInit()
  if exists('*GTMStatusline')
    call airline#parts#define_function('gtmstatus', 'GTMStatusline')
    let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
  endif
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" Switch between panes easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
