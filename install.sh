#!/bin/bash

### get source
git clone https://github.com/vmaksymiv/dotfiles.git $HOME/dotfiles

### apply configuration
ln -s $HOME/dotfiles/.tmuxrc $HOME/.tmuxrc
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

### init vim
cd $HOME/dotfiles
git submodule update --init
ln -s $HOME/dotfiles/vimrc/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vimrc/.vim $HOME/.vim

### fetch vim plugins
cd $HOME/dotfiles/vimrc
git submodule update --init
