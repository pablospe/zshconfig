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

Modify `ZSH_PWD` variable inside `zshrc` file (with the directory where the repository was cloned),  and create a symbolic link to ~/.zshrc
