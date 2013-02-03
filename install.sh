#!/bin/sh

cd $(dirname $0)

for name in $(ls -1A) ; do
  # TODO: find a better solution for this ignore list
  if [ "$name" = "install.sh" ] || [ "$name" = ".git" ] || [ "$name" = ".gitmodules" ] ; then
    continue;
  fi

  source="$PWD/$name"
  target="$HOME/$name"
  backup="$target.bak"

  if [ -e "$target" ] && [ ! -h "$target" ] ; then
    echo "* Backing up $target ..."
    mv --backup=numbered $target $backup
  fi

  ln -sf $source $target
  echo "$source -> $target"
done
