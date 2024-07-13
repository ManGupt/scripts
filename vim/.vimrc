source /etc/vimrc
:set nocompatible    " Use Vim defaults (much better!)
:set bs=indent,eol,start     " allow backspacing over everything in insert mode
:set viminfo='20,\"50    " read/write a .viminfo file, don't store more than 50 lines of registers
:set history=50      " keep 50 lines of command line history

:set title
:set ruler
:set hls is ic
:set autoindent
:set showmode
:set showcmd
:set ts=4
:set sw=4
:set expandtab
:set wrap
:syntax on
:colorscheme gruvbox
:set guifont=Monospace\ 11
":set guifont=Consolas:h11
:set bg=dark
:set bg=light
:set nu
command TN tabnew
command NT tabnext
command PT tabprev
command W w
command Q q
command F qa!
command S wqa!
command B %!xxd
command Wqa wqa
command WQa wqa
command WQA wqa
command WqA wqa
command Wa wa
command WA wa
command Qa qa
command QA qa
command Wq wq
command WQ wq
command Sh sh
command SH sh
command Sp sp
command VSP vsp
command VSp vsp
command Vsp vsp
command Lcd lcd %:p:h
command LCd lcd %:p:h
command LCD lcd %:p:h
command SD set syntax=diff
command SNW set nowrap
command SW set wrap
"set permanent status line
:set ls=2
"set file prompt in status bar for choice
:set wildmenu
"set 80 column bar
:match Error "\%160v"
:match WarningMsg "\%80v"
:set formatoptions+=ro
:set tabpagemax=20
":set diffopt=filler,horizontal
au BufRead,BufNewFile *.proto set filetype=tcl
au BufRead,BufNewFile *.sv set filetype=verilog
au BufRead,BufNewFile *.ts set filetype=javascript
au BufRead,BufNewFile *.seg set filetype=json
