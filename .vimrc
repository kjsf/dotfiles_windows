" Kez's Vim for Windows

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'andrewradev/tagalong.vim'
Plug 'preservim/nerdcommenter'
Plug 'ap/vim-css-color'
Plug 'KabbAmine/vCoolor.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-mix-format'
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'sainnhe/sonokai'
" Plug 'junegunn/goyo.vim'
" Plug 'slashmili/alchemist.vim'
" Plug 'elixir-editors/vim-elixir'
" Plug 'mbbill/undotree'

call plug#end()

" Set leader key
let mapleader = " "

" Settings and basic config
syntax on
filetype plugin indent on

set nocompatible
set relativenumber
set nu
set encoding=utf-8
set showmode
set showcmd
set ttyfast
set ruler
set backspace=indent,eol,start

set noerrorbells

" Disable visual bell and flashing
set belloff=all

set clipboard=unnamedplus
set mouse=a

" Enables yank for vim in win 10
nnoremap y "*y
vnoremap y "*y

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set wildmenu
set wildchar=<TAB>

set splitright splitbelow

set scrolloff=8

" Fix vim startup replace mode
set t_u7=

" Set search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set nohlsearch

" Disable Automatic comment on newline
autocmd Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Undo tree
nnoremap <F5> :UndotreeToggle<cr>

" Auto delete white space
autocmd BufWritePre * :%s/\s\+$//e

" Window navigations
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-t> <C-w>T
inoremap <C-h> <C-w>h
inoremap <C-j> <C-w>j
inoremap <C-k> <C-w>k
inoremap <C-l> <C-w>l
inoremap <C-t> <C-w>T

" Use leader w and leader s for split windows
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j

" Window resizing
nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap } <C-w>>
nnoremap { <C-w><lt>
nnoremap = <C-w>=

" View pwd
noremap <silent><nowait> <leader>p :pwd<CR>

" Edit vimrc
noremap <silent><nowait> <leader>V :tabnew $MYVIMRC<CR>

" Move lines up or down visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Move lines indention
vnoremap > >gv
vnoremap < <gv

" Vimgrepper
let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Search and replace opts
nnoremap <Leader>cf :cfdo %s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nnoremap <Leader>bf :bufdo %s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" Full screen then :wq
noremap <silent><leader>v :tab split<CR>

" Indent guide
let g:indent_guides_start_level = 4
let g:indent_guides_guide_size = 2

" Remove search highlight
nnoremap <silent><leader><space> :noh<cr>

" Color settings
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic_comment = 1

" Set colorscheme
set background=dark
colorscheme sonokai

" Cursor Settings

" Cursor line in insert mode
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

set guicursor=
if &term =~ '^xterm'
  " normal mode
  let &t_EI .= "\<Esc>[0 q"
  " insert mode
  let &t_SI .= "\<Esc>[0 q"
endif

" Set bg transparent overides colorscheme
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE

" Fzf
let $FZF_DEFAULT_OPTS = '-m --bind ctrl-a:select-all'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" Fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Fzf mappings
nnoremap <silent> <C-p> :Files <CR>
nnoremap <silent> <Leader>F :Rg <CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>C :Commands<CR>
nnoremap <silent> <Leader>l :BLines<CR>
nnoremap <silent> <Leader>f :Lines<CR>
nnoremap <silent> <Leader>M :Maps<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" Rg command
command! -bang -nargs=* Rg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "
      \ .shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Tagalong
let g:tagalong_verbose = 1

" vCoolor
let g:vcoolor_map = '<C-k>h'
let g:vcool_ins_rgb_map = '<C-k>r'
let g:vcool_ins_hsl_map = '<C-k>H'
let g:vcool_ins_rgba_map = '<C-k>R'
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_custom_picker = 'zenity --title "Zenity" --color-selection --show-palette --color '

" Nerdtree
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeIgnore = ['\.sw\w$']
nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" Coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-elixir',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-sql',
  \ 'coc-docker'
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" CoCList Mappings

" Show all diagnostics.
nnoremap <silent><nowait> <space>aC  :<C-u>CocList diagnostics<cr>

" Manage extensions.
nnoremap <silent><nowait> <space>eC  :<C-u>CocList extensions<cr>

" Show commands.
nnoremap <silent><nowait> <space>cC  :<C-u>CocList commands<cr>

" Find symbol of current document.
nnoremap <silent><nowait> <space>oC  :<C-u>CocList outline<cr>

" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nnoremap <silent><nowait> <C-j> :<C-u>CocNext<CR>

" Do default action for previous item.
nnoremap <silent><nowait> <C-k>  :<C-u>CocPrev<CR>

" Coc Restart
nnoremap <silent><nowait> <space>z  :<C-u>CocRestart<cr>

" Coc status line integration
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Lightline
let g:lightline = {
  \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus', 'currentfunction' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'colorscheme': 'sonokai',
      \ }
set laststatus=2

" Templating workaround
autocmd BufWritePre *.ejs :setfiletype html
autocmd BufWritePost *.ejs :setfiletype jst
autocmd BufWritePre *.html.eex :setfiletype  html
autocmd BufWritePre *.json.eex :setfiletype  json
autocmd BufWritePost *.eex :setfiletype eelixir

" Elixir mix format
let g:mix_format_on_save = 1

" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Markdown preview
nnoremap <silent> <Leader>m :silent! MarkdownPreview<CR>
