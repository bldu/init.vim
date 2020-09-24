"---------------------------------------------------------------------------
" My configuration
"---------------------------------------------------------------------------


"------------------------------------------------
" general
"------------------------------------------------


syntax enable

set title               "display title on the top of window
set showcmd
set nu                  "display line number
set hlsearch            "highlight search
set incsearch           "Incremental search
set redrawtime=10000    "To ensure syntax highlighting always works on large files
set ignorecase          " case insensative matching
set wildignorecase      " case insensative in command mode.
set wildmenu            " command mode auto completion
set wildmode=longest,list "Complete longest common string, then list alternatives.
set autoread
set clipboard=unnamed
set autowrite
set ruler
set cursorline
set magic
set foldcolumn=0
set foldmethod=manual
set foldlevel=3
"set foldenable
set noeb
set confirm
set autoindent
"set smartindent
"set cindent
set expandtab  "To insert space characters whenever the tab key is pressed
set tabstop=4  "number of space characters that will be inserted when the tab key is pressed
set shiftwidth=4  "To change the number of space characters inserted for indentation
set smarttab
set history=1000
set nobackup
set noswapfile
set gdefault
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8
set helplang=cn
set viminfo+=!
set iskeyword+=_,$,@,%,#,-
set linespace=0
set backspace=2
set whichwrap+=<,>,h,l
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set report=0
set fillchars=vert:\ ,stl:\ ,stlnc:\
set showmatch
set matchtime=1
set scrolloff=3
set completeopt=longest,menu    " Options for Insert mode completion
set splitbelow
set splitright 
set nostartofline
"set colorcolumn=80 "mark the 80th column
"set textwidth=80
"set formatoptions
"set linebreak

"combination of |filetype on|, |filetype plugin on| and |filetype indent on|
filetype plugin indent on

"highlight Comment cterm=italic   " font of comment(the font should support italic)
highlight comment cterm=NONE


" Map <Esc> to switch to normal mode from terminal mode. 
" Acutally, one can use <C-D> to exit terminal.
"tnoremap <Esc> <C-\><C-n>






"" automatically change the current working directory according to the current
"" file. https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
"autocmd BufEnter * silent! lcd %:p:h

" automatically change working directory to the path to current file. but /tmp is
" excluded. 
augroup change_to_current_workdir
    autocmd!
    autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
augroup end

" Uncomment the following to have Vim jump to the last position when
" reopening a file
augroup restore_position
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup end

" <Leader> and <LocalLeder>
let mapleader="<space>"
let maplocalleader=";"

set encoding=utf-8


"------------------------------------------------
"  plugin manager  vim-plug
"------------------------------------------------


call plug#begin(stdpath('data') . '/plugged')

""[
"Plug 'vim-syntastic/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
""]


" Color scheme[
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/seoul256.vim'
"] end color scheme



" begin fzf [
"Note: Tab key can be used for multiple selection in History session

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"] end fzf



" begin markdown [

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 1
" Disable conceal for code fences.
let g:vim_markdown_conceal_code_blocks = 0


Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_browser = 'Safari'
augroup markdown_preview_my_settings
    autocmd!
    autocmd FileType markdown  setlocal updatetime=100
augroup end

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

"] end markdown



" begin indentLine [

Plug 'Yggdroot/indentLine'
let g:indentLine_enabled = 0
"indentLine will overwrite 'conceal' color with grey by default. If you want to highlight conceal color with your colorscheme, disable by:
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0

"] end indentLine



" begin airline [

Plug 'vim-airline/vim-airline'

let g:airline_powerline_fonts = 1

" enable tabline?
let g:airline#extensions#tabline#enabled = 0
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = ' '
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" make statistics for whitespaces and tabs?
let g:airline#extensions#whitespace#enabled = 0


"] end airline



"make tags
Plug 'majutsushi/tagbar'
noremap <F3> :TagbarToggle<CR>



"make structure tree
Plug 'scrooloose/nerdtree'
noremap <F2> :NERDTreeToggle<CR>




