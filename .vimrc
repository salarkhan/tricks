set nocompatible

" PLUGIN CONFIG
" ---------------------------------
" set dir for plugins
call plug#begin(stdpath('config') . '/plugged')

" plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jesseleite/vim-agriculture'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

" initialize plugin system
call plug#end()

" GENERAL CONFIG
" ---------------------------------
" syntax highlighting
syntax on

" give me accurate colors, thanks neovim
set termguicolors
"
colorscheme
" set background=light
" colorscheme PaperColor
set background=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox

" colorize matched searches
set hlsearch

" allow me to change buffers without saving
set hidden

" do not create backup files
set nobackup
set nowritebackup

" better display for messages
set cmdheight=1

" do not create swap files
set noswapfile

" allow copy/pasting to system clipboard
set clipboard+=unnamedplus

" exclude files/dirs we don't care about
set wildignore+=*/tmp/*,dist,node_modules,*.pyc

" workaround to ensure :E maps to Explore
let g:loaded_logipat=1

" case insensitive matching
set ignorecase

" let me use a mouse if i want to
if has('mouse')
  set mouse=a
endif

" keep 1000 lines of cmd history
set history=1000

" when using > or <, for indent / outdent, go this many spaces
set shiftwidth=2

" tab is never \t, but always tabstop number of spaces
set expandtab

" tab is this many spaces
set tabstop=2

" use shiftwidth instead of tabstop
set smarttab

" always show signcolumns
set signcolumn=yes

" DISPLAY CONFIG
" ---------------------------------
" show the filename in the window titlebar
set title

" display line numbers
set number

" open splits to right/bottom
set splitbelow
set splitright

" always use vertical diffs
set diffopt+=vertical

" make it obvious where 80 characters is
" set textwidth=80
" set colorcolumn=+1

" start scrolling this many lines before the horizontal window border
set scrolloff=5

" show @@@ in the last line if it is truncated
set display=truncate

" remember my folds pls
" set foldmethod=syntax
" set viewoptions=cursor,folds,slash,unix

" REMAP CONFIG
" ---------------------------------
" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" i hold shift too long sometimes
command! W w

" " ; as :
nnoremap ; :

" delete buffer but preserve the split
nmap ,d :bd<bar>bp<CR>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP

" remove highlights
nmap <leader>h :nohl<CR>

" (fzf) - files
nnoremap <C-p> :Files<CR>

" (fzf) - buffers
nmap <leader>b :Buffers<CR>

" (vim-agriculture) raw ripgrep cmd you can pass arguments to
nmap <leader>r <Plug>RgRawSearch

" (vim-go) run a specific test
autocmd FileType go nmap <leader>gt  <Plug>(go-test-func)

" (vim-go) see identifier info
autocmd FileType go nmap <Leader>gn <Plug>(go-info)

" (vim-go) - imports
nmap <leader>i :GoImports<CR>

" VIM-GO CONFIG
" ---------------------------------
" highlight things
let g:go_highlight_extra_types = 1

" let gopls handle formatting, imports, etc
let g:go_fmt_command = "goimports"


" RIPGREP/FZF CONFIG
" ---------------------------------
" ? to preview search result
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" COC CONFIG
" ---------------------------------
" use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" get func signatures
augroup mygroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" use <cr> to confirm completion, `<c-g>u` means break undo chain at current position
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" show diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" HELPERS
" ---------------------------------
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
nnoremap <leader>ws :call StripTrailingWhitespace()
