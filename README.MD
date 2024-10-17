# NeoVim Config

## Install neovim
download the latest binary
untar the download
cp the nvim binary from the /bin folder to the location of the current binary
navigate to the /share/nvim folder in the untarred folder
cp the runtime folder to /usr/share/nvim with the command ```sudo cp -r runtime /usr/share/nvim/```

## Package Manager
The package manager used is Lazy Loader

[//]: # (TODO: update below icons section unless we are going to change the font to sourcecodepro fonts)
## Icons
Icons for nvim-tree need to be installed on each system individually and set for the terminal. The Fonts used are called Sauce Code Pro Nerd (Nerd Fonts)

Download the fonts
```wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/SourceCodePro.zip```

unzip to the install location, which is user specific

```shell
mkdir ~/.local/share/fonts
unzip SourceCodePro.zip -d ~/.local/share/fonts/
fc-cache ~/.local/share/fonts
```

to change the font in the terminal emulator you will just need to open gnome-terminal, go to "Preferences", and set the Nerd Font for your profile which will be listed as Sauce Code Mono

restart the terminal and if using guake terminal quit and restart that as well.

## Trunkio
Trunk io setup needs the trunk cli in the path

```curl -LO https://trunk.io/releases/trunk```

```chmod +x trunk```

```mv trunk /usr/bin/trunk```

# New Config notes

## List of lsp servers available to mason to install configure in mason.lua

https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

## Mason

Mason is used to automatically install lsp servers that we can then use lspconfig to setup those servers

## todo-comments 

todo comments is a way to search for todo items. add a todo with TODO: 
other tags can also be used such as BUG NOTE FIX and more by default. you can also add your own tags if you need custom ones, instructions at https://github.com/folke/todo-comments.nvim


