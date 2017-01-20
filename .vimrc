" +-------------------------------------+
" | os settings                         |
" +-------------------------------------+
" Windows
if has('win32') || has('win64')
endif

" LINUX
if has('unix')
endif

" MAC
if has('mac')
endif

" GUI
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
set shiftwidth=4
set ruler
set showtabline=2
set laststatus=2
set t_Co=256
set backspace=2
set noic
set cmdheight=1
set autoindent
syntax on
set directory=~/.vim/swapfiles
set undofile
set undodir=~/.vim/undofiles
set nobackup
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
nnoremap <silent> <Space>n :VimFiler -split -simple -winwidth=25 -no-quit<CR>
nnoremap <silent> <Space>b :Unite bookmark -winheight=5<CR>
nnoremap <silent> <Space>t :Tagbar<CR>
nnoremap <silent> <Space>c "+y
vnoremap <silent> <Space>c "+y
nnoremap <silent> <Space>v "+gp
nnoremap <silent> <Space>a ggVG
vmap <Enter> <Plug>(EasyAlign)

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

" set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets,~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" +-------------------------------------+
" | neocomplete or neocomplcache        |
" +-------------------------------------+
if has('lua')
	let g:neocomplete#enable_at_startup = 1
else
	let g:neocomplcache_enable_at_startup = 1
endif

" +-------------------------------------+
" | VimFiler                            |
" +-------------------------------------+
let g:vimfiler_safe_mode_by_default = 0
"call NERDTreeHighlightFile( 'php',     'magenta', 'none',     'magenta', '#151515')
"call NERDTreeHighlightFile(  'rb',         'red', 'none',         'red', '#151515')
"call NERDTreeHighlightFile('html',      'yellow', 'none',      'yellow', '#151515')
"call NERDTreeHighlightFile( 'css', 'lightyellow', 'none', 'lightyellow', '#151515')
"call NERDTreeHighlightFile(  'vb',       'green', 'none',       'green', '#151515')
"call NERDTreeHighlightFile(  'js',   'lightblue', 'none',   'lightblue', '#151515')
"call NERDTreeHighlightFile('java',        'blue', 'none',        'blue', '#151515')
"call NERDTreeHighlightFile(  'md',       'brown', 'none',       'brown', '#151515')
"call NERDTreeHighlightFile(  'pl',  'lightgreen', 'none',  'lightgreen', '#151515')

" +-------------------------------------+
" | lightline                           |
" +-------------------------------------+
let g:lightline = {
        \ 'colorscheme': 'Dracula',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
