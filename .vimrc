" +-------------------------------------+
" | os settings                         |
" +-------------------------------------+
" LINUX
if has('unix')
	let g:vimproc_dll_path = '~/.vim/dein/repos/github.com/Shougo/vimproc/lib/vimproc_linux64.so'
endif

" +-------------------------------------+
" | vim settings                        |
" +-------------------------------------+
set title
set number
set noic
set hlsearch
set incsearch
set ruler
set autoindent
set tabstop=4
set backspace=2
set shiftwidth=4
set showtabline=2
set cmdheight=1
set laststatus=2
set undofile
set nobackup
set directory=~/.vim/swapfiles
set undodir=~/.vim/undofiles
set t_Co=256
syntax on
colorscheme default
set splitbelow

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
nnoremap <silent> vs :VimShellPop bash<CR>
nnoremap <silent> <Space>irb :VimShellInteractive irb<CR>
vmap <silent> <Space>s :VimShellSendString<CR>
nnoremap <silent> <Space>s <S-v>:VimShellSendString<CR>

" +-------------------------------------+
" | dein.vim                            |
" +-------------------------------------+
if &compatible
  set nocompatible
endif

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
