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
"Vundle��·��
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
"����İ�װ·��
call vundle#begin('$VIM/vimfiles/bundle/')
 
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/indentpython.vim'    "�Զ����� 
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'chriskempson/base16-vim' "base16-vim����
Plugin 'tmhedberg/SimpylFold'	"�Զ��۵�
Plugin 'scrooloose/syntastic'   "�﷨����
Plugin 'nvie/vim-flake8'	"�﷨����
Plugin 'universal-ctags/ctags'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

"base16-vim����
colorscheme base16-default-dark

"�﷨����
let python_highlight_all=1
syntax on

"PEP8��������
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
" ��ݼ�������
nmap <F5> :NERDTreeToggle<CR>

"����ϵͳ���а�
set clipboard=unnamed

"��ʾ�к�
set nu

"��ʶ����Ҫ�Ŀհ�
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"ctrlp
"set runtimepath^=$VIM/bundle/ctrlp.vim

"  Gvim���Ĳ˵�����������
" �����ļ������ʽ
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1,gbk,gb18030,gk2312
if has("win32")
 set fileencoding=chinese
else
 set fileencoding=utf-8
endif

"����˵�����
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"���consle��ʾ��Ϣ�������
language messages zh_CN.utf-8

"�ļ��������,���Լ���ļ��ĺ�׺
filetyp on
"��װtagbar���
Bundle 'majutsushi/tagbar'
"����tagbarʹ�õ�ctags�Ĳ��,����Ҫ���ö�
let g:tagbar_ctags_bin='D:\vim\vimfiles\bundle\ctags'
"����tagbar�Ĵ��ڿ��
let g:tagbar_width=30
"����tagbar�Ĵ�����ʾ��λ��,Ϊ���
let g:tagbar_left=1
"���ļ��Զ� ��tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"ӳ��tagbar�Ŀ�ݼ�
map <F8> :TagbarToggle<CR>

"�����С
set guifont=set guifont=DejaVu\ Sans\ Mono:h11

"�հ׸���
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