""Coc configuration [

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

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
  set signcolumn=auto
endif



"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" To navigate forward/backward of a snippet placeholder
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" navigate diagnostics
nmap <silent> 'gp <Plug>(coc-diagnostic-prev)
nmap <silent> 'gn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> 'gd <Plug>(coc-definition)
nmap <silent> 'gt <Plug>(coc-type-definition)
nmap <silent> 'gi <Plug>(coc-implementation)
nmap <silent> 'gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <space>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup coc_setup
    autocmd!
    "get correct comment highlighting in json file
    autocmd FileType json syntax match Comment +\/\/.\+$+
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

"nnoremap <silent> 'ca  :<C-u>CocCommand actions.open<cr>
nnoremap <silent> 'c   :<C-u>CocCommand<cr>


"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)


"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')
"
"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> 'ld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> 'le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> 'lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> 'lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> 'ls  :<C-u>CocList -I symbols<cr>
" open coc market
nnoremap <silent> 'lm  :<C-u>CocList marketplace <cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""]end Coc configuration


" begin tex[
"vimtex
Plug 'lervag/vimtex', {'for': 'tex'}

let g:vimtex_view_method = 'skim'
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode=2
let g:vimtex_view_automatic = 1
let g:vimtex_view_skim_activate = 1
let g:vimtex_quickfix_open_on_warning=0
"let g:vimtex_compiler_progname = 'nvr'  "disable for gui, or disable if you
"don't need backward search from skim to terminal nvim. 

""enable network with YCM[
"if !exists('g:ycm_semantic_triggers')
"    let g:ycm_semantic_triggers = {}
"  endif
"  au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
""]

""latex pdf live preview
"Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}

" more powerful tex conceal support
"Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'bldu/tex-conceal.vim', {'for': 'tex', 'branch': 'bldu-patch-1'}

"]end tex




"snippets for many languages, loaded by other snippet engines
Plug 'honza/vim-snippets'


Plug 'tpope/vim-surround'





" begin auto pairs [

Plug 'jiangmiao/auto-pairs'
" re-specify pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
"
let g:AutoPairsMapBS = 0
"
let g:AutoPairsCenterLine = 0
"
let g:AutoPairsMultilineClose = 0
" add $|$ pair for tex
augroup autopair_my_settings
    autocmd!
    autocmd BufRead,BufNewFile *.tex 
    \ let b:AutoPairs = AutoPairsDefine({'$' : '$'})
augroup end

" ] end auto-pairs




"begin rainbow[
Plug 'luochen1990/rainbow'
if has("gui_vimr")
    let g:rainbow_active = 1
endif
"]end rainbow






" begin autoformat [
let g:python3_host_prog='/usr/local/bin/python3'
Plug 'Chiel92/vim-autoformat'
noremap <F4> :Autoformat<CR>
"disable autoindent for filetypes that have incompetent indent files
augroup autoformat_my_settings
    autocmd!
    autocmd FileType vim,tex let b:autoformat_autoindent=0
augroup end

"] end autoformat



" begin easymotion [
Plug 'easymotion/vim-easymotion'
"] end easymotion






" begin which-key [
" in principle, this plugin should be put in the below of all other keymaps. 

"do not use lazy load feature for this plugin, it may cause highlight error
"otherwise.
Plug 'liuchengxu/vim-which-key'


"let g:which_key_use_floating_win = 0

let g:which_key_map =  {}
autocmd VimEnter * call which_key#register('<space>', 'g:which_key_map')
nnoremap <silent> <Space>  :<c-u>WhichKey "<Space>"<CR>
vnoremap <silent> <Space>  :<c-u>WhichKeyVisual "<Space>"<CR>

let g:coc_key_map =  {}
autocmd VimEnter * call which_key#register("'", 'g:coc_key_map')
nnoremap <silent> '        :<c-u>WhichKey "'"<CR>
vnoremap <silent> '        :<c-u>WhichKeyVisual "'"<CR>

let g:vimtex_key_map =  {}
autocmd VimEnter * call which_key#register(";", 'g:vimtex_key_map')
nnoremap <silent> ;        :<c-u>WhichKey  ";"<CR>
vnoremap <silent> ;        :<c-u>WhichKeyVisual  ";"<CR>


let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }


" easymotion configuration from 
"https://github.com/liuchengxu/vim-which-key/issues/10#issuecomment-432767186
let g:which_key_map['m'] = {
      \ 'name' : '+Easymotion ' ,
      \ 'f' : ['<plug>(easymotion-prefix)f' , 'find {char} to the right'],
      \ 'F' : ['<plug>(easymotion-prefix)F' , 'find {char} to the left'],
      \ 't' : ['<plug>(easymotion-prefix)t' , 'till before the {char} to the right'],
      \ 'T' : ['<plug>(easymotion-prefix)T' , 'till after the {char} to the left'],
      \ 'w' : ['<plug>(easymotion-prefix)w' , 'beginning of word forward'],
      \ 'W' : ['<plug>(easymotion-prefix)W' , 'beginning of WORD forward'],
      \ 'b' : ['<plug>(easymotion-prefix)b' , 'beginning of word backward'],
      \ 'B' : ['<plug>(easymotion-prefix)B' , 'beginning of WORD backward'],
      \ 'e' : ['<plug>(easymotion-prefix)e' , 'end of word forward'],
      \ 'E' : ['<plug>(easymotion-prefix)E' , 'end of WORD forward'],
      \ 'g' : {
        \ 'name' : '+Backwards ' ,
        \ 'e' : ['<plug>(easymotion-prefix)ge' , 'end of word backward'],
        \ 'E' : ['<plug>(easymotion-prefix)gE' , 'end of WORD backward'],
        \ },
      \ 'j' : ['<plug>(easymotion-prefix)j' , 'line downward'],
      \ 'k' : ['<plug>(easymotion-prefix)k' , 'line upward'],
      \ 'n' : ['<plug>(easymotion-prefix)n' , 'jump to latest "/" or "?" forward'],
      \ 'N' : ['<plug>(easymotion-prefix)N' , 'jump to latest "/" or "?" backward.'],
      \ 's' : ['<plug>(easymotion-prefix)s' , 'find(search) {char} forward and backward.'],
      \ }



