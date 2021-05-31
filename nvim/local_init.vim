set guicursor=i:ver25-iCursor

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

""""""""""""""""""""""""""""""
" VIM-PANDOC
""""""""""""""""""""""""""""""
let g:pandoc#filetypes#handled = ['pandoc', 'markdown']
let g:pandoc#filetypes#pandoc_markdown = 0
"let g:pandoc#modules#disabled = ['folding', 'spell']
let g:pandoc#biblio#bibs = ['/home/bruce/org/bib/academic.bib']

""""""""""""""""""""""""""""""
" VIM-PANDOC-SYNTAX
""""""""""""""""""""""""""""""
let g:pandoc#syntax#conceal#blacklist = ['strikeout', 'list', 'quotes']

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

""""""""""""""""""""""""""""""
" One line per sentence
""""""""""""""""""""""""""""""
" https://vi.stackexchange.com/a/28620

function! OneSentencePerLine()
  if mode() =~# '^[iR]'
    return
  endif
  let start = v:lnum
  let end = start + v:count - 1
  execute start.','.end.'join'
  s/[.!?]\zs\s*\ze\S/\r/g
endfunction

set formatexpr=OneSentencePerLine()
