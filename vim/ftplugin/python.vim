" https://habamax.github.io/2020/02/03/vim-folding-for-python.html
func! FoldIndent() abort
    let indent = indent(v:lnum)/&sw
    let indent_next = indent(nextnonblank(v:lnum+1))/&sw
    if indent_next > indent && getline(v:lnum) !~ '^\s*$'
        return ">" . (indent+1)
    elseif indent != 0
        return indent
    else 
        return -1
    endif
endfunc
setlocal foldexpr=FoldIndent()
setlocal foldmethod=expr
