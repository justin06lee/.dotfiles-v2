" load plugins with vim-plug
call plug#begin('~/.vim/plugged')

" UI / workflow
Plug 'morhetz/gruvbox' " theme -
Plug 'mhinz/vim-startify' " starting screen -
Plug 'ryanoasis/vim-devicons' " icons -
Plug 'wfxr/minimap.vim' " minimap
Plug 'ntpeters/vim-better-whitespace' " highlights whitespace
Plug 'ap/vim-css-color' " highlights hex codes and such with the respective colors
Plug 'godlygeek/tabular' " aligns selected text to entered character
Plug 'christoomey/vim-titlecase' " converts selected text to titlecase
Plug 'amix/open_file_under_cursor.vim' " opens filepaths' files
" fzf core (installs the binary if needed)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree' " file tree
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'Xuyuanp/nerdtree-git-plugin'
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

" Snippets (SnipMate + deps)
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate' " autocompletes if statements, forloops, etc
Plug 'honza/vim-snippets' " snipmate extension for more autocompletion

" Indentation / visuals
Plug 'nathanaelkane/vim-indent-guides' " visualize indentations more easily

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'typescriptreact', 'javascriptreact'] }
Plug 'philj56/vim-asm-indent'

" MRU / misc
Plug 'yegappan/mru' " Most Recently Used files
Plug 'tpope/vim-commentary' " comment out things with a keybind
Plug 'tpope/vim-abolish' " enhanced replacement
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
set regexpengine=2
set fillchars+=eob:\ 

" Global default: real tabs, width 8
set noexpandtab
set tabstop=8
set shiftwidth=8
set softtabstop=8

augroup BigFileMode
  autocmd!
  autocmd BufReadPre * if getfsize(expand('%')) > 2*1024*1024 || line('$') > 5000
        \ | setlocal syn=off nocursorline nolazyredraw
        \ | let b:bigfile=1
        \ | try | IndentGuidesDisable | catch | endtry
        \ | endif
augroup END

" Helper to switch a buffer to space-indentation at a given width
function! s:UseSpaceIndent(width) abort
	let &l:expandtab   = 1
	let &l:shiftwidth  = a:width
	let &l:softtabstop = a:width
	let &l:tabstop     = a:width
endfunction

" Optional quick toggles for the current buffer
nnoremap <leader>ti :setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2<CR>
nnoremap <leader>to :setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4<CR>
nnoremap <leader>tp :setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0<CR>

if exists('+pumblend')
	set pumblend=20
endif
if exists('+winblend')
	set winblend=20
endif

augroup TransparentBackground
    autocmd!
    autocmd VimEnter,ColorScheme *
        \ hi Normal ctermbg=NONE guibg=NONE |
        \ hi NormalNC ctermbg=NONE guibg=NONE |
        \ hi NonText ctermbg=NONE guibg=NONE |
        \ hi SignColumn ctermbg=NONE guibg=NONE |
        \ hi LineNr ctermbg=NONE guibg=NONE |
        \ hi FoldColumn ctermbg=NONE guibg=NONE |
        \ hi EndOfBuffer ctermbg=NONE guibg=NONE |
        \ hi VertSplit ctermbg=NONE guibg=NONE
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
set lbr
set tw=500
set ai
set si
set wrap

" Search visual selection with * or #
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
	let l:saved_reg = @"
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

nnoremap <silent> <leader>rh :noh<cr>
map ; $
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

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

nnoremap H <<
nnoremap L >>

xnoremap H :<C-u>call VisualNudgeLeft()<CR>
xnoremap L :<C-u>call VisualNudgeRight()<CR>

