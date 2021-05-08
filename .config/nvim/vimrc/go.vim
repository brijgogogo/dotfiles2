"""" vim-go
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

" run all tests
autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)
" run current test function
autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)
" toggle coverage profile for the current file
autocmd BufEnter *.go nmap <leader>c  <Plug>(go-coverage-toggle)
" autocmd FileType go nmap <Leader>i <Plug>(go-info)
" show function signature for a given routine
autocmd BufEnter *.go nmap <leader>i  <Plug>(go-info)
" show interfaces a type implements
autocmd BufEnter *.go nmap <leader>ii  <Plug>(go-implements)
" describe the definition of a given type
autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)
" see the callers of a given function
autocmd BufEnter *.go nmap <leader>cc  <Plug>(go-callers)
" go to definition/Go back with Ctrl+d and Ctrl+a
nmap <C-a> <C-o>

" update all Go tools
" :GoUpdateBinaries
" update all coc plugins
" :CocUpdate

" run go imports on file save
let g:go_fmt_command = "goimports"

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" highlight all uses of identifier under cursor (:GoSameIds)
" let g:go_auto_sameids = 1
" let g:go_auto_sameids = 1
" show type info (:GoInfo) in status line
let g:go_auto_type_info = 1

let g:go_fmt_fail_silently = 1

" go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

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


