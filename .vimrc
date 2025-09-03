" load plugins with vim-plug
call plug#begin('~/.vim/plugged')

" UI / workflow
Plug 'morhetz/gruvbox' " theme -
Plug 'mhinz/vim-startify' " starting screen -
Plug 'ryanoasis/vim-devicons' " icons -
Plug 'wfxr/minimap.vim' " minimap
Plug 'junegunn/vim-peekaboo' " view registers contents
Plug 'ntpeters/vim-better-whitespace' " highlights whitespace
Plug 'ap/vim-css-color' " highlights hex codes and such with the respective colors
Plug 'godlygeek/tabular' " aligns selected text to entered character
Plug 'christoomey/vim-titlecase' " converts selected text to titlecase
Plug 'amix/open_file_under_cursor.vim' " opens filepaths' files
Plug 'ctrlpvim/ctrlp.vim' " fuzzy finder
Plug 'preservim/nerdtree' " file tree
Plug 'jlanzarotta/bufexplorer' " nerd tree kinda thing but for buffers
Plug 'preservim/tagbar' " tags ('checkpoints' kinda thing) sidebar for a file
Plug 'simnalamburt/vim-mundo' " undo tree
Plug 'junegunn/goyo.vim' " zen room (centers all text, gives you a distraction free writing space)
Plug 'amix/vim-zenroom2' " upgrade for goyo

" Editing motions / text objects
Plug 'terryma/vim-expand-region' " expansion in selection mode in logical steps
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire' " selection of entire files
Plug 'kana/vim-textobj-function' " selection of functions
Plug 'michaeljsmith/vim-indent-object' " selection of things in the same indentation level
Plug 'christoomey/vim-sort-motion' " sorts selected text
Plug 'maxbrunsfeld/vim-yankstack' " saves copy paste history so you can have a clipboard with multiple items
Plug 'inkarkat/vim-ReplaceWithRegister' " replace something with what's stored in your register without overriding it
Plug 'mg979/vim-visual-multi'

" Narrowing / focus
Plug 'chrisbra/NrrwRgn' " Narrow region - gives you buffer for what you selected so you can only edit that specific selection
Plug 'luochen1990/rainbow' " rainbow parentheses

" Linting / tags
Plug 'dense-analysis/ale' " linting
Plug 'ludovicchabant/vim-gutentags' " placing checkpoints or tags

" Languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'preservim/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nvie/vim-flake8'

" Snippets (SnipMate + deps)
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate' " autocompletes if statements, forloops, etc
Plug 'honza/vim-snippets' " snipmate extension for more autocompletion

" Indentation / visuals
Plug 'nathanaelkane/vim-indent-guides' " visualize indentations more easily
Plug 'Vimjas/vim-python-pep8-indent' " python indentation standards

" MRU / misc
Plug 'yegappan/mru' " Most Recently Used files
Plug 'tpope/vim-commentary' " comment out things with a keybind
Plug 'tpope/vim-abolish' " enhanced replacement
Plug 'wakatime/vim-wakatime' " wakatime
Plug 'farmergreg/vim-lastplace' " reopens files at last edit position

call plug#end()

"  clear all mappings
mapclear
nmapclear
vmapclear
xmapclear
omapclear
imapclear

" How many lines of history VIM has to remember
set history=500

" Enable filetype-specific plugins and indentation
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" leader key
let mapleader = " "

set so=4

let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu
set wildignore=*.o,*~,*.pyc,.git\*,.git

set number
set relativenumber

if has ('termguicolors')
    set termguicolors
endif

set background=dark
colorscheme gruvbox

set hid
set backspace=eol,start,indent
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=1
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1
syntax enable
set regexpengine=0
set fillchars+=eob:\ 

if exists('+pumblend')
	set pumblend=20
endif
if exists('+winblend')
	set winblend=20
endif

augroup TransparentBackground
	autocmd!
	autocmd VimEnter,ColorScheme * hi Normal ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi NormalNC ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi NonText ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi SignColumn ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi LineNr ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi FoldColumn ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi EndOfBuffer ctermbg=NONE guibg=NONE
	autocmd VimEnter,ColorScheme * hi VertSplit ctermbg=NONE guibg=NONE
augroup END

if has ("gui_running")
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
	set guitablabel=
endif
set encoding=utf8
set ffs=unix

set nobackup
set nowb
set noswapfile
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai
set si
set wrap

