#!/bin/bash

### get source
if [ ! -d $HOME/dotfiles ]; then
    git clone https://github.com/vmaksymiv/dotfiles.git $HOME/dotfiles
else
    cd $HOME/dotfiles
    git pull
fi

### apply configuration
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

### init vim
cd $HOME/dotfiles
git submodule update --init
ln -s $HOME/dotfiles/vimrc/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vimrc/.vim $HOME/.vim

### fetch vim plugins
cd $HOME/dotfiles/vimrc
git submodule update --init

### use vim as default editor
if ! grep -Fxq "EDITOR=vim" $HOME/.bashrc; then
cat >> $HOME/.bashrc <<EOM
export VISUAL=vim
export EDITOR=vim

EOM
fi

### install pyenv
if [ ! -d $HOME/.pyenv ]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    cat >> $HOME/.bashrc <<EOM
PATH="~/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"

EOM
fi

tmux new-session -d -s py36 "pyenv install -s 3.6.8"
tmux new-session -d -s py37 "pyenv install -s 3.7.3"
