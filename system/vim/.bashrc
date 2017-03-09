丢到当前用户的根目录即可，保存为 .bashrc 文件。

"关闭兼容模式，避免以前版本的局限
set nocompatible

"关闭启动界面
set shortmess=atI

"自动缩进
set autoindent
set smartindent
set shiftwidth=4
set cindent

"tab替换为4个空格
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

"显示行号
set number

"显示状态栏
set ruler

"语法检查和高亮
syntax on

"显示括号对
set showmatch

"高亮搜索匹配项
set hlsearch

"随着输入即时显示匹配项
set incsearch

"状态栏显示正在输入的命令
set showcmd

"突出显示当前行
set cursorline

"是否自动备份
set nobackup

"编码设置
set encoding=utf8
set fileencoding=utf8

"检测文件类型，可设置语法高亮、特定选项等
"查看当前设置：filetype
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
autocmd FileType set omnifunc=phpcomplete

"保存关闭时的光标位置
autocmd BufReadPost *
    \ if line("'\"")>0&&line("'\"")<=line("$") |
    \ exe "normal g'\"" |
    \ endif
