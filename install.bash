#!/bin/bash

echo "Hi! What a good day to prepare a computer for more productivity. Let's go!"

# Clone dotfiles
read -p "Do you need to clone dotfiles in ~/dev/dotfiles ? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  type git >/dev/null 2>&1 || { echo "Git doesn't exists, but what is this shitty computer ?!"; exit 1; }
  mkdir -p ~/dev
  git clone https://github.com/smumu/dotfiles ~/dev/dotfiles
fi

# Put ZSH config
echo "ZSH"
ln -s ~/dev/dotfiles/dircolors ~/.dircolors
ln -s ~/dev/dotfiles/profile ~/.profile
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
ln -s ~/dev/dotfiles/zsh ~/.zsh
type zsh >/dev/null 2>&1 && chsh -s /bin/zsh || echo "ZSH is configured but not installed, that's problematic ..."

# And Vim config
echo "Vim"
ln -s ~/dev/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.vim/plugged
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
type vim >/dev/null 2>&1 && vim +PlugInstall +qall || echo "Vim is configured but not installed, will you survive ?"

# And NeoVim, hope you have it here
echo "Neovim"
mkdir -p ~/.config/nvim
ln -s ~/dev/dotfiles/config/config/init.vim ~/.config/nvim/init.vim
curl -fLo ~/.config/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
type neovim >/dev/null 2>&1 && vim +PlugInstall +qall || echo "Neovim is configured but not installed, that's not a surprise"

# Don't forget Tmux
echo "Tmux"
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf

# Git is always usefull
echo "Git"
ln -s ~/dev/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/gitignore_global ~/.gitignore_global

# NPM, haters gonna hate
echo "NPM"
ln -s ~/dev/dotfiles/npmrc ~/.npmrc

echo "My work here is done, have a nice day!"
