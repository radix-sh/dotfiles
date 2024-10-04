#!/bin/bash

files=("zshrc" "gitconfig" "vimrc")
for str in ${files[@]}; do 
    echo "Comparing ~/.$str and $str..."
    diff -r ~/.$str $str
    read -p "Continue? " 
done
echo