" Search visual selection with * or #
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
	let l: saved_reg = @"
	execute "normal! vgvy"
	let l:pattern = escape(@", "\\/.*'$^~[]")
	let l:pattern = substitute(l:pattern, "\n$", "", "")
	if a:direction == 'gv'
		call CmdLine("Ack '" . l:pattern . "' " )
	elseif a:direction == 'replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	endif
	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

fun! CmdLine(str)
	call feedkeys(":" . a:str)
endf

map <silent> <leader>rh :noh<cr>
map ; $
map <leader>cd :cd %:p:h<cr>:pwd<cr>

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set noshowmode
set noruler
set laststatus=0
set showtabline=0
map 0 ^

" move lines
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

" Delete trailing white space on save
fun! CleanExtraSpace()
	let save_cursor = getpos(".")
	let old_query = getreg("/")
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun
if has("autocmd")
	autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpace()
endif

set clipboard=unnamedplus

" close current buffer
command! Bclose call <SID>BufcloseCloseIt()
fun! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")
	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif
	if bufnr("%") == l:currentBufNum
		new
	endif
	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endf
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
map <leader>e :e ~/buffer<cr>
map <leader>x :e ~/buffer.md<cr>

command! WipeReg for i in range (34, 122) | silent! call setreg(nr2char(i), '') | endfor
map <leader>wr :WipeReg<cr>

nmap <leader>wf :w<cr>
nmap <leader>wa :wa<cr>
nmap <leader>qs :wqa<cr>
nmap <leader>qf :q!<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
nmap <leader>fwf :W<cr>

nnoremap Q q
nnoremap q <Nop>

" =========================
" Lightweight Auto-Pairs Kit
" =========================

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>

function! s:SmartBackspace() abort
  let c   = col('.') - 1
  let ln  = getline('.')
  let lb  = (c > 0)            ? ln[c - 1] : ''
  let la  = (c < len(ln))      ? ln[c]     : ''
  let pairs = {'(' : ')', '[' : ']', '{' : '}'}
  if has_key(pairs, lb) && pairs[lb] ==# la
    return "\<Right>\<BS>\<BS>"
  endif
  return "\<BS>"
endfunction
inoremap <expr> <BS> <SID>SmartBackspace()

inoremap <expr> ) getline('.')[col('.') - 1] ==# ')' ? "\<Right>" : ")"
inoremap <expr> ] getline('.')[col('.') - 1] ==# ']' ? "\<Right>" : "]"
inoremap <expr> } getline('.')[col('.') - 1] ==# '}' ? "\<Right>" : "}"
inoremap <expr> > getline('.')[col('.') - 1] ==# '>' ? "\<Right>" : ">"

inoremap <expr> " <SID>InsDQuote()
inoremap <expr> ' <SID>InsSQuote()
inoremap <expr> ` <SID>InsBQuote()

function! s:InsQuote(q) abort
  let c    = col('.')
  let ln   = getline('.')
  let prev = c > 1        ? ln[c-2] : ''
  let next = c <= len(ln) ? ln[c-1] : ''
  if next ==# a:q
    return "\<Right>"
  endif
  if prev ==# '\'
    return a:q
  endif
  if a:q ==# "'" && prev =~# '\k'
    return "'"
  endif
  if next ==# '' || next =~# '\s' || next =~# '[\)\]\}\>\,;:]'
    return a:q . a:q . "\<Left>"
  endif
  return a:q
endfunction

function! s:InsDQuote() abort
  return s:InsQuote('"')
endfunction
function! s:InsSQuote() abort
  return s:InsQuote("'")
endfunction
function! s:InsBQuote() abort
  return s:InsQuote('`')
endfunction

" --- TAB: jump over closers, or expand HTML shorthand, or SnipMate ---
inoremap <expr> <Tab> JumpOutOrTab_HTML_Snips()
smap    <expr> <Tab> JumpOutOrTab_HTML_Snips()

function! IsCloser(ch) abort
  return index([')', ']', '}', '>', '"', "'", '`'], a:ch) >= 0
endfunction

