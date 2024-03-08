:warning: This repository contains my legacy dotfiles, I now have [a new dotfiles repository](https://github.com/sambonbonne/dotfiles) :warning:

Configured softwares
====================

Console
-------

* [Zsh](http://www.zsh.org/) (and any other shell via `~/.profile`)
* [Tmux](https://tmux.github.io/)
* [Neovim](https://neovim.io/) (or simply [Vim](https://www.vim.org/))
* [Git](https://git-scm.com/)
* [npm](https://www.npmjs.com/)
* [The Fuck](https://github.com/nvbn/thefuck)
* [Vifm](https://vifm.info/)

X
---

* [spectrwm](https://github.com/conformal/spectrwm)
* [Rofi](https://github.com/davatorium/rofi)
* [polybar](https://github.com/jaagr/polybar)
* [feh](https://feh.finalrewind.org/) (for background)
* [dunst](https://dunst-project.org/)
* [compton](https://github.com/chjj/compton)
* [i3lock](https://i3wm.org/i3lock/) (really, I don't know any better screen locker)
* [xss-lock](https://bitbucket.org/raymonad/xss-lock)
* [redshift](http://jonls.dk/redshift/)
* [Termite](https://github.com/thestinger/termite)

Install
=======

You just have to clone the repo and change a line in `install/main.sh` (I should fix that): the `_dotfiles_dir` variable should be the path to the Git repo on your computer.
Then, just launch `install/main.sh`.

The install script mainly create symlinks where the dest file is not a already a symlink.
If the destination file already exists, it is saved with the `.bak` extension before replacing with the symlink.

3 others steps are executed: installing [Dein.vim](https://github.com/Shougo/dein.vim) (as a (Neo)Vim's plugin manager), [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager) and [Zplug](https://github.com/zplug/zplug) (for ZSH plugins).

### Update

You can just `git pull`, usually you'll need to restart some processes or reboot to apply modifications.

Customisation
=============

You can customize your files as usual or in the repo as these are symlinks.
If you want to save your own modifications, you should fork my repo and change your local repo's URL.
