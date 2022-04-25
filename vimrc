" get vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'itchyny/lightline.vim'
" Plug 'ghifarit53/tokyonight-vim'
" install LSP servers to $HOME/.local/share/vim-lsp-settings/servers
" Plug 'mattn/vim-lsp-settings'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" provide :ClangFormat (mapped to <Leader>f) for C/C-style formatting in vim
Plug 'rhysd/vim-clang-format'

Plug 'psf/black'

call plug#end()

"
" general settings
"
"

" colorscheme
colorscheme tokyonight 
" insert this into colorscheme source file if colorcolumn is ugly
" (color 236 picked from https://www.ditig.com/256-colors-cheat-sheet)
" highlight ColorColumn ctermbg=236 ctermfg=NONE 


" lightline
set laststatus=2        " permanent status bar; also makes lightline work
set noshowmode          " because lightline
let g:lightline = {
            \ 'colorscheme': 'deus',
            \ }
" reduce lag switching to normal mode
" https://github.com/itchyny/lightline.vim/issues/389
set ttimeout ttimeoutlen=50


" folding
" autocmd FileType c setlocal foldmethod=syntax
" autocmd FileType cpp setlocal foldmethod=syntax
" autocmd FileType js setlocal foldmethod=syntax
autocmd BufRead * normal zR
set foldnestmax=3
set foldlevel=1
set foldmethod=syntax   
set foldcolumn=1        " adds a column on the left to show folded lines

" tabs
set tabstop=4           " set number of spaces to display for <Tab>
set softtabstop=4       " set number of spaces to go back upon backspace
set shiftwidth=4        " set number of spaces for a shift operation (>> or <<)
set expandtab           " expand <Tab>s to spaces
set autoindent          " indent next line to same depth as current line
set smartindent         " use code syntax/style to align
filetype plugin indent on
set cindent
set cinoptions=(0,u0,U0
" autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
" https://stackoverflow.com/questions/12352036/vim-alignment-of-public-keyword
set cinoptions+=g1,h1   " indent private/public keywords one space

" things I tinker with
set showmatch           " highlight matching [], {}, ()
set hlsearch            " highlight searches
set incsearch           " search as you type
set textwidth=80
set wrapmargin=2
set visualbell
if (has("termguicolors"))
    set termguicolors
endif

" things I take for granted
syntax on
set number
set cursorline
set colorcolumn=80
set nobackup
set clipboard=unnamed   " only works for macOS :(
set termguicolors
set background=dark
set autochdir           " automatically change working directory
" autoread: https://stackoverflow.com/a/20418591
autocmd FocusGained,BufEnter * :silent! !
" preserve last editing position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
            \ | exe "normal! g`\"" | endif
" bash files
autocmd BufReadPost *bash* set syntax=sh
" makefiles
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
" google-script files
autocmd BufRead,BufNewFile *.gs set filetype=javascript


"
" custom keybinds and files
"

" leader
let mapleader = " "

" paste below current line
nmap <leader>p o<ESC>p

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" strip trailing whitespace
" https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
fun! TrimWhitespace()
    " save the current 'view' (including cursor position, folds, jumps, etc)
    let l:save = winsaveview()
    " prevent \s\+$ from being added to search history
    keeppatterns %s/\s\+$//e
    " restore the view from the saved variable
    call winrestview(l:save)
endfun
noremap <Leader>w :call TrimWhitespace()<CR>
" automatically call TrimWhitespace() before saving cpp files
autocmd BufWritePre *.cc,*.h call TrimWhitespace()

" persistent undo: https://stackoverflow.com/a/22676189
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
" coc config
"

set encoding=utf-8
set cmdheight=2         " more space for displaying messages
set updatetime=300      " no more noticeable delays for user
set shortmess+=c        " don't pass messages to |ins-completions-menu|

" always show signcolumn; otherwise it would shift the text each time
" diagnostics appear or become resolved
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" clang-format
let g:clang_format#style_options = {
            \ "Language" : "Cpp",
            \ "BasedOnStyle" : "Google",
            \ "Standard" : "C++11",
            \ "AllowShortIfStatementsOnASingleLine" : "Never",
            \ "AllowShortLoopsOnASingleLine" : "false",
            \ }
" use <Leader>F to automatically run clang-format on the currently open file
autocmd FileType c,cpp,objc noremap <Leader>f :ClangFormat<CR>

" 
" filetype-specific settings
"

" python
autocmd FileType py setlocal foldmethod=indent
autocmd FileType py noremap <Leader>f :Black<CR>

