setlocal tags+=$HOME/.vim/tags/python.ctags


" Add the virtualenv's site-packages to vim path
if !exists("g:VIRTUAL_ENV") && exists("$VIRTUAL_ENV")
    let g:VIRTUAL_ENV = 1
python << EOF
import os.path
import sys
import vim
env = os.environ['VIRTUAL_ENV']
activate_this = os.path.join(env, 'bin/activate_this.py')
execfile(activate_this, dict(__file__=activate_this))
EOF
endif


" Import python folders to local path for file searching in gf
" Note: Must execute after virtualenv import to add virtualenv packages
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"setlocal path+=%s" % (p.replace(" ", r"\ ")))
EOF
