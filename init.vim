" this will install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall 
endif
if empty(glob(' ~/.local/share/nvim/site/pack/packer/start/packer.nvim'))
    silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    autocmd VimEnter * PackerInstall 
endif
set tabstop=2 shiftwidth=2
call plug#begin()

" here you'll add all the plugins needed
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
" these two plugins will add highlighting and indenting to JSX and TSX files.
" Plug 'yuezk/vim-js'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'morhetz/gruvbox'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" Plug 'mfussenegger/nvim-dap'
call plug#end()

lua require('basic')
lua require('telescope').setup{  defaults = { file_ignore_patterns = { "node_modules" }} }
let g:go_fmt_command = "golines"
let g:go_fmt_options = {
    \ 'golines': '-m 128',
    \ }
" autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
autocmd vimenter * ++nested colorscheme gruvbox 
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
set mouse=a
let mapleader = ' '
map <leader>f :CocCommand prettier.formatFile<CR>
map <leader>n :set number!<CR>
map <leader>nn :set relativenumber!<CR>
map <leader>v :NvimTreeToggle<cr>
map <leader>b <C-w>w
map <leader>m <leader>bi!!<CR><C-\><C-n><leader>b
map <C-l> :BufferLineCycleNext<cr>
map <C-h> :BufferLineCyclePrev<cr>
map \\ :noh<cr>
set clipboard=unnamedplus
setlocal shiftwidth=2
" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
	    set nobuflisted
	    set equalalways
	    
	    
        endtry
        startinsert!
        let g:term_win = win_getid()
	call CleanEmptyBuffers()

    endif
endfunction
" Toggle terminal on/off (neovim)
nnoremap <leader>t :call TermToggle(8)<CR>
tnoremap <Esc> <C-\><C-n>
vnoremap <leader>c :'<,'>norm i// <cr>
nnoremap <leader>u ^xx$ 
nnoremap <leader>c ^i//<C-\><C-n>j 
vnoremap <leader>u :'<,'>norm xx <cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
 "nnoremap x "_x
function! CleanEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        exe 'bw ' . join(buffers, ' ')
    endif
endfunction
function! GoFmt()
  let saved_view = winsaveview()
  silent %!gofmt
  if v:shell_error > 0
    cexpr getline(1, '$')->map({ idx, val -> val->substitute('<standard input>', expand('%'), '') })
    silent undo
    cwindow
  endif
  call winrestview(saved_view)
endfunction

command! GoFmt call GoFmt()

function! Clang_format()
    let save_cursor = getcurpos()
    exe '%!clang-format -style=file'
    call setpos('.', save_cursor)
endfunc
 
command! CFormat call Clang_format()

augroup go_autocmd
  autocmd BufWritePre *.go GoFmt
augroup END
"autocmd BufWritePre *.c,*.cpp,*.h.*.o %!clang-format
autocmd BufWritePre *.c,*.cpp,*.h.*.o CFormat
autocmd BufWritePre *.js,*.ts,*.json Format
lua require('lspconfig').gopls.setup{}
lua require('coc')
" lua require('dap')

