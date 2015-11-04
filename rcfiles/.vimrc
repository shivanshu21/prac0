" Use pathogen to manage plugins
" call pathogen#infect()
" call pathogen#helptags()
" See http://www.vim.org/scripts/script.php?script_id=2332

" Options
set nocompatible
set shell=bash
set history=400
set gfn=Monospace\ 11
set encoding=utf-8
set so=7
set wildmenu
set ruler
set cmdheight=1
set nu
set et
set t_Co=256
set background=dark

colorscheme elflord

" Enable spell check
" set spell


"Do not redraw, when running macros.. lazyredraw
"set lz
set hid
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l
"set wrap
set ignorecase
set incsearch
set magic
set noerrorbells
set novisualbell
set t_vb=
set showmatch
set mat=2
set hlsearch
set autoread
"set mouse=a
"Set mapleader
set laststatus=2
set statusline=\ %n:%f%m%r%y%=%l:%c/%L\ \
set nobackup
set nowb
set noswapfile
set noar
"set expandtab
set shiftwidth=4
set softtabstop=4
"set tabstop=4
set backspace=2
set smarttab
set lbr
set tw=500
set autoindent
set smartindent
set cindent
"set textwidth=72

syntax enable

let mapleader = " "
let g:mapleader = " "

filetype plugin on
filetype indent on

" Keymaps
nmap <leader>w :w!<cr>
nmap <leader>f :e ~/buffer<cr>

" vimdiff key maps
nnoremap <leader>u :diffupdate<cr>
nnoremap <leader>g :diffget<cr>
nnoremap <leader>p :diffput<cr>

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=c<cr>
map <leader>2 :set syntax=cpp<cr>
map <leader>3 :set syntax=perl<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

"Smart way to move btw. windows
map <c-j> <C-W>j
map <c-k> <C-W>k
map <c-h> <C-W>h
map <c-l> <C-W>l

map <leader>l <C-W>v
map <leader>j <C-W>s
map <leader>e :bn<cr>
if has("gui_running")
	map <m-right> :bn<cr>
	map <m-left> :bp<cr>
endif

"Switch to current dir
map <leader>cd :cd %:p:h<cr>

autocmd BufEnter * :syntax sync fromstart

"Comment for C like languages
autocmd BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css inoremap $c /**<cr>  **/<esc>O

"Remap VIM 0
map 0 ^

"Fast open a buffer by search for a name
map <c-q> :sb

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

set diffopt=filler,context:100000

"Tab switching
map <leader>, :bp<cr>
map <leader>. :bn<cr>

if filereadable("./cscope.out")
 cs add cscope.out
endif
set ruler

if has("terminfo")
    let &t_Co=16
    let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
    let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
else
    let &t_Co=16
    let &t_Sf="\<Esc>[3%dm"
    let &t_Sb="\<Esc>[4%dm"
endif

if &term =~ "xterm"
    if has("terminfo")
	let &t_Co=8
	let &t_Sf="\<Esc>[3%p1%dm"
	let &t_Sb="\<Esc>[4%p1%dm"
    else
	let &t_Co=8
	let &t_Sf="\<Esc>[3%dm"
	let &t_Sb="\<Esc>[4%dm"
    endif
endif
let g:DoxygenToolkit_commentType = "C++"


" Added by vineethk
" NACL shortcuts
map! ,ns  $Test->step("");<ESC>==A<ESC>3ha
map! ,nd  $Test->description("");<ESC>==A<ESC>3ha
map! ,api $response = $ngsh_apiset->{$SiteA}->();<ESC>==o@parsed_output = @{$response->get_parsed_output()};<ESC>==k$3ha

" make vim know that thpl is actually perl
:au Syntax thpl runtime! syntax/perl.vim


set diffopt+=iwhite
set foldmethod=diff

" Taglist plugin
nnoremap <silent> <F8> :TlistToggle<CR>

highlight MyGroup ctermbg=red guibg=red
2match MyGroup "\s\+$"
