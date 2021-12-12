" Vim compiler file
" Compiler: Asciidoctor 2 markdown using docbook intermediate format and pandoc
" Maintainer: DandiWong (DandiToCoach@gmail.com)
" vim: et sw=4

if exists("current_compiler")
    finish
endif
let current_compiler = "Asciidoctor2MARKDOWN"
let s:keepcpo= &cpo
set cpo&vim

if get(g:, 'asciidoctor_extensions', []) == []
    let s:extensions = ""
else
    let s:extensions = "-r ".join(g:asciidoctor_extensions, ' -r ')
endif

let s:asciidoctor_executable = get(g:, 'asciidoctor_executable', 'asciidoctor')

let s:asciidoctor_pandoc_executable = get(g:, 'asciidoctor_pandoc_executable', 'pandoc')

let s:make_docbook = s:asciidoctor_executable . " " . s:extensions
            \. " -a docdate=" . strftime("%Y-%m-%d")
            \. " -a doctime=" . strftime("%T")
            \. " -b docbook"
            \. " " . shellescape(expand("%:p"))

let s:make_markdown = s:asciidoctor_pandoc_executable
            \. " -f docbook -t markdown_strict"
            \. " -o " . shellescape(expand("%:p:r") . ".md")
            \. " " . shellescape(expand("%:p:r") . ".xml")

let s:cd = "cd ".shellescape(expand("%:p:h"))
let &l:makeprg = s:make_docbook . " && " . s:cd ." && ". s:make_markdown

let &cpo = s:keepcpo
unlet s:keepcpo
