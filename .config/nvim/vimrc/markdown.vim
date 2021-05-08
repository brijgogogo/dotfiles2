" markdown settings

"" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_edit_url_in = 'tab'

" hide links in markdown
" set conceallevel=2
autocmd FileType markdown setlocal conceallevel=2

let g:waikiki_wiki_roots = ['/media/d1/docs/wiki']
let g:waikiki_wiki_patterns = ['/wiki/']
let g:waikiki_default_maps  = 1

" wiki shortcuts
autocmd FileType markdown nmap  <Tab>  <Plug>(waikikiNextLink)
autocmd FileType markdown nmap  <S-Tab>  <Plug>(waikikiPrevLink)
autocmd FileType markdown nmap  <cr>  <Plug>(waikikiFollowLink)

