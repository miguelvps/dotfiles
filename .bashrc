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
function http() { python3 -m http.server "$@" ; }

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

# Stopwatch and countdown, $1 in seconds
function stopwatch()
{
    if [ -z "$1" ] ; then
        d=`date +%s` ;
        while true ; do
            echo -ne "$(date -u --date @$((`date +%s` - $d)) +%H:%M:%S)\r" ;
        done
    else
        d=$((`date +%s` + $1)) ;
        while [ "$d" -ne `date +%s` ] ; do
            echo -ne "$(date -u --date @$(($d - `date +%s` )) +%H:%M:%S)\r" ;
        done
    fi
}

# Extract provided archive
function extract {
 if [ -z "$1" ]; then
    echo "Usage: extract FILENAME"
    echo "       extract FILENAME..."
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)
                         unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"     ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \ extract $n.iso && \rm -f $n ;;
            *)
                         echo "extract: '$n': Unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "extract: '$n': No such file"
          return 1
      fi
    done
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


function gowork() {
    GOPATH=$PWD
    export GOPATH

    PATH=$PATH:$GOPATH/bin
    export PATH
}
