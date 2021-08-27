# Config files <!-- omit in toc -->
Some of my config files (vim, tmux, etc.). Config file should be renamed as `.filename` and put in home directory.

## TOC <!-- omit in toc -->
<!-- created by vscode Markdown All in One -->
- [Manage with yadm](#manage-with-yadm)
  - [Installation](#installation)
  - [Usage](#usage)
- [iTerm2](#iterm2)
  - [Color preset](#color-preset)
  - [Font](#font)
  - [Other emulators](#other-emulators)
- [Sublime Text 3](#sublime-text-3)
  - [Package control](#package-control)
  - [Theme](#theme)
  - [Color scheme](#color-scheme)
  - [Other plugins](#other-plugins)
- [Bash](#bash)
  - [Bash-it](#bash-it)
  - [Oh my bash](#oh-my-bash)
  - [Theme](#theme-1)
  - [PS1 config](#ps1-config)
- [Zsh](#zsh)
  - [Setup zsh](#setup-zsh)
  - [zinit](#zinit)
  - [Plugins](#plugins)
    - [powerlevel10k](#powerlevel10k)
    - [Fast-syntax-highlighting](#fast-syntax-highlighting)
    - [biozsh](#biozsh)
- [NeoVim](#neovim)
  - [Installation](#installation-1)
  - [vim-plug](#vim-plug)
  - [Nerd commenter](#nerd-commenter)
  - [LSP](#lsp)
    - [Install nodejs](#install-nodejs)
    - [Install language server](#install-language-server)
  - [Other plugins](#other-plugins-1)
- [Tmux](#tmux)
  - [Installation](#installation-2)
    - [Source](#source)
    - [Appimage](#appimage)
  - [Tmux Plugin Manager (tpm)](#tmux-plugin-manager-tpm)
  - [Other plugins](#other-plugins-2)
- [Misc](#misc)
  - [Manage dotfiles](#manage-dotfiles)
  - [Nvim config references](#nvim-config-references)


## Manage with yadm
### Installation
Linux
```
curl -fLo yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x yadm
```
MacOS
```
brew install yadm
```

### Usage
yadm inherits all of Git’s features.
```sh
yadm clone https://github.com/cgjosephlee/Config_files
```

## iTerm2
### Color preset
Nord, background = '#212327'.

### Font
13pt MesloLGS Nerd Font (patched Menlo, LGS: line gap small)
```
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
```

### Other emulators
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [alacritty](https://github.com/jwilm/alacritty)
- [hyper](https://hyper.is)

## Sublime Text 3
### [Package control](https://packagecontrol.io)
[Installation guide](https://packagecontrol.io/installation)

### Theme
[Boxy](https://packagecontrol.io/packages/Boxy%20Theme): Monokai
```json
{
    "theme": "Boxy Monokai.sublime-theme",
    "theme_button_rounded": true,
    "theme_find_panel_size_xxs": true,
    "theme_sidebar_size_xs": true,
}
```

### Color scheme
Default Monokai

### Other plugins
- AlignTab
- Markdown Preview
- MarkdownTOC ([usage](https://github.com/naokazuterada/MarkdownTOC#usage))
- Side​Bar​Enhancements

## Bash
### [Bash-it](https://github.com/Bash-it/bash-it)
Installation
```sh
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh
```
Uninstallation
```sh
cd $BASH_IT && ./uninstall.sh
cd $HOME && rm -rf $BASH_IT
```

### [Oh my bash](https://github.com/ohmybash/oh-my-bash)
A delightful community-driven framework.

### Theme
- [Median](https://gist.github.com/cgjosephlee/69bfd32a39dad7c5a6fab10c0551806f)

### PS1 config
```bash
export PS1='\[\e[1;33m\]$PWD/ \[\e[0m\]\n\u@\h@\t $ '
```
behaves like
```
/to/your/path
User@Host@Time $
```

## Zsh
### Setup zsh
```sh
chsh -s /bin/zsh
```
Without root
```sh
# install from source
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
tar Jxf zsh.tar.xz
cd zsh-<version>
./configure --prefix=$HOME/.local
make && make install
# activate zsh in , e.g. .bashrc
exec zsh
```

### [zinit](https://github.com/zdharma/zinit)
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```
### Plugins
#### [powerlevel10k](https://github.com/romkatv/powerlevel10k)
A fast drop-in replacement for Powerlevel9k.
For color customization, all supported colors are ([ref](https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#segment-color-customization)):
```sh
# 256 colors
for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"

# true color
awk 'BEGIN{
  s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
  for (colnum = 0; colnum<77; colnum++) {
    r = 255-(colnum*255/76);
    g = (colnum*510/76);
    b = (colnum*255/76);
    if (g>255) g = 510-g;
    printf "\033[48;2;%d;%d;%dm", r,g,b;
    printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
    printf "%s\033[0m", substr(s,colnum+1,1);
  }
  printf "\n";
}'
```

#### [Fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)
An alternative of [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
```sh
fast-theme safari
```

#### [biozsh](https://github.com/kloetzl/biozsh)
Zsh autocompletes for plenty bioinfomatic tools.

## [NeoVim](https://neovim.io)
### Installation
Just download and enjoy!
```sh
# for linux
curl -fLo nvim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim
```
Python support:
```sh
pip install --user --upgrade neovim
```
### [vim-plug](https://github.com/junegunn/vim-plug)
Install
```sh
# for nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Install plugins
```
:PlugInstall
```

### [Nerd commenter](https://github.com/scrooloose/nerdcommenter)
`<leader>` is mapped to `\`.

Add a space after comment sign:
```vim
let g:NERDSpaceDelims=1
```
Space may be duplicated in some language (e.g. python), to workaround:
```vim
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
```

### LSP
https://github.com/neovim/nvim-lspconfig
https://github.com/kabouzeid/nvim-lspinstall
https://github.com/hrsh7th/nvim-compe

#### Install nodejs
https://nodejs.org/en/download/
```sh
VERSION=v14.17.3
DISTRO=linux-x64
PREFIX=$HOME/local
wget https://nodejs.org/dist/$VERSION/node-$VERSION-$DISTRO.tar.xz
tar -xJf node-$VERSION-$DISTRO.tar.xz -C $PREFIX
ln -s $PREFIX/node-$VERSION-$DISTRO/bin/* $PREFIX/bin
```

#### Install language server
```
:LspInstall <language>
```

### Other plugins
- [vim-easy-align](https://github.com/junegunn/vim-easy-align)
- [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
- [nerdtree](https://github.com/preservim/nerdtree)

## Tmux
### Installation
#### Source
https://github.com/tmux/tmux
1. Install [libevent](https://github.com/libevent/libevent)
2. Install tmux
```sh
./configure CFLAGS="-I$HOME/.local/include" LDFLAGS="-L$HOME/.local/lib" --prefix=$HOME/.local
make && make install
```

#### Appimage
https://github.com/nelsonenzo/tmux-appimage/releases
```
curl -fLo tmux https://github.com/nelsonenzo/tmux-appimage/releases/download/tmux3.1b/tmux-3.1b-x86_64.AppImage
chmod +x tmux
```

### [Tmux Plugin Manager (tpm)](https://github.com/tmux-plugins/tpm)
Install
```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and configure `.tmux.conf` (see readme of tpm).

Install plugins in tmux:
- `prefix` + <kbd>I</kbd> : installs new plugins from GitHub or any other git repository on the plugin list
- `prefix` + <kbd>U</kbd> : updates plugin(s)
- `prefix` + <kbd>alt</kbd> + <kbd>u</kbd> : remove/uninstall plugins not on the plugin list ([workaround for macOS](https://github.com/tmux-plugins/tpm/issues/72#issuecomment-259750983))

or via command line ([ref](https://github.com/tmux-plugins/tpm/blob/master/docs/managing_plugins_via_cmd_line.md)):
```sh
# installing
~/.tmux/plugins/tpm/bin/install_plugins
# updating
~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/update_plugins tmux-sensible
# removing
~/.tmux/plugins/tpm/bin/clean_plugins
```

### Other plugins
- [tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight)

## Misc
### Manage dotfiles
- [Using GNU Stow to manage dotfiles](https://farseerfc.me/using-gnu-stow-to-manage-your-dotfiles.html)
- https://github.com/TheLocehiliosan/yadm
- https://github.com/thoughtbot/rcm
- https://github.com/andsens/homeshick

### Nvim config references
- https://github.com/ayamir/nvimdots
  https://zhuanlan.zhihu.com/p/382092667
- https://github.com/kabouzeid/dotfiles/tree/master/nvim
