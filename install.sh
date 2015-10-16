#!/bin/bash

echo "Hi! What a good day to prepare a computer for more productivity. Let's go!"

# Clone dotfiles
read -p "Do you need to clone dotfiles in ~/dev/dotfiles ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  type git >/dev/null 2>&1 || { echo "Git doesn't exists, but what is this shitty computer ?!"; exit 1; }
  mkdir -p ~/dev
  git clone https://github.com/smumu/dotfiles ~/dev/dotfiles
fi

# Put ZSH config
echo "ZSH"
ln -s ~/dev/dotfiles/profile ~/.profile
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
ln -s ~/dev/dotfiles/zsh ~/.zsh
type zsh >/dev/null 2>&1 && chsh -s /bin/zsh || echo "ZSH is configured but not installed, that's problematic ..."

# And Vim config
echo "Vim"
ln -s ~/dev/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
type vim >/dev/null 2>&1 && vim +PluginInstall +qall || echo "Vim is configured but not installed, will you survive ?"

# Don't forget Tmux
echo "Tmux"
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf

# Git is always usefull
ln -s ~/dev/dotfiles/gitconfig ~/.gitconfig

echo "My work here is done, have a nice day!"
