#!/usr/bin/bash
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

dein_dir=~/.vim/dein/repos/github.com/Shougo/dein.vim
if [ -d $dein_dir ]; then
	git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
fi

ln -sf ~/dotfiles/dein/dein.toml ~/.vim/dein/dein.toml
ln -sf ~/dotfiles/dein/dein_lazy.toml ~/.vim/dein/dein_lazy.toml
