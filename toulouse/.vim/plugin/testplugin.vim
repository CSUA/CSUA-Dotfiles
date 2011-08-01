if !has("python")
    finish
endif

" :command -range -nargs=* cmdname :call funcname(<line1>,<line2>,<args>)
:command! Testcmd :call Testfunc()
function! Testfunc()
python << EOF
import vim

f = open("blah.txt",'w')
#print >>f,dir(vim.windows[0].buffer[0])
#help(vim.windows[0].buffer[0])
for line in vim.windows[0].buffer:
    print line
vim.windows[0].buffer.append("fgsfds")
f.close()

EOF
endfunction
