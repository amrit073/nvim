" this will install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall 
endif


autocmd vimenter * ++nested colorscheme gruvbox 
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
set mouse=a
let mapleader = ' '
map <leader>f :CocCommand prettier.formatFile<CR>
map <leader>n :set number!<CR>
map <leader>nn :set relativenumber!<CR>
map <leader>v :NvimTreeToggle<cr>
map <leader>vf :NvimTreeFindFileToggle<cr>
map <leader>vb :NvimTreeFocus<cr>
map <C-l> :BufferLineCycleNext<cr>
map <C-h> :BufferLineCyclePrev<cr>
set clipboard=unnamedplus
call plug#begin()
" here you'll add all the plugins needed
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'morhetz/gruvbox'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

call plug#end()

lua require('basic')
