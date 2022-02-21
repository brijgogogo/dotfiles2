" git clone minpac in .vim/pack/minpack/opt/
packadd minpac

call minpac#init()
call minpac#add('k-takata/minpac',{'type':'opt'}) " package manager
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-scriptease', {'type':'opt'})

" fuzzy finder (files/text)
call minpac#add('junegunn/fzf.vim')

" call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
" call minpac#add('leafgarland/typescript-vim')

" call minpac#add('iamcco/markdown-preview.nvim', {'do': 'call mkdp#util#install()'})
" call minpac#add('godlygeek/tabular')
call minpac#add('plasticboy/vim-markdown')
" call minpac#add('junegunn/limelight.vim')
" call minpac#add('junegunn/goyo.vim')
call minpac#add('fcpg/vim-waikiki')

" call minpac#add('dbeniamine/todo.txt-vim')

call minpac#add('moll/vim-node')
call minpac#add('lambdalisue/suda.vim') " sudo read/write


" File explorers
" call minpac#add('tpope/vim-vinegar') " netrw extensions
call minpac#add('mcchrish/nnn.vim')

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
call minpac#add('EdenEast/nightfox.nvim')


call minpac#add('ryanoasis/vim-devicons')

" git
call minpac#add('tpope/vim-fugitive') " git commands from vim
call minpac#add('airblade/vim-gitgutter') " show git diff markers
call minpac#add('rhysd/git-messenger.vim') " see history of line
" call minpac#add('junegunn/gv.vim') " see history of line
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

" call minpac#add('diepm/vim-rest-console')
" call minpac#add('aquach/vim-http-client')
call minpac#add('sgur/vim-editorconfig') " vim script based editor-config support
" call minpac#add('neovim/nvim-lspconfig') " temp: neovim lsp client
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('SirVer/ultisnips')

" programming: golang
call minpac#add('fatih/vim-go', { 'do' : 'GoInstallBinaries' })
" https://github.com/fatih/vim-go/wiki/Tutorial

" programming: autocompletion & linting
call minpac#add('neoclide/coc.nvim', { 'branch' : 'release' })
" :CocInstall coc-go coc-html coc-css coc-json

"i3 config syntax highlight
call minpac#add('mboughaba/i3config.vim')

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()


