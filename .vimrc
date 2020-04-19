set nocompatible

set title
set mouse=a
set shortmess=I
set visualbell

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
set noswapfile
set nobackup
set nowritebackup

autocmd BufWritePre * :%s/\s\+$//e

autocmd BufNewFile,BufRead .envrc set syntax=bash
autocmd BufNewFile,BufRead .env set syntax=bash

""
"" Plugin
""

call plug#begin('~/.vim/plugged')
  Plug 'SirVer/ultisnips'
  Plug 'Yggdroot/indentLine'
  Plug 'airblade/vim-gitgutter'
  Plug 'aliou/sql-heredoc.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'honza/vim-snippets'
  Plug 'itchyny/lightline.vim'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'mboughaba/i3config.vim'
  Plug 'mileszs/ack.vim'
  Plug 'rhysd/vim-crystal'
  Plug 'scrooloose/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  Plug 'thoughtbot/vim-rspec'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'w0rp/ale'
  Plug 'zivyangll/git-blame.vim'
call plug#end()

let g:space_vim_dark_background = 234
colorscheme space-vim-dark
hi Comment guifg=#5C6370 ctermfg=59

""
"" Keyboard
""

let mapleader=","

map ; :

cmap w!! w !sudo tee % >/dev/null

nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <S-tab> :bprev<CR>

vnoremap <Leader>y "+yy
nnoremap <Leader>p "+p

nnoremap <Leader>' di'
nnoremap <Leader>" di"

nnoremap <Leader>S :%s//g<Left><Left>
nnoremap <Leader>D :%s//d<Left><Left>

inoremap <C-l> <Right>
inoremap <C-h> <Left>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <silent> <Leader>b :<C-u>call gitblame#echo()<CR>

noremap <F4> :set hlsearch! hlsearch?<CR>

""
"" Plugin configuration
""

" Ack
let g:ack_use_dispatch = 1
let g:ackprg =
  \ 'ag --nocolor --nogroup --hidden --skip-vcs-ignores --vimgrep
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
  \ --ignore log/

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" CtrlP
let g:ctrlp_use_caching = 1
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
  \ --ignore log/
  \ -g ""'

" LightLine
set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'clock' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \  'component': {
  \    'clock': '%{strftime("%H:%M")}'
  \ },
  \ }

" GitGutter
let g:gitgutter_enabled = 0
noremap <F3> :GitGutterToggle<CR>

" Nerd Commenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" PostgreSQL
let g:sql_type_default = 'pgsql'

" Ranger
let g:ranger_replace_netrw = 1
nnoremap <silent> = :Ranger<CR>

" ALE
let g:ale_enabled = 0
let g:ale_fixers = {
  \ 'javascript': ['standard'],
  \ 'ruby': ['rubocop']
  \}

" VueJS
let g:vue_pre_processors = []

" RSpec
let g:rspec_command = "!clear && echo '>> rspec {spec}' && bundle exec rspec {spec}"

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" UtilSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-a>"
