#!/usr/bin/env sh

ensure_directory .vim/after
ensure_directory .vim/plugins
link_config "vimrc"
link_config "config/nvim/autoload" ".vim/autoload"
link_config "config/nvim/ftplugin" ".vim/after/ftplugin"
check_command "vim"

ensure_directory .config/nvim/after
ensure_directory .config/nvim/plugins
link_config "config/nvim/init.vim"
link_config "config/nvim/statusline.vim"
link_config "config/nvim/highlight.vim"
link_config "config/nvim/quickquit.vim"
link_config "config/nvim/completion.vim"
link_config "config/nvim/autoload"
link_config "config/nvim/ftplugin" ".config/nvim/after/ftplugin"
check_command "neovim"

# plugins installation
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein-installer.sh
sh ./dein-installer.sh "${HOME}/.config/nvim/plugins" && rm ./dein-installer.sh
