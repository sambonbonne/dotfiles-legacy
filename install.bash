#!/bin/env bash

echo "Hi! What a good day to prepare a computer for more productivity. Let's go!"

# Clone dotfiles
read -p "Do you need to clone dotfiles in ~/dev/dotfiles ? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  command git >/dev/null 2>&1 || { echo "Git doesn't exists, but what is this shitty computer ?!"; return 1; }
  mkdir -p ~/dev
  git clone https://github.com/smumu/dotfiles ~/dev/dotfiles
fi

# Put ZSH config
echo "ZSH"
ln -s ~/dev/dotfiles/dircolors ~/.dircolors
ln -s ~/dev/dotfiles/profile ~/.profile
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
ln -s ~/dev/dotfiles/zsh ~/.zsh
command zsh >/dev/null 2>&1 && { chsh -s /bin/zsh ; echo "ZSH is configured" } || echo "ZSH is configured but not installed, that's problematic ..."

# And Vim config
echo "Vim"
ln -s ~/dev/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.vim/plugged
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
command vim >/dev/null 2>&1 && echo "Vim is configured, you should run plugins installation" || echo "Vim is configured but not installed, will you survive ?"

# And NeoVim, hope you have it here
echo "Neovim"
mkdir -p ~/.config/nvim
ln -s ~/dev/dotfiles/config/config/init.vim ~/.config/nvim/init.vim
curl -fLo ~/.config/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
command neovim >/dev/null 2>&1 && echo "Neovim is configured, you should run plugins installation" || echo "Neovim is configured but not installed, that's not a surprise"

# Don't forget Tmux
echo "Tmux"
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf
command tmux >/dev/null 2>&1 && echo "Tmux is configured" || echo "Tmux is configured but not installed, you should address it immediately"

# Git is always usefull
echo "Git"
ln -s ~/dev/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/gitignore_global ~/.gitignore_global
echo "Git is configured"

# NPM, haters gonna hate
echo "NPM"
ln -s ~/dev/dotfiles/npmrc ~/.npmrc
echo "NPM is configured"

echo "My work here is done, have a nice day!"
