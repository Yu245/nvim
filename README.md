# nvim
## Requirments
- junegunn/vim-plug
- npm, yarn: for iamcco/markdown-preview.nvim

## Vim-Plug Installation
    md ~\AppData\Local\nvim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile(
      $uri,
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\AppData\Local\nvim-data\site\autoload\plug.vim"
      )
    )
