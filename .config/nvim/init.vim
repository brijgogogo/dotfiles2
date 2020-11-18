syntax on "turn syntax highlighting on
set backspace=indent,eol,start " allows backspace
set hidden " allows to have change not written in hidden buffers

" Indentation
set expandtab " pressing <TAB> inserts softtabstop amount of space characters
set shiftwidth=2 " tab to spaces on press of >>, << or ==
set softtabstop=2 " tab to spaces press of <TAB> or <BS>
" set autoindent " copies the indentation from the previous line, when starting a new line
" set smartindent " automatically inserts one extra level of indentation in some cases (like C-like files)
" https://vim.fandom.com/wiki/Indenting_source_code

set scrolloff=3
set sidescrolloff=5

" :help clipboard
set clipboard+=unnamedplus " use system clipboard
set number
set relativenumber

" see value of an option
" :echo &wrap

set nowrap
set linebreak " don't break words when wrapping text

set noswapfile
set nobackup
set nowritebackup

set autowrite " automatically writes if you call :make, etc.

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" persistent undo
" :help undo-persistence
" set undodir=~/.config/nvim/undodir
set undofile

" show bar on 80th column
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgray

" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vim/vimrc

let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.config/nvim/init.vim"

function!PrintRuntimePathValue()
	echo join(split(&runtimepath,','),"\n")
endfunction

command! PrintRTP call PrintRuntimePathValue()


set path=.,** " set path to current directory and all subdirectories


" leader keys (prefix keys)
let mapleader=','
let maplocalleader = "\\" " second leader key, meant to be a prefix for mappings that only take effect for certain file types


" set list " show invisible characters \t,\n (use :set list! to turn off)

" git clone minpac in .vim/pack/minpack/opt/
packadd minpac

call minpac#init()
call minpac#add('k-takata/minpac',{'type':'opt'}) " package manager
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-scriptease', {'type':'opt'})
call minpac#add('junegunn/fzf.vim')
" call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
" call minpac#add('leafgarland/typescript-vim')

call minpac#add('vimwiki/vimwiki')
call minpac#add('iamcco/markdown-preview.nvim', {'do': 'call mkdp#util#install()'})

call minpac#add('dbeniamine/todo.txt-vim')

call minpac#add('moll/vim-node')
call minpac#add('tpope/vim-vinegar') " netrw extensions
call minpac#add('lambdalisue/suda.vim') " sudo read/write

call minpac#add('kshenoy/vim-signature') " shows marks

" sessions
call minpac#add('mhinz/vim-startify')
call minpac#add('tpope/vim-obsession')

call minpac#add('tpope/vim-abolish')

" themes
call minpac#add('sonph/onehalf', {'subdir' : 'vim'})
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('dracula/vim')
call minpac#add('fatih/molokai')


call minpac#add('ryanoasis/vim-devicons')

" git
call minpac#add('tpope/vim-fugitive') " git commands from vim
call minpac#add('airblade/vim-gitgutter') " show git diff markers
call minpac#add('rhysd/git-messenger.vim') " see history of line
" call minpac#add('jreybert/vimagit')

" editing
call minpac#add('mbbill/undotree')

" programming
call minpac#add('ap/vim-css-color')
call minpac#add('mattn/emmet-vim')
" call minpac#add('preservim/nerdcommenter')
call minpac#add('tpope/vim-commentary') " code commenter
call minpac#add('tpope/vim-surround')
" call minpac#add('dense-analysis/ale')
" call minpac#add('neoclide/coc.nvim', { 'branch' : 'release' })
call minpac#add('fatih/vim-go', { 'do' : 'GoInstallBinaries' })
" call minpac#add('diepm/vim-rest-console')
" call minpac#add('aquach/vim-http-client')
call minpac#add('sgur/vim-editorconfig') " vim script based editor-config support
call minpac#add('neovim/nvim-lspconfig') " temp: neovim lsp client
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('SirVer/ultisnips')

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()


