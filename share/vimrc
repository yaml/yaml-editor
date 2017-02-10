" Settings for YAML:
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nosmartindent

" YAML Editor netrw custom settings:
let g:netrw_list_hide= '.*\.swp$,^.vimrc$,^\.\./$,^\./$,^help$,^TEST.tml$'
let g:netrw_banner=0

" YAML Editor vim settings:
set number
set switchbuf=useopen
set autoread exrc

" YAML Editor hotkeys:
map \o :rightbelow split .<cr>
map \O :rightbelow vsplit .<cr>
map <SPACE> :call RunYAML()<cr><cr>
map \g :call RunYAML()<cr>:wa<bar>!eval 'gist-paste *.*'<cr>
nnoremap \t :call WriteTestml()<cr><cr>
nnoremap \s :call SaveTestml()<cr><cr>
map \c :sb input.yaml<cr><bar>ggVGd
map \Q :qa!<cr>
map \q :q<cr>
map \8 <c-w>80<bar>
map \= <c-w>=
map \_ <c-w>_
map \<bar> <c-w><bar>
map \n :windo set number!<cr>
map \h :!(clear; less -FRX help)<cr>
map \l :!(clear; yaml-editor -l <bar> less -FRX)<cr>

" Handy window commands:
nnoremap <c-j> <c-w>j<c-w><Esc>
nnoremap <c-k> <c-w>k<c-w><Esc>
nnoremap <c-l> <c-w>l<c-w><Esc>
nnoremap <c-h> <c-w>h<c-w><Esc>

" YAML Editor command functions:
function RunYAML()
  sb input.yaml
  write
  execute "!timeout 5 yaml-editor RUN"
endfunction

function WriteTestml()
  sb input.yaml
  write
  rightbelow vsplit `yaml-editor TESTML`
  wincmd L
endfunction

function SaveTestml()
  sb input.yaml
  write
  let file = system("yaml-editor SAVE")
  execute "rightbelow vsplit" file
  wincmd L
endfunction

" A minimal YAML theme from the web:
if exists("b:did_indent")
  finish
endif
"runtime! indent/ruby.vim
"unlet! b:did_indent
let b:did_indent = 1

setlocal autoindent sw=2 et
setlocal indentexpr=GetYamlIndent()
setlocal indentkeys=o,O,*<Return>,!^F

highlight TabsWhitespace ctermbg=blue guibg=blue
autocmd VimEnter,WinEnter,BufNewFile,BufRead * match TabsWhitespace /\t/
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd VimEnter,WinEnter,BufNewFile,BufRead * call matchadd('ExtraWhitespace', '\ \+$')
" autocmd BufNewFile,BufRead * call matchadd('ExtraWhitespace', '\s\+$')

function! GetYamlIndent()
  let lnum = v:lnum - 1
  if lnum == 0
    return 0
  endif
  let line = substitute(getline(lnum),'\s\+$','','')
  let indent = indent(lnum)
  let increase = indent + &sw
  if line =~ ':$'
    return increase
  else
    return indent
  endif
endfunction
