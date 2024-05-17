#!/usr/bin/bash


cp bashrc ~/.bashrc
cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf 
cp -rT config ~/.config

if [[ ! -d "~/.proxychains" ]]; then
    mkdir -p ~/.proxychains
fi
cp proxychains.conf ~/.proxychains/
cp -r mutt ~/.mutt
