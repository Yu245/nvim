if !exists('$XDG_CONFIG_HOME')
    let $XDG_CONFIG_HOME = expand('<sfile>:p:h')
endif

" vim-plugでプラグイン管理
if filereadable(expand($XDG_CONFIG_HOME.'/plugins.vim'))
  source $XDG_CONFIG_HOME/plugins.vim
endif

set fenc=utf-8
set ff=unix

syntax on

set termguicolors

set autowrite
set hidden
set splitbelow
set splitright
"バッファを開くとcd
set autochdir

set ignorecase
set smartcase
nmap <Esc><Esc> :nohlsearch<CR><Esc> 

set number
set list
set showcmd
set cursorline
"set nocursorcolumn
set virtualedit=all
set showmatch

set clipboard=unnamed 
" ポップアップ半透明化
set pumblend=10

set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set smarttab

nnoremap <Space>h ^
nnoremap <Space>l $
vnoremap <Space>h ^
vnoremap <Space>l $
" ウィンドウ移動時ノーマルモードに戻さなくて良い
tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <Esc> <C-\><C-n>

inoremap jj <esc>
inoremap っｊ <esc>
nnoremap k gk
nnoremap j gj
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap ｊ j
nnoremap ｋ k
nnoremap ｌ l
nnoremap ｈ h
nnoremap ｐ p
nnoremap <Space>w :w<CR>
" 設定ファイル開く
nnoremap <C-,> :e $MYVIMRC<CR>
" ウィンドウサイズ変更
nnoremap <A--> <C-w>-
nnoremap <A-+> <C-w>+
nnoremap <M-lt> <C-w><
nnoremap <A->> <C-w>>

augroup setIndent
    autocmd!
    " C/C++/Java 言語系のファイルタイプが設定されたら cindent モードを有効にする
    autocmd FileType c,cpp,java  setl cindent
augroup END

" テンプレート
augroup templateGroup
    autocmd!
    autocmd BufNewFile *.cpp 0r $XDG_CONFIG_HOME\templates\template.cpp
    autocmd BufNewFile *.tex 0r $XDG_CONFIG_HOME\templates\template.tex
    autocmd BufNewFile *.html 0r $XDG_CONFIG_HOME\templates\template.html
augroup END

"" ステータスバー設定
"set statusline=%{'\|\|'}%{g:MODE()}%{'\|\|'}\ %t\ %m%r%h%w[%Y][%{&fenc}][%{&ff}]%=\%{g:Date()}C:%04c,L:%04l/%04L
"" インサートモード時の色変更
"let g:hi_insert = 'highlight StatusLine guifg=DarkSlateGray guibg=OliveDrab gui=none ctermfg=DarkGreen ctermbg=black cterm=none'
"if has('syntax')
"  augroup InsertHook
"    autocmd!
"    autocmd InsertEnter * call s:StatusLine('Enter')
"    autocmd InsertLeave * call s:StatusLine('Leave')
"  augroup END\%{g:Date()}
"endif
" 
"let s:slhlcmd = ''
"function! s:StatusLine(mode)
"  if a:mode == 'Enter'
"    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"    silent exec g:hi_insert
"  else
"    highlight clear StatusLine
"    silent exec s:slhlcmd
"  endif
"endfunction
"
"function! g:MODE()
"    if mode() == 'n'
"        return 'NORMAL'
"    elseif mode() == 'i'
"        return 'INSERT'
"    elseif mode() == 'v'
"        return 'VISUAL'
"    elseif mode() == 't'
"        return 'TERMINAL'
"    elseif mode() == 'c'
"        return 'CMDLINE'
"    elseif mode() == 's'
"        return 'SELECT'
"    elseif mode() == 'r'
"        return 'REPLACE'
"    else
"        return 'UNKNOWN'
"    endif
"endfunction
" 
"function! s:GetHighlight(hi)
"  redir => hl
"  exec 'highlight '.a:hi
"  redir END
"  let hl = substitute(hl, '[\r\n]', '', 'g')
"  let hl = substitute(hl, 'xxx', '', '')
"  return hl
"endfunction
" 
" ステータスラインに日時を表示する
"function! g:Date()
"    let weeks = [ "(日)", "(月)", "(火)", "(水)", "(木)", "(金)", "(土)" ]
"    let wday = strftime("%w")
"    return strftime('%Y/%m/%d').weeks[wday].strftime(' %H:%M')
"endfunction

function! Compile()
    let l:extension = expand("%:e")
    if &filetype == 'tex'
        execute ":!lualatex %:p"
    elseif &filetype == 'cpp'
        execute "!g++ -std=c++17 -o %:r %"
    elseif &filetype == 'c'
        execute "!cc -o %:r %"
    elseif &filetype == 'haskell'
        let binName = expand("%")[0:strlen(expand("%"))-4]
        let bin = ":!ghc % -o " . binName
        execute bin
    elseif &filetype == 'python'
        execute ":!python3 %"
    endif
endfunction

function! Run()
    if &filetype == 'cpp' || &filetype == 'c'
        execute ":! \./%:r"
    elseif &filetype == 'tex'
        let l:pdfName = expand("%:r") . "\.pdf"
        if has("win64")
            execute ":! start " . l:pdfName
        elseif has("unix")
            execute ":! xdg-open " . l:pdfName
        elseif has("mac")
            execute ":! open " . l:pdfName
        endif
    elseif &filetype == 'haskell'
        execute ":! runghc %"
    elseif &filetype == 'python'
        execute ":! python3 %"
    endif
endfunction

command! Compile call Compile()
command! Run call Run()
command! Nya :te nyagos

nnoremap <F9> :Compile<cr>
nnoremap <F5> :Run<cr>

"" 空のバッファを作る
"let buf = nvim_create_buf(v:false, v:true)
"" そのバッファを使って floating windows を開く
"call nvim_open_win(buf, v:true, {'relative': 'win', 'height': 1, 'width': 5, 'col': 1, 'row': -1})
"" 半透明にする
"set winblend=30

" ファイラー設定
" netrwは常にtree view
let g:netrw_liststyle=3
" サイズを(K,M,G)で表示
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" ヘッダを非表示にする
let g:netrw_banner=0

colorscheme wombat

" lightline設定
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \}

"フォーカスしていない時の背景色
let g:InactiveBackGround = 'guibg=#000020 ctermbg=0'

"Neovim内でフォーカスしていないペインの背景色設定
execute ('hi NormalNC '.g:InactiveBackGround)
execute ('hi NontextNC '.g:InactiveBackGround)
execute ('hi SpecialkeyNC '.g:InactiveBackGround)
execute ('hi EndOfBufferNC '.g:InactiveBackGround)

" previm設定
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:previm_open_cmd = 'firefox'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

"vimtex
let g:vimtex_view_general_viewer = 'start'

" eskk
" set imdisable
let g:eskk#enable_completion = 1
let g:eskk#server = {
\   'host': 'localhost',
\   'port': 55100,
\}
autocmd User eskk-initialize-pre call s:eskk_initial_pre()
function! s:eskk_initial_pre()
    let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
    call t.add_map(',', '，')
    call t.add_map('.', '．')
    call eskk#register_mode_table('hira', t)
    let t = eskk#table#new('rom_to_kata*', 'rom_to_kata')
    call t.add_map(',', '，')
    call t.add_map('.', '．')
    call eskk#register_mode_table('kata', t)
endfunction

" ローカル設定
if filereadable(expand($HOME.'/.localsettings/vimrc_local'))
  source $HOME/.localsettings/vimrc_local
endif
