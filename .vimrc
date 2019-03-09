" 设定 doc 文档目录
"let helptags=$VIM."/vimfiles/doc"
"set helplang=cn

" for 異常設定
" insert mode 下，backspace 正常動作
set backspace=indent,eol,start
" 不使用與 VI 相容的模式，使用 vim 新功能，例：tab 自動補齊
set nocompatible
" BUG:http://bugs.debian.org/608242
set t_RV=
" 關閉使用可視化響鈴
set novisualbell
" 置空錯誤鈴聲的終端程式碼
set t_vb=

" 顯示行號
set number
" 顯示對應行號
set relativenumber
" 顯示目前行列
set ruler
" 顯示目前的 mode
set showmode
" 顯示目前指令
set showcmd

" 保留個人設定的語法 Highlight
syntax enable
" 預設語法 Highlight
" syntax on

" 在命令列，補齊時出現選單
set wildmenu
" 在命令列，補齊依序設定
" 1. 補成最長可能性並列出選單
" 2. 選擇完整指令
set wildmode=longest:list,full

" 自動對齊縮排：如果上一行有兩個 tab 的寬度，按 enter 繼續編輯下一行時會自動保留兩個 tab 鍵的寬度
set autoindent
" 影響 shiftwidth 和 tabstop 行為
" 若 shiftwidth=8, tabstop=4
" 行首鍵入 <TAB> 會產生 8 個空格距離，其他地方鍵入 <TAB> 會產生 4 個空格距離
set smarttab
set shiftwidth=4
set tabstop=4
" 將 <TAB> 轉為空格
set expandtab
" 影響刪除 <TAB> 空格的動作，但不影響刪除 <Space> 的動作
set softtabstop=4

" 標示目前行數
set nocursorline

" 偵測檔案類型
filetype on
" 依檔案類型進行縮排
filetype indent on
" 依檔案類型載入相關 plugin
filetype plugin on

" 輸入括號時，單獨顯示對應括號
set showmatch
" 顯示對應括號的時間，1 表示 100ms
set matchtime=1

" Search 後，highlight 所有匹配字
set hlsearch
" Search 時，自動跳到目標
set incsearch
" Search 忽略大小寫
set ignorecase
" Search 若關鍵字有大寫，則忽略 ignorecase 設定
set smartcase

" 移動時，保留的行數
set scrolloff=5

" 備份設定
set nobackup
" 交換文件設定 
set noswapfile
" undo 備存設定
set noundofile

"顯示不可見字元，並設定不可見字元的對應符號
set list listchars=eol:¬,tab:▸\ ,trail:.,

" 設定為暗色系
set background=dark
" 設定配色主題
colorscheme torte

" 功能鍵超時檢測，會影響 insert mode 到 nomarl mode 的切換時間
set ttimeoutlen=10

" 設定參數
let codingFT = ['go', 'python']

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" 中文化（簡體）幫助文件
"Plug 'asins/vimcdoc'

" 檔案樹狀圖
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 模糊搜索
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 自動完成
Plug 'Valloric/YouCompleteMe'", { 'for': codingFT }
" 語法檢查
Plug 'scrooloose/syntastic', { 'for': codingFT }

" Git
Plug 'tpope/vim-fugitive', { 'for': codingFT }
"Plug 'airblade/vim-gitgutter', { 'for': codingFT }

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': codingFT[0] }

" Python 格式化代碼
Plug 'ambv/black', { 'for': codingFT[1] }

" Initialize plugin system
call plug#end()


"=====================================
" Plugin Setting
"===================================

" vim-go settings
let g:go_fmt_command = "goimports"
"let g:go_list_type = "quickfix"
set completeopt-=preview

" ycm
let g:ycm_autoclose_preview_window_after_completion=1
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0

" airline
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"" fzf.vim
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_COMMAND = "rg --files --smart-case --no-ignore-vcs --hidden"

" syntastic
let g:syntastic_go_checkers = ['govet', 'golint', 'errcheck']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" black
autocmd BufWritePre *.py execute ':Black'

" gitgutter
"set updatetime=100


"=============================
" HotKey Map
"=============================

" vim
let mapleader = ","
nmap YY "+yy<CR>
vmap Y "+y<CR>
nmap P "+p<CR>
vmap P "+p<CR>
nmap <Leader>cd :lcd %:p:h<CR>
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" vim-go settings
map <C-n> :lnext<CR>
map <C-p> :lprevious<CR>
nnoremap <leader>a :lclose<CR>
imap <F12> <C-x><C-o>

" ycm
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"" NERDTree configuration
nnoremap <F3> :NERDTreeFind<CR>
nnoremap <F4> :NERDTreeToggle<CR>

"" fzf.vim
nmap <Leader>e :FZF<CR>
nmap <Leader>f :Lines<CR>
nmap <Leader>c :Commands<CR>
nmap <Leader>m :Maps<CR>
nmap <Leader>w :Windows<CR>
nmap <Leader>b :Buffers<CR>

" ripgrep
nmap <Leader>F :Rg<CR>


"=============================
" Specail
"=============================
"
" 插入模式為直條線，替代模式為下底線
if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif


