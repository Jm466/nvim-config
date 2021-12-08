syntax on

set encoding=utf-8

set nocompatible
let mapleader = "ç"  

set tabstop=3
set shiftwidth=3
set expandtab

set hidden
set scrolloff=10
set sidescrolloff=10

set autoindent
set autowriteall
set smartindent
set nu
set noswapfile
set confirm
set mouse=a
set incsearch
set nowrap
set sidescroll=5
set clipboard=unnamedplus

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"Si vim-plug no está descargado, llama a PlugInstall, que instala los plugins que faltan, y carga este archivo de configuración
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

"Si hay algún plugin que no está instalado, llama a PlugInstall y carga la configuración
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source ~/.config/nvim/init.vim
\| endif

"--------------------------------Sección de pluggins-------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')

"Gruvbox
Plug 'morhetz/gruvbox'
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

"Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

"Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

   "Extensiones de coc
   let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-java', 'coc-pyright', 'coc-sh', 'coc-clangd']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

call plug#end()
"---------------------------------Fin de sección de pluggins------------------------------------------------------

"Atajos
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>x :!xdg-open %<cr><cr>
map <silent> <F5> :call AlternaFondo()  <CR>
map <silent> <Leader><cr> :nohlsearch<cr>
nnoremap <silent> <C-f> <cmd> Telescope file_browser <CR>
vnoremap <silent> <C-c> "*y :let @+=@* <CR>
"nnoremap <leader>d "_d
"xnoremap <leader>d "_d
"xnoremap <leader>p "_dP


function! AlternaFondo()
	  if &background == "light"
		    set background=dark
		    echo "fondo negro"
	  else
		    set background=light
		    echo "fondo blanco" 
	  endif 
endfunction