function! VisualNudgeLeft() abort
  let l1 = line("'<")
  let l2 = line("'>")
  if l1 != l2
    return '<'
  endif
  let s = getline(l1)
  let c1 = col("'<")
  let c2 = col("'>")
  if c1 > c2
    let [c1, c2] = [c2, c1]
  endif
  if c1 <= 1
    normal! gv
    return
  endif
  " Build new line: [before-left] [SEL] [left-char] [after]
  let left_before = strpart(s, 0, c1 - 2)
  let sel         = strpart(s, c1 - 1, c2 - c1 + 1)
  let left_char   = strpart(s, c1 - 2, 1)
  let after       = strpart(s, c2)
  call setline(l1, left_before . sel . left_char . after)

  let new_c1 = c1 - 1
  let new_c2 = c2 - 1
  call setpos("'<", [0, l1, new_c1, 0])
  call setpos("'>", [0, l1, new_c2, 0])
  normal! gv
endfunction

function! VisualNudgeRight() abort
  let l1 = line("'<")
  let l2 = line("'>")
  if l1 != l2
    return '>'
  endif
  let s = getline(l1)
  let c1 = col("'<")
  let c2 = col("'>")
  if c1 > c2
    let [c1, c2] = [c2, c1]
  endif
  let line_len = strlen(s)
  if c2 >= line_len
    normal! gv
    return
  endif
  " Build new line: [before] [right-char] [SEL] [after-after]
  let before      = strpart(s, 0, c1 - 1)
  let right_char  = strpart(s, c2, 1)
  let sel         = strpart(s, c1 - 1, c2 - c1 + 1)
  let after_after = strpart(s, c2 + 1)
  call setline(l1, before . right_char . sel . after_after)

  let new_c1 = c1 + 1
  let new_c2 = c2 + 1
  call setpos("'<", [0, l1, new_c1, 0])
  call setpos("'>", [0, l1, new_c2, 0])
  normal! gv
endfunction

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

if has('clipboard')
	set clipboard^=unnamed,unnamedplus

	" Wayland (Hyprland/Sway): prefer wl-clipboard
	if executable('wl-copy')
		let g:clipboard = {
		\ 'name': 'wl-clipboard',
		\ 'copy':  { '+': ['wl-copy', '--type', 'text/plain', '--foreground'],
		\            '*': ['wl-copy', '--type', 'text/plain', '--foreground'] },
		\ 'paste': { '+': ['wl-paste', '--no-newline'],
		\            '*': ['wl-paste', '--no-newline'] },
		\ 'cache_enabled': 1,
	\ }
	" X11 fallback
	elseif executable('xclip')
		let g:clipboard = {
		\ 'name': 'xclip',
		\ 'copy':  { '+': ['xclip', '-selection', 'clipboard'],
		\            '*': ['xclip', '-selection', 'primary'] },
		\ 'paste': { '+': ['xclip', '-selection', 'clipboard', '-o'],
		\            '*': ['xclip', '-selection', 'primary', '-o'] },
		\ 'cache_enabled': 1,
	\ }
	endif
endif

" close current buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
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
nnoremap <leader>bd :Bclose<cr>:tabclose<cr>gT
nnoremap <leader>ba :bufdo bd<cr>
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>e :e ~/buffer<cr>
nnoremap <leader>x :e ~/buffer.md<cr>

command! WipeReg for i in range (34, 122) | silent! call setreg(nr2char(i), '') | endfor
nnoremap <leader>wr :WipeReg<cr>

nnoremap <leader>wf :w<cr>
nnoremap <leader>wa :wa<cr>
nnoremap <leader>qs :wqa<cr>
nnoremap <leader>qf :q!<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
nnoremap <leader>fwf :W<cr>

nnoremap Q q
nnoremap q <Nop>

