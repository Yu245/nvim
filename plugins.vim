call plug#begin()
    Plug 'cocopon/iceberg.vim'
    Plug 'fcpg/vim-farout'
    Plug 'jeffreyiacono/vim-colors-wombat'
    Plug 'itchyny/lightline.vim' "ステータスライン
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " ブラウザ内でNeovim
    Plug 'lervag/vimtex' "Tex
    Plug 'plasticboy/vim-markdown' | Plug 'previm/previm'
    Plug 'dense-analysis/ale' " リンター
    Plug 'prabirshrestha/async.vim' | Plug 'prabirshrestha/vim-lsp' | Plug 'mattn/vim-lsp-settings' | Plug 'prabirshrestha/asyncomplete.vim' | Plug 'prabirshrestha/asyncomplete-lsp.vim' " lsp関連
    Plug 'ionide/Ionide-vim', {
    \ 'do':  'make fsautocomplete',
    \} " F#
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " markdown
    Plug 'tyru/eskk.vim'
call plug#end()
