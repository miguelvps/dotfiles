# Check for an interactive session
[ -z "$PS1" ] && return

PS1='[\u@\h \W]\$ '

shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell
shopt -s globstar
shopt -s nocaseglob
shopt -s histappend

alias ls='ls --color=auto --literal --human-readable --show-control-chars --group-directories-first'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias o='xdg-open'

# Serve the current directory in port $1
function http() { python2 -m SimpleHTTPServer "$@" ; }

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \; ; }

# Find a file with pattern $1 that contains text $2:
function ft()
{ find . -type f -iname '*'${1:-}'*' -exec grep -il "$2" {} \; ; }

# Show process $1 stderr if available (must be a 'catable' file)
function stderr() { tail -f /proc/$(pidof $1)/fd/2 ; }
complete -F _pgrep stderr


function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Redirect a process fd to target file
function redirect() {
    local O_CREAT=00100
    local O_WRONLY=01
    local O_APPEND=02000
    local flags="$O_CREAT|$O_WRONLY|$O_APPEND"
    local mode=00664

    local tmpfile=`mktemp`
    echo "p dup2(open("\"$3\"", $flags, $mode), $2)" > $tmpfile

    gdb -batch -x $tmpfile -p $(pidof $1)
}
_redirect()
{
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    if [[ $COMP_CWORD -eq 1 ]] ; then
        _pgrep
        return 0
    fi
    if [[ $COMP_CWORD -eq 2 ]] ; then
        COMPREPLY=( $( compgen -W "1 2 3" -- $cur ) )
        return 0
    fi
    if [[ $COMP_CWORD -eq 3 ]] ; then
        _filedir
        return 0
    fi
}
complete -F _redirect redirect
