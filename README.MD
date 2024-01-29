# NeoVim Config

## Package Manager
The package manager used is Lazy Loader

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

## Live grep
Live grep requires that the RipGrep binary is installed on the system
```sudo apt-get install ripgrep``` on Linux systems

