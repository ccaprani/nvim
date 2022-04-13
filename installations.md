#Introduction
This is a brief document of setting up my Neovim set up on a new device.

# Neovim
* Download from www.neovim.org
* Extract to `C:\Program Files\Neovim`

# Git
* Download *Git for Windows*
* Install and point to nvim.exe as the text editor

Here are some commands for converting an existing folder to a github repo

    cd <localdir>
    git init
    git add .
    git commit -m 'message'
    git remote add origin <url>
    git push -u origin master

Note, may need to do this outside nvim because of authentication.

# Check version

Issue command `:version`

# Updating neovim

First of all, you need to remove your current version. Make sure you don’t use the -purge parameter to the command:

    $ sudo apt remove neovim -y

Now do you can update normally with the commands:

    $ sudo add-apt-repository ppa:neovim-ppa/stable
    $ sudo apt-get update
    $ sudo apt-get install neovim

To check it:

    $ nvim

# Plugins

To enable the download and installation of vim plugins, install plug.vim. 
From: https://github.com/junegunn/vim-plug

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# xdotool
Needed for Zathura: sudo apt get

#Node
This is needed for coc and other plugins.
When installing, select to install all dependencies, including chocolatley.

sudo apt install nodejs

#Python neovim
Once python installed, 'pip install neovim'

# Code minimap
https://github.com/wfxr/code-minimap

sudo apt  install cargo
cargo install --locked code-minimap

