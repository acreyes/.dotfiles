#!/usr/bin/env zsh

if [ -z "$1" ]
then
    STOW_CMD=stow
else
    STOW_CMD=$1
fi

echo $STOW_CMD

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="nvim,ohmyszh,tmux,zsh"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

pushd $DOTFILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "stow $folder"
    $STOW_CMD -D $folder
    $STOW_CMD $folder
done
popd
