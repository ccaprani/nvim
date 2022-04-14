<<<<<<< HEAD
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

# Plugins
To enable the download and installation of vim plugins:

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Node
This is needed for coc and other plugins.
When installing, select to install all dependencies, including chocolatley.

#Python neovim
Once python installed, 'pip install neovim'


=======
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

# Plugins
To enable the download and installation of vim plugins:

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Node
This is needed for coc and other plugins.
When installing, select to install all dependencies, including chocolatley.

Install neovim for node:
'''
npm install -g neovim
'''

#Python neovim
Once python installed, 'pip install neovim'
For linting with coc 'pip install pylint'

# Code Completion
Must do ':CocInstall coc-python' to complete the code comp installation.

# Install SumatraPDF
This is for LaTeX viewing

    'C:\Program Files\SumatraPDF'

And add this path to the Environment 
>>>>>>> 7d6fd4215d6bd4841f64d9397218671f82712b45
