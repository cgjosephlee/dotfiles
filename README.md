# Config-files
Some of my config files (vim, tmux, etc.), config file should be renamed as `.filename` and put in home dirctory.

## Zsh
### [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
```
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh
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
An alternative of zsh-syntax-highlighting
```
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
# after add to .zshrc and restart zsh
fast-theme safari
```

## Vim
### [Vundle](https://github.com/VundleVim/Vundle.vim)
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
and in vim run
```
:PluginInstall
```

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
May need to compile manually
```
cd .vim/bundle/YouCompleteMe/ && ./install.py
```

## Tmux
### [Tmux Plugin Manager (tpm)](https://github.com/tmux-plugins/tpm)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and in tmux
- `prefix` + <kbd>I</kbd>: installs new plugins from GitHub or any other git repository on the plugin list
- `prefix` + <kbd>U</kbd>: updates plugin(s)
- `prefix` + <kbd>alt</kbd> + <kbd>u</kbd>: remove/uninstall plugins not on the plugin list

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

