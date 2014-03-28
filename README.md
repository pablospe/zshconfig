zshconfig
=========

Personal zsh configuration.

#### Installation

Run the folowing commands:

    git clone git@github.com:pablospe/zshconfig.git zsh
    sh zsh/install.sh

#### The manual way

Set `ZSH_PWD` variable inside `local.sh` with the folder location (where the repository was cloned),  and create a symbolic link of this file to ~/.zshrc (`ln -s $ZSH_PWD/local.sh ~/.zshrc`). Copy `pablo.zsh-theme` in `oh-my-zsh/themes/`.

