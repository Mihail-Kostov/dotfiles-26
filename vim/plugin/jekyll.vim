" jekyll.vim - Jekyll
" Maintainer:   Christopher Sexton

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
"if (exists("g:loaded_jekyll") && g:loaded_jekyll) || &cp
"    finish
"endif
"let g:loaded_jekyll = 1

let s:cpo_save = &cpo
set cpo&vim

" Code {{{1
if !exists('g:jekyll_path')
    let g:jekyll_path = $HOME . "/src/blog"
endif

function! JekyllList()
    exe "e " . g:jekyll_path . "/_posts"
endfunction
command! -nargs=? -range=% JekyllList :call JekyllList()

function! JekyllPost()
    let title = input("Post title: ")
    if title != ''
        let file_name = strftime("%Y-%m-%d-") . substitute(tolower(title), ' ', '-', 'g') . ".markdown"
        echo "Making that post " . file_name
        exe "e " . g:jekyll_path . "/_posts/" . file_name
        let failed = append(0, ["---", "layout: post", "title: " . title, "---", ""])
    else
        echo "You must specify a title"
    endif
endfunction
command! -nargs=? -range=% JekyllPost :call JekyllPost()
" }}}1

let &cpo = s:cpo_save

" vim:set ft=vim ts=8 sw=4 sts=4:
