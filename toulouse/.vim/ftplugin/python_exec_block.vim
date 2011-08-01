" Execute visually selected chunk of code (it executes so be careful, mainly
" to check for syntax errors in a chunk of code
" Usage: Ctrl+h
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-h> :py EvaluateCurrentRange()<cr>

