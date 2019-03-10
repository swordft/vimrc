source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

if has('vim_starting')
   set nocompatible               " Be iMproved
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif




filetype off
"Vundle的路径
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
"插件的安装路径
call vundle#begin('$VIM/vimfiles/bundle/')
 
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/indentpython.vim'    "自动缩进 
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'chriskempson/base16-vim' "base16-vim主题
Plugin 'tmhedberg/SimpylFold'	"自动折叠
Plugin 'scrooloose/syntastic'   "语法高亮
Plugin 'nvie/vim-flake8'	"语法高亮
Plugin 'universal-ctags/ctags'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

"base16-vim主题
colorscheme base16-default-dark

"语法高亮
let python_highlight_all=1
syntax on

"PEP8代码缩进
"au BufNewFile,BufRead *.py
\ set tabstop=4
\ set softtabstop=4
\ set shiftwidth=4
\ set textwidth=79
\ set expandtab
\ set autoindent
\ set fileformat=unix

"NERD
let NERDTreeWinSize=20
let NERDTreeWinPos="left"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" 快捷键的配置
nmap <F5> :NERDTreeToggle<CR>

"访问系统剪切板
set clipboard=unnamed

"显示行号
set nu

"标识不必要的空白
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"ctrlp
"set runtimepath^=$VIM/bundle/ctrlp.vim

"  Gvim中文菜单乱码解决方案
" 设置文件编码格式
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1,gbk,gb18030,gk2312
if has("win32")
 set fileencoding=chinese
else
 set fileencoding=utf-8
endif

"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"解决consle提示信息输出乱码
language messages zh_CN.utf-8

"文件侦查启动,用以检测文件的后缀
filetyp on
"安装tagbar插件
Bundle 'majutsushi/tagbar'
"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='D:\vim\vimfiles\bundle\ctags'
"设置tagbar的窗口宽度
let g:tagbar_width=30
"设置tagbar的窗口显示的位置,为左边
let g:tagbar_left=1
"打开文件自动 打开tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"映射tagbar的快捷键
map <F8> :TagbarToggle<CR>

"字体大小
set guifont=set guifont=DejaVu\ Sans\ Mono:h11

"空白高亮
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
