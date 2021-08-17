set guicursor=i:ver25-iCursor

filetype plugin on
set omnifunc=syntaxcomplete#Complete

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

""""""""""""""""""""""""""""""
" GIT
""""""""""""""""""""""""""""""
" Force the cursor onto a new line after 80 characters
set textwidth=80
" However, in Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72
" Colour the 81st (or 73rd) column so that we don’t type over our limit
set colorcolumn=+1
" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51

""""""""""""""""""""""""""""""
" VIM-PANDOC
""""""""""""""""""""""""""""""
let g:pandoc#filetypes#handled = ['pandoc', 'markdown']
let g:pandoc#filetypes#pandoc_markdown = 0
"let g:pandoc#modules#disabled = ['folding', 'spell']
let g:pandoc#modules#enabled = ['bibliography', 'formatting', 'folding']
let g:pandoc#biblio#sources = ['/home/bruce/org/bib/academic.bib']

""""""""""""""""""""""""""""""
" VIM-PANDOC-SYNTAX
""""""""""""""""""""""""""""""
let g:pandoc#syntax#conceal#blacklist = ['strikeout', 'list', 'quotes']

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

au FileType pandoc ++once call s:load(['vim-pandoc-syntax', 'vim-pandoc'], { "ft": "pandoc" })

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