" Only expand when the thing right before the cursor looks like:
"   lowercase html tag + at least ONE .class (e.g., div.card, p.text-sm.leading-6)
" and it's preceded by a safe delimiter (start/space/;,(,[,{,=,>)
function! ShouldExpandHTMLTag() abort
  let ln      = getline('.')
  let c       = col('.')
  let before  = ln[:c-1]                    " up to cursor (1-based col)
  let after   = ln[c-1:]                    " from cursor onward

  " 1) Extract shorthand candidate immediately before cursor; REQUIRE at least one .class
  let pat = matchstr(before, '[a-z][a-z0-9-]*\%(\.[A-Za-z0-9_: -]\+\)\+$')
  if pat ==# ''
    return 0
  endif

  " 2) Ensure a safe delimiter before the shorthand (so we don't trigger in identifiers like 'if')
  let pre = matchstr(before, '.*\zs.')
  if pre !~# '\v(\s|^|[;,(\[{\=>])'
    return 0
  endif

  " 3) Optional: ensure we're not mid-word AFTER the cursor
  if strlen(after) > 0 && after[0] =~# '\k'
    return 0
  endif

  return 1
endfunction

function! JumpOutOrTab_HTML_Snips() abort
  " 1) Jump out of any consecutive closers
  let ln = getline('.')
  let c  = col('.')
  let n  = 0
  while c + n <= len(ln) && IsCloser(ln[c - 1 + n])
    let n += 1
  endwhile
  if n > 0
    return repeat("\<Right>", n)
  endif

  " 2) Expand HTML shorthand like 'div.card.mx-4'
  if ShouldExpandHTMLTag()
    return "\<C-o>:call ExpandHTMLTag()\<CR>"
  endif

  " 3) Otherwise, SnipMate (expand or jump)
  return "\<Plug>snipMateNextOrTrigger"
endfunction

