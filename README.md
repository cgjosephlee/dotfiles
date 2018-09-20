# Config files
Some of my config files (vim, tmux, etc.), config file should be renamed as `.filename` and put in home dirctory.

## TOC
<!-- MarkdownTOC -->

- [iTerm2](#iterm2)
    - [Color preset](#color-preset)
    - [Font](#font)
- [Sublime Text 3](#sublime-text-3)
    - [Package control](#package-control)
    - [Theme - Boxy](#theme---boxy)
    - [Color scheme](#color-scheme)
    - [Other plugins](#other-plugins)
- [Zsh](#zsh)
    - [Setup zsh](#setup-zsh)
    - [Oh my zsh](#oh-my-zsh)
    - [powerlevel9k](#powerlevel9k)
    - [dracula](#dracula)
    - [Fast-syntax-highlighting](#fast-syntax-highlighting)
    - [biozsh](#biozsh)
- [Vim](#vim)
    - [Vundle](#vundle)
    - [vim-sublime-monokai](#vim-sublime-monokai)
    - [YouCompleteMe](#youcompleteme)
    - [Other plugins](#other-plugins-1)
- [Tmux](#tmux)
    - [Tmux Plugin Manager \(tpm\)](#tmux-plugin-manager-tpm)
    - [Other plugins](#other-plugins-2)
- [Misc](#misc)
    - [Bash PS1 config](#bash-ps1-config)

<!-- /MarkdownTOC -->

## iTerm2
### Color preset
Builtin Pastel Dark

![](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/screenshots/builtin_pastel_dark.png)

[More presets](https://github.com/mbadolato/iTerm2-Color-Schemes)

### Font
Rrgular: 12pt Monaco

Powerline: 12pt Sauce Code Pro Nerd Font Complete
```
brew cash install font-sourcecodepro-nerd-font
```

## Sublime Text 3
### [Package control](https://packagecontrol.io)
[Installation guide](https://packagecontrol.io/installation)

### Theme - [Boxy](https://packagecontrol.io/packages/Boxy%20Theme)
Boxy Monokai
```
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
- Anaconda
- Markdown Preview
- MarkdownTOC ([usage](https://github.com/naokazuterada/MarkdownTOC#usage))
- Side Bar

## Zsh
### Setup zsh
```
chsh -s /bin/zsh
```

### [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
```
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```

### [powerlevel9k](https://github.com/bhilburn/powerlevel9k)
```
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

### [dracula](https://draculatheme.com/zsh/)
```
wget -P ~/.oh-my-zsh/custom/themes https://github.com/dracula/zsh/raw/master/dracula.zsh-theme
```

### [Fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)
An alternative of [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
```
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
# add to .zshrc plugin list and restart zsh
fast-theme safari
```

### [biozsh](https://github.com/kloetzl/biozsh)
Zsh autocompletes for plenty bioinfomatic tools.
```
git clone https://github.com/kloetzl/biozsh.git ~/.oh-my-zsh/custom/plugins/biozsh
ln -s ~/.oh-my-zsh/custom/plugins/biozsh/biozsh.zsh ~/.oh-my-zsh/custom/plugins/biozsh/biozsh.plugin.zsh
```

## Vim
### [Vundle](https://github.com/VundleVim/Vundle.vim)
Installation
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
and configure `.vimrc` (see readme of vundle).

Run `:PluginInstall` in vim or `vim +PluginInstall +qall` in command line.

### [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai)
Add to `.vimrc`:
```
syntax on
colorscheme sublimemonokai
```

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
May need to compile manually.
```
cd .vim/bundle/YouCompleteMe/ && ./install.py
```

### Other plugins
- vim-scripts/indentpython.vim
- vim-syntastic/syntastic
- nvie/vim-flake8

## Tmux
### [Tmux Plugin Manager (tpm)](https://github.com/tmux-plugins/tpm)
Installation
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and configure `.tmux.conf` (see readme of tpm).

Install plugins in tmux:
- `prefix` + <kbd>I</kbd>: installs new plugins from GitHub or any other git repository on the plugin list
- `prefix` + <kbd>U</kbd>: updates plugin(s)
- `prefix` + <kbd>alt</kbd> + <kbd>u</kbd>: remove/uninstall plugins not on the plugin list ([workaround for macOS](https://github.com/tmux-plugins/tpm/issues/72#issuecomment-259750983))

or via command line ([ref](https://github.com/tmux-plugins/tpm/blob/master/docs/managing_plugins_via_cmd_line.md)):
```
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
### Bash PS1 config
```
export PS1='\[\e[1;33m\]$PWD/ \[\e[0m\]\n\u@\h@\t $ '
```
behaves like
```
/to/your/path
User@Host@Time $
```

