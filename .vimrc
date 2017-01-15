" +-------------------------------------+
" | os settings                         |
" +-------------------------------------+
" Windows
if has('win32') || has ('win64')
endif

" LINUX
if has('unix')
endif

" MAC
if has('mac')
endif

"GUI
if has('gui_running')
	set lines=35
	set columns=120
endif

" +-------------------------------------+
" | vim settings                        |
" +-------------------------------------+
set title
set number
set incsearch
set hlsearch
set tabstop=4
set ruler
set showtabline=2
set shiftwidth=4
set laststatus=2
set t_Co=256
syntax on
colorscheme default

" +-------------------------------------+
" | keymap                              |
" +-------------------------------------+
inoremap jj <esc>
inoremap ;; <C-O>$;<CR>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
imap {{ <C-o>${<Enter>

" +-------------------------------------+
" | dein.vim                            |
" +-------------------------------------+
if &compatible
  set nocompatible
endif
" need 'git clone https://github.com/Shougo/dein.vim 
"   ->    ~/.vim/dein/repos/github.com/Shougo/dein.vim'
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/dein'))
    call dein#begin(expand('~/.vim/dein'))

    let g:dein_dir = expand('~/.vim/dein')
    let s:toml = g:dein_dir . '/dein.toml'
    let s:lazy_toml = g:dein_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

" install
if dein#check_install()
    call dein#install()
endif

filetype plugin indent on

" +-------------------------------------+
" | neosnippet                          |
" +-------------------------------------+
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets,~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" +-------------------------------------+
" | neocomplete                         |
" +-------------------------------------+
let g:neocomplete#enable_at_startup = 1

