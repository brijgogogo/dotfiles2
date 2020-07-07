" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vim/vimrc

function!PrintRuntimePathValue()
	echo join(split(&runtimepath,','),"\n")
endfunction

command! PrintRTP call PrintRuntimePathValue()

set hidden " allows to have change not written in hidden buffers
set clipboard+=unnamedplus " use system clipboard
set number
set relativenumber

""""""""" https://github.com/neoclide/coc.nvim """""""""""""""""""
" Some servers have issues with backup files
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


" git clone minpac in .vim/pack/minpack/opt/
packadd minpac

call minpac#init()
call minpac#add('k-takata/minpac',{'type':'opt'})
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-scriptease', {'type':'opt'})
call minpac#add('tpope/vim-surround')
call minpac#add('junegunn/fzf.vim')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('vimwiki/vimwiki')
call minpac#add('dbeniamine/todo.txt-vim')
call minpac#add('ap/vim-css-color')
call minpac#add('mattn/vim-gist')

" call minpac#add('vifm/vifm.vim')
call minpac#add('mcchrish/nnn.vim')
call minpac#add('moll/vim-node')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-vinegar')

call minpac#add('mhinz/vim-startify')

" call minpac#add('preservim/nerdcommenter')
call minpac#add('tpope/vim-commentary')

" call minpac#add('dense-analysis/ale')
call minpac#add('neoclide/coc.nvim', { 'branch' : 'release' })
call minpac#add('fatih/vim-go')

" call minpac#add('diepm/vim-rest-console')
call minpac#add('aquach/vim-http-client')

" themes
call minpac#add('sonph/onehalf', {'subdir' : 'vim'})
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('dracula/vim')

call minpac#add('ryanoasis/vim-devicons')


" programming
call minpac#add('mattn/emmet-vim')

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()


" leader keys (prefix keys)
let mapleader=','
let maplocalleader = "\\" " second leader key, meant to be a prefix for mappings that only take effect for certain file types

nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ip :source $MYVIMRC<cr>:PackUpdate<cr>
nnoremap <leader>eb :tabedit ~/.bashrc<cr>
nnoremap <leader>et :tabedit ~/docs/cloud/dropbox_b1/Apps/Simpletask/todo.txt<cr>

" set background=dark
" set t_Co=256
colorscheme onehalfdark " nord onehalflight

" Indentation
set expandtab " pressing <TAB> inserts softtabstop amount of space characters
set shiftwidth=2 " tab to spaces on press of >>, << or ==
set softtabstop=2 " tab to spaces press of <TAB> or <BS>
" set autoindent " copies the indentation from the previous line, when starting a new line
" set smartindent " automatically inserts one extra level of indentation in some cases (like C-like files)
" https://vim.fandom.com/wiki/Indenting_source_code

set scrolloff=3
set sidescrolloff=5

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
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
" C-T : new tab
" C-X : new split
" C-V : new vertical split
" FZF - Tab to select multiple files, Alt-A to select all. Enter will populate
" the quickfix list (navigate using :cnext/prev of cn/cp)
map <C-j> :cn<cr>
map <C-k> :cp<cr>
map <C-f> :Rg<cr>
map <leader>Q :cclose<cr>
map <leader>q :copen<cr>

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
set smartcase
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
set statusline+=%=
set statusline+=%q
" set statusline+=%#CursorIM#     " colour
" set statusline+=%#Cursor#               " colour
set statusline+=[%l,%c/%L]



"""""""""""""""" COC """"""""""""""""""""""'
" https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
" command highlighting in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" fix for not visible documentation
hi link CocFloating markdown

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" coc-explorer
nnoremap <silent> <space>x  :<C-u>CocCommand explorer<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" see value of an option
" :echo &wrap

set linebreak " don't break words when wrapping text

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

" window resize
"nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
"nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

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
execute "nnoremap \<leader>ss :mksession! " . my_vim_session_dir
execute "nnoremap \<leader>os :source " . my_vim_session_dir
execute "nnoremap \<leader>rs :!rm " . my_vim_session_dir


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
