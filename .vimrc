" Dracula
packadd! dracula
syntax enable
colorscheme dracula

set number " Enable line numbers
set relativenumber "Enable relative line numbers
syntax on 
set colorcolumn=80

" Inspect $TERM instad of t_Co as it works in neovim as well
if &term =~ '256color'
  " Enable true (24-bit) colors instead of (8-bit) 256 colors.
  " :h true-color
  if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  colorscheme dracula
endif