" Basic auto-pairs (all filetypes)
augroup AutoPairsBasic
	autocmd!
	autocmd FileType * inoremap <buffer> ( ()<Left>
	autocmd FileType * inoremap <buffer> [ []<Left>
	autocmd FileType * inoremap <buffer> { {}<Left>
augroup END

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
  if exists('*ShouldExpandHTMLTag') && ShouldExpandHTMLTag()
    return "\<C-o>:call ExpandHTMLTag()\<CR>"
  endif

  " 2b) Go-only: expand 'ife' -> if err != nil {<CR>panic(err)<CR>}
  if ShouldExpandGoIfe()
    return "\<C-o>:call ExpandGoIfe()\<CR>"
  endif

  " 3) Otherwise, SnipMate (expand or jump)
  return "\<Plug>snipMateNextOrTrigger"
endfunction

function! ShouldExpandGoIfe() abort
  if &filetype !=# 'go'
    return 0
  endif
  " Grab text up to (but not including) cursor (Vim is 1-based; col('.') is next char index)
  let prefix = strpart(getline('.'), 0, col('.') - 1)
  " Expand only when the word before cursor is exactly 'ife'
  return prefix =~# '\<ife$'
endfunction

function! ExpandGoIfe() abort
  " Keep indentation of current line
  let lnum    = line('.')
  let indentS = matchstr(getline(lnum), '^\s*')

  " Replace current line with block and put cursor at end of the panic(...) line
  call setline(lnum,     indentS . 'if err != nil {')
  call append(lnum,      indentS . '	panic(err)')
  call append(lnum + 1,  indentS . '}')

  " Place cursor at end of 'panic(err)' line
  call cursor(lnum + 1, strlen(indentS . '    panic(err)') + 1)
endfunction

inoremap <expr> <CR> <SID>SmartCR()

function! s:AngleBracketAllowed() abort
  " Allow angle brackets in these base filetypes
  let l:allowed = [
        \ 'html','xhtml','xml',
        \ 'jsx','tsx','typescriptreact','javascriptreact',
        \ 'typescript','javascript',
        \ 'svelte','vue','astro',
        \ 'php','blade','eruby','ejs','hbs'
        \ ]

  " Split compound filetypes like 'javascript.jsx' into ['javascript','jsx']
  let l:fts = split(&filetype, '\.')

  " True if ANY part of the (possibly compound) filetype is in the allowlist
  for l:ft in l:fts
    if index(l:allowed, l:ft) != -1
      return v:true
    endif
  endfor
  return v:false
endfunction

function! s:IsPair(o, c) abort
	return (a:o ==# '(' && a:c ==# ')')
		\ || (a:o ==# '[' && a:c ==# ']')
		\ || (a:o ==# '<' && a:c ==# '>' && s:AngleBracketAllowed())
		\ || (a:o ==# "'" && a:c ==# "'")
		\ || (a:o ==# '`' && a:c ==# '`')
endfunction

function! s:IsSpecialPair(o, c) abort
	return (a:o ==# '"' && a:c ==# '"')
endfunction

function! s:IsSpecialPair2(o, c) abort
	return (a:o ==# '{' && a:c ==# '}')
endfunction

function! s:SmartCR() abort
	let ln = getline('.')
	let cc = charcol('.')              " character-aware (Unicode-safe)
	if cc > 1 && cc <= strchars(ln)
		let o = strcharpart(ln, cc - 2, 1)
		let k = strcharpart(ln, cc - 1, 1)
		if s:IsPair(o, k) && (&filetype ==# 'go')
			return "\<CR>\<C-o>O\<C-t>"
		endif

		if s:IsPair(o, k)
			return "\<CR>\<C-o>O"
		endif

		if s:IsSpecialPair(o, k)
			return "\<CR>\<BS>\<C-o>O\<C-t>\<BS>"
		endif

		if s:IsSpecialPair2(o, k) && (&filetype ==# 'rust' || &filetype ==# 'c')
			return "\<CR>\<C-o>O"
		endif


		if s:IsSpecialPair2(o, k)
			return "\<CR>\<BS>\<C-o>O"
		endif 
	endif
	return "\<CR>"
endfunction

augroup SmartPythonTriples
	autocmd!
	autocmd FileType python inoremap <buffer> <expr> " <SID>PyTripleQuote()
augroup END

function! s:PyTripleQuote() abort
	" Only special-case inside Python and when just after a #
	if &filetype ==# 'python'
		let ln = getline('.')
		let cc = charcol('.')
		if cc > 1 && strcharpart(ln, cc - 2, 1) ==# '#'
			" Delete the # and insert a triple-quoted block, cursor on middle line
			return "\<BS>\"\"\"\<CR>\<CR>\"\"\"\<Up>\t"
		else
			return s:InsQuote('"')
		endif
	endif
	return '"'
endfunction

" persistent undo setup
if has('persistent_undo')
	let s:undo_dir = expand('~/.vim/temp_dirs/undodir')
	if !isdirectory(s:undo_dir)
		" create it with strict perms so Vim can write to it
		call mkdir(s:undo_dir, 'p', 0700)
	endif
	" use // so filenames include full paths (avoids collisions)
	set undodir^=~/.vim/temp_dirs/undodir//
	set undofile
endif

cno <Space><Space>h e ~/
cno <Space><Space>d e ~/Desktop/
cno <Space><Space>j e ./

cno <Space><Space>q <C-\>eDeleteTillSlash()<cr>

vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>

iab xdate <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr>

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

fun! DeleteTillSlash()
	let g:cmd = getcmdline()
	let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
	return g:cmd_edited
endf

augroup AngleAutoClose
	autocmd!
	autocmd FileType html,xhtml,xml,jsx,tsx,typescriptreact,javascriptreact,svelte,vue,astro,javascript,typescript,php inoremap <buffer> < <><Left>
augroup END

" --- Markdown (no folding) ---
let vim_markdown_folding_disabled = 1

let MRU_Max_Entries = 400
map <leader>uf :MRU<CR>

let g:yankstack_yank_keys = ['y', 'd']

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste

map <leader>j :Files<cr>
map <leader>k :Buffer<cr>
nnoremap <leader>/ :Rg<Space>

let g:fzf_layout = { 'down': '~40%' }   " popup height
let g:fzf_preview_window = ['right:50%', 'ctrl-/']  " toggle with <C-/>
let $FZF_DEFAULT_OPTS='--height 40% --reverse'

" Use ripgrep for source lists if available (fast + respects .gitignore)
if executable('rg')
	let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git"'
	command! -nargs=* Rg call fzf#vim#grep(
		\ 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" '.shellescape(<q-args>), 1,
		\ fzf#vim#with_preview(), 0)
endif

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
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 35

map <leader>of :NERDTreeFind<cr>
map <leader>ot :NERDTreeToggle<cr>
map <leader>oc :NERDTreeClose<cr>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

nnoremap <leader>ig :IndentGuidesToggle<cr>

vnoremap <leader>? :Tabularize /

vnoremap <leader>sm :sort<cr>
vnoremap <leader>/ <Plug>Titlecase

autocmd VimEnter *
      \ if !argc() && !exists('s:std_in') |
      \   Startify |
      \   execute 'bd!' bufnr('%') |
      \ endif

nnoremap <leader>et :MundoToggle<cr>

let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0

nnoremap <leader>ma :MinimapToggle<cr>

let g:better_whitespace_enabled = 0
nnoremap <leader>wh :ToggleWhitespace<cr>

nnoremap <leader>go :call GotoFile("edit")<cr>

nnoremap <leader>ln :call <SID>ToggleLineNumbers()<cr>
nnoremap <leader>lr :call <SID>ToggleRelativeNumbers()<cr>
nnoremap <Leader>ll :call <SID>ToggleBothNumbers()<cr>

function! s:ToggleLineNumbers()
	set norelativenumber number
endfunction

fun! s:ToggleRelativeNumbers()
	set nonumber relativenumber
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

" --- Disable all code folding everywhere ---
set nofoldenable       " don't open with folds enabled
set foldlevelstart=99  " open all folds
set foldmethod=manual  " don't auto-fold by syntax/markers


" Assumes you've set mapleader already.

" Format to width 130, reflow whole buffer, remove double spaces (not indent), clear highlights
function! s:FormatToWidth() abort
  " --- save local options ---
  let l:save_tw = &l:textwidth
  let l:save_fo = &l:formatoptions
  let l:save_ai = &l:autoindent
  let l:save_si = &l:smartindent
  let l:save_ci = &l:cindent
  let l:save_ie = &l:indentexpr
  let l:save_et = &l:expandtab

  try
    " target width
    setlocal textwidth=120

    " minimize formatter-induced indent changes
    setlocal noautoindent nosmartindent nocindent indentexpr=
    " don't use "second line indent" during formatting
    setlocal formatoptions-=2

    " ensure any new/continuation indent uses spaces, not tabs
    setlocal expandtab

    " reflow whole buffer, keep cursor/view
    let l:view = winsaveview()
    silent! keepjumps normal! gggqG
    call winrestview(l:view)

    " collapse runs of 2+ spaces *between non-space chars* (don’t touch leading/trailing indent)
    " very-magic: (\S) {2,} (\S)  -> \1 \2
    silent! keeppatterns %s/\v(\S) {2,}(\S)/\1 \2/ge

    " clear search highlight
    nohlsearch
  finally
    " --- restore local options ---
    let &l:textwidth   = l:save_tw
    let &l:formatoptions = l:save_fo
    let &l:autoindent  = l:save_ai
    let &l:smartindent = l:save_si
    let &l:cindent     = l:save_ci
    let &l:indentexpr  = l:save_ie
    let &l:expandtab   = l:save_et
  endtry
endfunction

nnoremap <leader>dtw :call <SID>FormatToWidth()<CR>
" Delete without copying (visual mode)

xnoremap <silent> <leader>dd "_d

" Wipe the entire file (delete all lines without yanking)
nnoremap <silent> <leader>wipe :silent! %delete _<CR>

augroup ForceTabs
  autocmd!
  autocmd FileType * setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
augroup END

function! WipeSpreadPair() abort
  " Define the pairs we look for
  let s:pairs = {
        \ '(': ')',
        \ '[': ']',
        \ '{': '}',
        \ '<': '>',
        \ }

  let cur_line = line('.')
  let cur_col  = col('.')
  
  let best_opener = ''
  let best_pos    = [0, 0]

  for [opener, closer] in items(s:pairs)
    let pos = searchpairpos('\V'.opener, '', '\V'.closer, 'bnW')
    
    if pos[0] > 0
      if pos[0] > best_pos[0] || (pos[0] == best_pos[0] && pos[1] > best_pos[1])
        let best_pos    = pos
        let best_opener = opener
      endif
    endif
  endfor

  let bt_prev = searchpos('`', 'bnW', line('.'))
  let bt_next = searchpos('`', 'nW', line('.'))
  if bt_prev[0] > 0 && bt_next[0] > 0
    if bt_prev[0] > best_pos[0] || (bt_prev[0] == best_pos[0] && bt_prev[1] > best_pos[1])
      let best_opener = '`'
      let best_pos = bt_prev
    endif
  endif

  if best_pos[0] > 0
    let cmd_char = best_opener
    if cmd_char ==# '<' | let cmd_char = '>' | endif

    execute 'normal! di' . cmd_char
    return
  endif

  let next_opener_pat = '[\(\[\{\<`]'
  let next_pos = searchpos(next_opener_pat, 'nW', line('.'))
  
  if next_pos[0] > 0
    call cursor(next_pos[0], next_pos[1])
    let char = getline('.')[next_pos[1]-1]
    
    execute 'normal! di' . char
  else
    echo "No surrounding or nearby pair found."
  endif
endfunction

nnoremap <silent> <leader><leader> :call WipeSpreadPair()<CR>i

nnoremap 2 5<C-e>
nnoremap 9 5<C-y>

xnoremap 2 5<C-e>
xnoremap 9 5<C-y>

augroup NoIndentExprExceptPython
  autocmd!
  autocmd FileType * if &filetype !=# 'python' | setlocal indentexpr= | endif
augroup END

packloadall
