#!/bin/bash

files=("bash_profile" "bashrc" "gitconfig" "vimrc" "vim")
for str in ${files[@]}; do 
    echo "Comparing ~/.$str and $str..."
    diff ~/.$str $str
    read -p "Continue? " 
done
echo