" :help mapping
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<CR>
" nnoremap <leader>ip :source $MYVIMRC<cr>:PackUpdate<cr>
nnoremap <leader>eb :tabedit ~/.bashrc<cr>
nnoremap <leader>et :tabedit ~/docs/cloud/dropbox_b1/Apps/Simpletask/todo.txt<cr>


" :help termguicolors
set termguicolors " enables true color
" set background=dark
" set t_Co=256
colorscheme onehalfdark " nord onehalflight
" let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai

" tabs
for i in range(1, 9)
  execute 'nnoremap <leader>'.i.' '.i.'gt<cr>'
endfor
ca tn tabnew
ca tc tabclose
nnoremap <expr> t ":tabnext +" . v:count1 . '<CR>'
nnoremap <expr> T ":tabnext -" . v:count1 . '<CR>'
" move tab left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>


" system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p

" FZF
let g:fzf_prefer_tmux = 1
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>h :History<CR>
" C-T : new tab
" C-X : new split
" C-V : new vertical split
" FZF - Tab to select multiple files, Alt-A to select all. Enter will populate
"

" the quickfix list (navigate using :cnext/prev of cn/cp)
map <C-j> :cn<cr>
map <C-k> :cp<cr>
map <leader>q :cclose<cr>
map <leader>Q :copen<cr>


map <C-f> :Rg<cr>

command! BufOnly execute '%bd|e#|bd#'


" buffers
nnoremap <space> :bnext<cr>
nnoremap <bs> :bprev<cr>
nnoremap <leader>ls :ls<cr>:b<space>

" nnn
" Disable default mappings
let g:nnn#set_default_mappings = 0
nnoremap <leader>n :NnnPicker<cr>
" Opens the nnn window in a split
" let g:nnn#layout = 'vnew' " or new, vnew, tabnew etc.
let g:nnn#layout = { 'left': '~30%' } " or right, up, down
" actions
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }


""""""" terminal mode """""""
if has('nvim' )
  " tnoremap <Esc> <C-\><C-n> " Esc to go to Normal mode from Terminal mode
  " tnoremap <C-v><Esc> <Esc> " To pass Esc to terminal
  "https://github.com/junegunn/fzf.vim/issues/544
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>

  highlight! link TermCursor Cursor
  " highlight terminal cursor red
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

command! Restart call jobsend(1, "\<C-c>npm run server\<CR>")

" if nvr (nvim-remote) executable exists, set $VISUAL to use it to avoid
" nested nvim
if has( 'nvim' ) && executable( 'nvr' )
  let $VISUAL= "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif



" vimwiki
let wiki1 = {'path':'/home/vik/docs/wiki', 'ext':'.md'}
let wiki2 = {'path':'/home/vik/docs/cloud/dropbox_b1/vimwiki'}
let g:vimwiki_list =[wiki1, wiki2]
nnoremap <leader>wn :lnext<CR>
nnoremap <leader>wp :lprev<CR>
nnoremap <leader>w<cr> :VimwikiSplitLink<cr>
nnoremap <leader>w<cr> :VimwikiTabnewLink<cr>

" search vimwiki with rg+fzf
command! -bang -nargs=* WikiSearch
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': '/home/vik/docs/wiki'}, <bang>0)

"=====[ Search ]=============
set hlsearch
set incsearch
set ignorecase
set smartcase " case sensitive search only when there is a capital letter
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>/ :g//#<Left><Left>

"=====[ Highlight matches when jumping to next ]=============
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