"jump to latest buffer
"let g:which_key_map['<tab>'] = [':buffer#' , 'latest buffer']
nnoremap <space><tab> :buffer#<cr>

let g:which_key_map.b = {'name' : '+buffers'}

nnoremap <space>bb :<C-u>Buffers<cr> 
let g:which_key_map.b.b = 'buffer list(fzf)'
nnoremap <space>bn :bn<CR>
let g:which_key_map.b.n = 'next buffer'
nnoremap <space>bp :bp<CR>
let g:which_key_map.b.p = 'previous buffer'
nnoremap <space>bd :bd<CR>
let g:which_key_map.b.d = 'delete buffer'
nnoremap <space>bl  <C-^>
let g:which_key_map.b.l = 'latest buffer'


"open the help document for the key word under current cursor. 
let g:which_key_map.K   = 'help'


nnoremap <space>k :Helptags<cr>
let g:which_key_map.k   = 'help tags(fzf)'

nnoremap <space>h :History<cr>
let g:which_key_map.h   = 'file history(fzf)'

nnoremap <space>H :History:<cr>
let g:which_key_map.H   = 'command history(fzf)'

nnoremap <space>c :Command<cr>
let g:which_key_map.c = 'command(fzf)'
"let g:which_key_map[' '] = [':Command<cr>' , 'command(fzf)']


"open terminal in a split resized window.
"Name the chain of commands as Sterm 
command! Sterm split | resize -10 | term
nnoremap <space>t :Sterm<cr>
let g:which_key_map.t   = 'terminal'




" coc keymap naming
let g:coc_key_map.l = {'name' : '+CocList'}
let g:coc_key_map.c = {'name' : 'CocCommand'}
let g:coc_key_map.g = {'name' : '+Coc-goto'}



" vimtex keymap naming
let g:vimtex_key_map.l = {'name': '+VimTexCommands'}


"After pressing leader the guide buffer will pop up when there are no further keystrokes within timeoutlen.
" By default timeoutlen is 1000 ms
set timeoutlen=100

"] end which-key



call plug#end() "end plugin




"------------------------------------------------
" configuration after plugins
"------------------------------------------------
"put configurations that maybe changed accidentally by plugins here.

" set the color for matched pairs
hi MatchParen cterm=none ctermbg=green ctermfg=blue   "for terminal  
hi MatchParen gui=none guibg=none guifg=violet        "for gui


" style of the highlight for current line. 
" Should be placed after vim-airline if vim-airline is enabled since
" vim-airline can change this group.
"hi CursorLine cterm=NONE ctermbg=236 ctermfg=none gui=none guibg=Grey19 guifg=none

""""""""""""""""""""""""""""""""""""""""""
"  configuration for specified filetype  "
""""""""""""""""""""""""""""""""""""""""""

"begin tex[
let g:tex_conceal='abdmg'
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
"let g:tex_conceal_frac=1

augroup LaTeX_my_settings
    autocmd!
"    autocmd FileType tex setlocal spell spelllang=en_us
"    autocmd FileType tex hi clear SpellBad
"    autocmd Filetype tex hi  SpellBad   cterm=underline "ctermfg=red
    autocmd FileType tex setlocal conceallevel=2
    autocmd FileType tex hi Conceal ctermfg=darkblue  "set color of conceal
    autocmd FileType tex setlocal indentexpr=
    autocmd FileType tex setlocal textwidth=80
    autocmd FIleType tex setlocal formatoptions
augroup end
"] end tex


"begin fortran[
augroup fortran_my_settings
    autocmd!
    autocmd BufRead,BufNewFile *.f   let b:fortran_fixed_source=1
    autocmd BufRead,BufNewFile *.for let b:fortran_fixed_source=1
    autocmd BufRead,BufNewFile *.F   let b:fortran_fixed_source=1
    autocmd BufRead,BufNewFile *.f90 let b:fortran_free_source=1
augroup end

let fortran_do_enddo=1
let fortran_have_tabs=1
let fortran_more_precise=1
"] end fortran


"begin markdown[
augroup markdown_my_settings
    autocmd!
    autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md setlocal ft=markdown
"    autocmd FileType markdown setlocal spell spelllang=en_us
"    autocmd FileType markdown hi clear SpellBad
"    autocmd Filetype markdown hi  SpellBad   cterm=underline "ctermfg=red
"    autocmd FileType markdown setlocal conceallevel=2
"    autocmd FileType markdown hi Conceal ctermfg=darkblue  "set color of conceal
    autocmd FileType markdown setlocal textwidth=80
    autocmd FIleType markdown setlocal formatoptions
augroup end
"] end markdown






"---------------------------------------------------------------------------
" colorscheme
"---------------------------------------------------------------------------
"note this should be put at the bottom of this file, otherwise some errors
"might occur
colorscheme onedark