inoremap <expr> <CR> <SID>SmartCR()
function! s:IsPair(o, c) abort
  return (a:o ==# '(' && a:c ==# ')')
        \ || (a:o ==# '[' && a:c ==# ']')
        \ || (a:o ==# '{' && a:c ==# '}')
        \ || (a:o ==# '<' && a:c ==# '>')
        \ || (a:o ==# '"' && a:c ==# '"')
        \ || (a:o ==# "'" && a:c ==# "'")
        \ || (a:o ==# '`' && a:c ==# '`')
endfunction

function! s:SmartCR() abort
  let c  = col('.')
  let ln = getline('.')
  if c > 1 && c <= len(ln)
    let o = ln[c - 2]
    let k = ln[c - 1]
    if s:IsPair(o, k)
      return "\<CR>\<Esc>O\<C-t>"
    endif
  endif
  return "\<CR>"
endfunction

set autoindent
set smartindent

try
	set undodir=~/.vim/temp_dirs/undodir
	set undofile
catch
endtry

cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $q <C-\>eDeleteTillSlash()<cr>

vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap < <esc>`>a><esc>`<i<<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>

iab xdate <c-r>=strftime("%d/%m/%y %h:%m:%s")<cr>

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

fun! DeleteTillSlash()
	let g:cmd = getcmdline()
	let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
	return g:cmd_edited
endf

" ==============================
" Passive Vim/Neovim configuration
" ==============================

" --- Python ---
let python_highlight_all = 1
augroup PassivePython
  autocmd!
  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType python syn keyword pythonDecorator True None False self
  autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
  autocmd BufNewFile,BufRead *.mako setfiletype mako
augroup END


" --- JavaScript (folding & indent behavior) ---
function! JavaScriptFold()
  setlocal foldmethod=syntax
  setlocal foldlevelstart=1
  " Fold regions between braces
  syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
  " Minimal fold text
  function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setlocal foldtext=FoldText()
endfunction

augroup PassiveJavaScript
  autocmd!
  autocmd FileType javascript call JavaScriptFold()
  autocmd FileType javascript setlocal foldenable
  autocmd FileType javascript setlocal nocindent
augroup END


" --- Git commit convenience (cursor at start) ---
augroup PassiveGit
  autocmd!
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
augroup END

" --- Twig templating as HTML ---
augroup PassiveTwig
  autocmd!
  autocmd BufRead *.twig set syntax=html filetype=html
augroup END


" --- Markdown (no folding) ---
let vim_markdown_folding_disabled = 1


" --- YAML (2-space indent, no tabs) ---
augroup PassiveYAML
  autocmd!
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END


let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>ob :BufExplorer<cr>

let MRU_Max_Entries = 400
map <leader>uf :MRU<CR>

let g:yankstack_yank_keys = ['y', 'd']

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste

let g:ctrlp_working_path_mode = 0

map <leader>j :CtrlP<cr>
map <leader>k :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20

let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee\|venv\|__pycache__\|\.pyc$\|\.cache\|\.next\|dist\|build\|target\|\.cargo'

inoremap <C-l> <Esc>:call <SID>ExpandHTMLTag()<CR>

function! ExpandHTMLTag()
    let line = getline('.')
    let col = col('.')
    let before_cursor = line[:col]
    let after_cursor = line[col:]
    let pattern = matchstr(before_cursor, '[a-zA-Z][a-zA-Z0-9]*\%(\.[a-zA-Z][a-zA-Z0-9_: -]*\)*$')
    if pattern != ''
        let parts = split(pattern, '\.')
        let tag = parts[0]
        let classes = join(parts[1:], ' ')
        if classes != ''
            let html = '<' . tag . ' className="' . classes . '"></' . tag . '>'
        else
            let html = '<' . tag . '></' . tag . '>'
        endif
        let new_before = substitute(before_cursor, '[a-zA-Z][a-zA-Z0-9]*\%(\.[a-zA-Z][a-zA-Z0-9_: -]*\)*$', '', '')
        let final_line = new_before . html . after_cursor
        call setline('.', final_line)
        if classes != ''
            let cursor_col = len(new_before) + len('<' . tag . ' className="' . classes . '">') + 1
        else
            let cursor_col = len(new_before) + len('<' . tag . '>') + 1
        endif
        call cursor(line('.'), cursor_col)
        startinsert
    endif
endfunction

let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden = 0
let g:NERDTreeWinSize = 35

map <leader>of :NERDTreeFind<cr>
map <leader>nb :NERDTreeFromBookmark<cr>
map <leader>ot :NERDTreeToggle<cr>
map <leader>oc :NERDTreeClose<cr>

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

nnoremap <leader>lg :IndentGuidesToggle<cr>

vnoremap <leader>? :Tabularize /

let g:smooth_scroll = 1

let g:cssColorVimDoNotMessMyUpdatetime = 1

vnoremap <leader>p :<C-u>call setreg('"', @*, getregtype('*'))<CR>gvgr
vnoremap <leader>sm :sort<cr>
vnoremap <leader>/ <Plug>Titlecase
nnoremap <leader>ov :TagbarToggle<cr>

let g:startify_enable_special = 0
let g:startify_files_number = 10
let g:startify_session_autoload = 'yes'
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 0

autocmd VimEnter * if !argc() | Startify | endif

nnoremap <leader>et :MundoToggle<cr>

let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0

nnoremap <leader>ma :MinimapToggle<cr>

nnoremap <leader>pk :Peekaboo<cr>

let g:better_whitespace_anabled = 0
let g:strip_whitespace_on_save = 0
nnoremap <leader>wh :ToggleWhitespace<cr>

nnoremap <C-o> :call GotoFile("edit")<cr>

nnoremap <leader>ai vai
nnoremap <leader>ia vii

let g:ale_linter = {
\	'javascript': ['eslint'],
\	'typescript': ['eslint', 'tsserver'],
\	'python': ['flake8'],
\	'go': ['go', 'golint', 'errcheck'],
\	'c': ['gcc', 'clang'],
\	'cpp': ['gcc', 'clang'],
\	'rust': ['cargo', 'rustc'],
\	'zig': ['zig'],
\	'dockerfile': ['hadolint'],
\	'markdown': ['markdownlint'],
\	'vim': ['vint'],
\	'htmldjango': ['djlint'],
\}

nnoremap e w
nnoremap w e

nmap <leader>an <Plug>(ale_next_wrap)
nmap <leader>ap <Plug>(ale_previous_wrap)
nmap <leader>af <Plug>(ale_fix)
nmap <leader>ad <Plug>(ale_detail)
nmap <leader>ah <Plug>(ale_hover)
nmap <leader>at :ALEToggle<cr>


let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

nnoremap <leader>ln :call <SID>ToggleLineNumbers()<cr>
nnoremap <leader>lr :call <SID>ToggleRelativeNumbers()<cr>
nnoremap <Leader>ll :call <SID>ToggleBothNumbers()<cr>

function! s:ToggleLineNumbers()
	set norelativenumber
	set number!
endfunction

fun! s:ToggleBothNumbers()
	set nonumber
	set relativenumber!
endf

fun! s:ToggleBothNumbers()
	let has_number = &number
	let has_relative = &relativenumber

	if has_number && has_relative
		set nonumber norelativenumber
	else
		set number relativenumber
	endif
endf

vnoremap . :Commentary<cr>

let g:VM_leader = '\'
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-s>'
let g:VM_maps['Find Subword Under'] = '<C-s>'
let g:VM_maps["Select All"] = '<C-a>'
let g:VM_maps["Visual All"] = '<C-s>'

nnoremap <silent> <leader>z :Goyo<cr>





