#!/usr/bin/bash
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
dein_dir=~/.vim/dein/repos/github.com/Shougo/dein.vim
if [ ! -d $dein_dir ]; then
	git clone https://github.com/Shougo/dein.vim $dein_dir
fi

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/dein/dein.toml ~/.vim/dein/dein.toml
ln -sf ~/dotfiles/dein/dein_lazy.toml ~/.vim/dein/dein_lazy.toml

# create directorys
createDirectorys=(
	~/.vim/swapfiles
	~/.vim/undofiles
)
for path in ${createDirectorys[@]}; do
	mkdir -p $path
done
