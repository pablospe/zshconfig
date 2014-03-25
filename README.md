zshconfig
=========

Personal zsh configuration

#### Init and fetch data

You must run two commands:

    git submodule init     # to initialize your local configuration file,
    git submodule update   # to fetch all the data from the submodule

#### Installation

Run the folowing command:

    sh install.sh

#### The manual way

Set `ZSH_PWD` variable inside `local.sh` with the folder location (where the repository was cloned),  and create a symbolic link of this file to ~/.zshrc (`ln -s $ZSH_PWD/local.sh ~/.zshrc`).