"=====[ Highlight the match in red ]=============
function! HLNext (blinktime)
  highlight WhiteOnRed ctermfg=white ctermbg=red guifg=#ffffff guibg=#ff0000
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let ring = matchadd('WhiteOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" Turn off highlighting in insert mode, and turn back on again when leaving
augroup highlight_search
  autocmd!
  autocmd InsertEnter * :setlocal nohlsearch
  autocmd InsertLeave * :setlocal hlsearch
augroup END


" Use todo#Complete as the omni complete function for todo files
au filetype todo setlocal omnifunc=todo#Complete
" Auto complete projects
au filetype todo imap <buffer> + +<C-X><C-O>
" Auto complete contexts
au filetype todo imap <buffer> @ @<C-X><C-O>
au filetype todo setlocal completeopt-=preview


" abbreviations / spelling corrections
abbr conosle console
abbr comopnent component
iabbr adn and
iabbrev waht what
iabbrev tehn then
:iabbrev @@ brijgogogo1@gmail.com
:iabbrev ccopy Copyright 2019 Brij Sharma, all rights reserved.
:iabbrev ssig <cr>Thanks<cr>Brij

" set iskeyword?
" help isfname
" <nop: no operation: eg. :inoremap <esc> <nop>


au BufNewFile,BufRead *.handlebars set filetype=html


function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'
" %f: file name
" %F: full file name
" %y: file type
" %l : current line number
" %L : total line numbers
" %= : everything coming afterwards should be aligned to the right
" $m : modified flag
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
" set statusline+=%{toupper(g:currentmode[mode()])}
set statusline+=%#Visual#       " colour
set statusline+=%m
set statusline+=\ %f
set statusline+=\ %r
set statusline+=%#CursorLine#     " colour
set statusline+=\ %y
set statusline+=%{StatuslineGit()}
" set statusline+=%{GitStatus()} " show added, modified, removed line count
set statusline+=%=
set statusline+=%q
" set statusline+=%#CursorIM#     " colour
" set statusline+=%#Cursor#               " colour
set statusline+=[%l,%c/%L]
set statusline+=%{ObsessionStatus()} " adds vim-obsession indicator if in session



" show hidden characters
set listchars=tab:→\ ,eol:¬,trail:.

" remove all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e


function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap <Leader>j :call GotoJump()<CR>


" highlight todo/fixme
"https://vi.stackexchange.com/questions/15505/highlight-whole-todo-comment-line
syntax keyword myTodo TODO FIXME nextgroup=myRestOfTodo
syntax match myRestOfTodo /.*/ containedin=NONE contained
highlight link myTodo Todo
highlight link myRestOfTodo Todo
" TODO: hello

" vim-startify
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let my_vim_dir = "~/.config/nvim"

let my_vim_session_dir = my_vim_dir . '/session/'
let g:startify_session_dir = my_vim_session_dir
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1

let g:startify_lists = [
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]


" vim sessions
execute "nnoremap \<leader>ms :mksession! " . my_vim_session_dir
execute "nnoremap \<leader>os :source " . my_vim_session_dir
execute "nnoremap \<leader>xs :!rm " . my_vim_session_dir


" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
" make list-like commands more intuitive
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()


" reload when entering the buffer or gaining focus
au FocusGained,BufEnter * :silent! checktime
" save when exiting the buffer or losing focus
" au FocusLost,WinLeave * :silent! w
au FocusLost,WinLeave * :silent! update

set foldcolumn=2


" Enable Emmet in js files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}


" edit as per current file location
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

" movement between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" window resize
"nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
"nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

nnoremap <leader>u :UndotreeShow<CR>


autocmd FileType yaml set tabstop=2 shiftwidth=2

" gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" insert timestamp
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %P")<CR><Esc>
imap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %P")<CR>

" netrw
" Vim-vinegar key - clashes with vimwiki
" nmap <Nop> <Plug>VimwikiRemoveHeaderLevel
nmap <leader>- <Plug>VimwikiRemoveHeaderLevel
" start with dot files hidden
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

""""""""""""""""""""""""
"""" vim-go """"""""""""
""""""""""""""""""""""""
let g:go_list_type = "quickfix" " use quickfox always
autocmd FileType go nmap <leader>r <Plug>(go-run)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" autocmd FileType go nmap <leader>b <Plug>(go-build)
" autocmd FileType go nmap <leader>t <Plug>(go-test)

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_generate_tags = 1
" :help go-settings

" by default Vim shows 8 spaces for a single tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2


" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
" let g:go_def_mapping_enabled = 0

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100
" let g:go_auto_sameids = 1

""""""""""""""""""""""""
""""" UltiSnip """""""""
""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


