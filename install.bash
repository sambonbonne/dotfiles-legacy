#!/bin/env bash

echo "Hi! What a good day to prepare a computer for more productivity. Let's go!"

# Clone dotfiles
read -p "Do you need to clone dotfiles in ~/dev/dotfiles ? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  command -v git >/dev/null 2>&1 || { echo "Git doesn't exists, but what is this shitty computer ?!"; return 1; }
  mkdir -p ~/dev
  git clone https://github.com/smumu/dotfiles ~/dev/dotfiles
fi

# how to link a file properly
linkConfig() {
  local orig="${HOME}/dev/dotfiles/${1}"
  local dest="${HOME}/${2:-.${1}}"

  [[ -L "${dest}" ]] && return 0 # file is a symbolic link, don't change it

  if [[ -f "${dest}" ]]; then
    echo "Moving ${dest} to ${dest}.bak"
    mv "${dest}" "${dest}.bak"
  fi

  ln -s "${orig}" "${dest}"

  return 0
}

# Basic XDG directories
echo "XDG directories"
mkdir -p ~/.config/
linkConfig "config/user-dirs.dirs"
echo "XDG directories are configured"

# Put ZSH config
echo "ZSH"
linkConfig "dircolors"
linkConfig "profile"
linkConfig "zshrc"
linkConfig "zsh"
command -v zsh >/dev/null 2>&1 && { chsh -s /bin/zsh; echo "ZSH is configured"; } || echo "ZSH is configured but not installed, that's problematic ..."

# And NeoVim, hope you have it here
echo "Neovim"
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/after
mkdir -p ~/.config/nvim/plugins
linkConfig "config/nvim/init.vim"
linkConfig "config/nvim/statusline.vim"
linkConfig "config/nvim/highlight.vim"
linkConfig "config/nvim/quickquit.vim"
linkConfig "config/nvim/completion.vim"
linkConfig "config/nvim/autoload"
linkConfig "config/nvim/ftplugin" ".config/nvim/after/ftplugin"
command -v neovim >/dev/null 2>&1 && echo "Neovim is configured, you should run plugins installation" || echo "Neovim is configured but not installed, that's not a surprise"

# And Vim config
echo "Vim"
mkdir -p ~/.vim
mkdir -p ~/.vim/after
mkdir -p ~/.vim/plugins
linkConfig "vimrc"
linkConfig "config/nvim/autoload" ".vim/autoload"
linkConfig "config/nvim/ftplugin" ".vim/after/ftplugin"
command -v vim >/dev/null 2>&1 && echo "Vim is configured, you should run plugins installation" || echo "Vim is configured but not installed, you'll have some problems"

echo "Git"
linkConfig "gitconfig"
linkConfig "gitignore_global"
echo "Git is configured"

# (Neo)Vim plugins
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein-installer.sh
sh ./dein-installer.sh "${HOME}/.config/nvim/plugins"

# NPM, haters gonna hate
echo "NPM"
linkConfig "npmrc"
echo "NPM is configured"

echo "My work here is done, have a nice day!"
