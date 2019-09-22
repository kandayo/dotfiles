set nocompatible

set colorcolumn=80
set encoding=utf-8
set hidden
set ignorecase
set incsearch
set number
set smartcase

set tabstop=2 shiftwidth=2 expandtab

set undofile
set undodir=~/.cache/undo.vim

autocmd BufWritePre * :%s/\s\+$//e


""
"" Plugin
""

call plug#begin('~/.vim/plugged')
  Plug 'Yggdroot/indentLine'
  Plug 'airblade/vim-gitgutter'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'direnv/direnv.vim'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'mboughaba/i3config.vim'
  Plug 'rhysd/vim-crystal'
  Plug 'scrooloose/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-surround'
  Plug 'w0rp/ale'
call plug#end()

colorscheme space-vim-dark


""
"" Keyboard
""

let mapleader=","

cmap w!! w !sudo tee % >/dev/null

nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <S-tab> :bprev<CR>

vnoremap <Leader>y "+yy
nnoremap <Leader>p "+p

nnoremap <Leader>' di'
nnoremap <Leader>" di"

nnoremap <Leader>m :%!jq '.'<CR>

nnoremap <Leader>s :%s//g<Left><Left>
nnoremap <Leader>d :%s//d<Left><Left>

inoremap <C-l> <Right>
inoremap <C-h> <Left>


""
"" Plugin configuration
""

" ctrlp
set grepprg=ag\ --nogroup\ --nocolor\ --skip-vcs-ignores

let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0

let g:ctrlp_user_command =
  \ 'ag %s -i --nocolor --nogroup --hidden --skip-vcs-ignores
  \ --ignore .git/
  \ --ignore .github/
  \ --ignore node_modules/
  \ --ignore tmp/
  \ --ignore bin/
  \ --ignore dist/
  \ --ignore public/
  \ --ignore coverage/
  \ --ignore coverage-js/
  \ --ignore metrics/
  \ --ignore docs/
  \ --ignore log/
  \ --ignore vendor/
  \ -g ""'

" lightline
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }

" gitgutter
let g:gitgutter_enabled = 0
noremap <F3> :GitGutterToggle<CR>

" nerd commenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" postgresql
let g:sql_type_default = 'pgsql'

" ranger
let g:ranger_replace_netrw = 1
nnoremap <silent> = :Ranger<CR>

" ale
let g:ale_fixers = {
  \ 'javascript': ['standard'],
  \ 'ruby': ['rubocop']
  \}

" syntax
let g:vue_pre_processors = []
