#!/usr/bin/bash
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
ln -sf ~/dotfiles/dein/dein.toml ~/.vim/dein/dein.toml
ln -sf ~/dotfiles/dein/dein_lazy.toml ~/.vim/dein/dein_lazy.toml
