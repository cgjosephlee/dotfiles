# Config files
Some of my config files (vim, tmux, etc.), config file should be renamed as `.filename` and put in home dirctory.

## TOC
<!-- MarkdownTOC -->

- [iTerm2](#iterm2)
    - [Color preset](#color-preset)
    - [Font](#font)
- [Sublime Text 3](#sublime-text-3)
    - [Package control](#package-control)
    - [Theme](#theme)
    - [Color scheme](#color-scheme)
    - [SublimeREPL](#sublimerepl)
    - [Other plugins](#other-plugins)
- [Zsh](#zsh)
    - [Setup zsh](#setup-zsh)
    - [Oh my zsh](#oh-my-zsh)
    - [powerlevel9k](#powerlevel9k)
    - [dracula](#dracula)
    - [Fast-syntax-highlighting](#fast-syntax-highlighting)
    - [biozsh](#biozsh)
- [Vim](#vim)
    - [Useful shortcuts](#useful-shortcuts)
    - [Vundle](#vundle)
    - [vim-sublime-monokai](#vim-sublime-monokai)
    - [YouCompleteMe](#youcompleteme)
    - [Nerd commenter](#nerd-commenter)
    - [vim-slime](#vim-slime)
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

### [SublimeREPL](https://github.com/wuub/SublimeREPL)
Outdated package, patch is required for ipython.
- https://gist.github.com/MattDMo/6cb1dfbe8a124e1ca5af
- https://gist.github.com/pe224/ec5d7effa26e8f736fa2f6bb8f515606 (works with ipython 6)

Keybindings:
- Evaluate in REPL:
    - <kbd>ctrl</kbd> + <kbd>,</kbd>, <kbd>s</kbd> Selection
    - <kbd>ctrl</kbd> + <kbd>,</kbd>, <kbd>f</kbd> File
    - <kbd>ctrl</kbd> + <kbd>,</kbd>, <kbd>l</kbd> Lines
    - <kbd>ctrl</kbd> + <kbd>,</kbd>, <kbd>b</kbd> Block
- Transfer in REPL (just copy, without evaluating it):
    - <kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>,</kbd>, <kbd>s</kbd> Selection
    - <kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>,</kbd>, <kbd>f</kbd> File
    - <kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>,</kbd>, <kbd>l</kbd> Lines
    - <kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>,</kbd>, <kbd>b</kbd> Block
- Sent SIGINT (force stop)
    - <kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>c</kbd>

### Other plugins
- AlignTab
- Anaconda
- Emmet
- Markdown Preview
- MarkdownTOC ([usage](https://github.com/naokazuterada/MarkdownTOC#usage))
- Side​Bar​Enhancements

## Zsh
### Setup zsh
```sh
chsh -s /bin/zsh
```

### [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
```sh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```

### [powerlevel9k](https://github.com/bhilburn/powerlevel9k)
Installation
```sh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

For configuration in `.zshrc`, see readme and wiki of powerlevel9k.

For color customization, all supported colors are ([ref](https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#segment-color-customization)):
```sh
for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
```

### [dracula](https://draculatheme.com/zsh/)
A vampire style theme and color scheme for many programs.
```sh
wget -P ~/.oh-my-zsh/custom/themes https://github.com/dracula/zsh/raw/master/dracula.zsh-theme
```

### [Fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)
An alternative of [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
```sh
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
# add to .zshrc plugin list and restart zsh
fast-theme safari
```

### [biozsh](https://github.com/kloetzl/biozsh)
Zsh autocompletes for plenty bioinfomatic tools.
```sh
git clone https://github.com/kloetzl/biozsh.git ~/.oh-my-zsh/custom/plugins/biozsh
ln -s ~/.oh-my-zsh/custom/plugins/biozsh/biozsh.zsh ~/.oh-my-zsh/custom/plugins/biozsh/biozsh.plugin.zsh
```

## Vim
Make vim a light-weighted python IDE: [ENG](https://realpython.com/vim-and-python-a-match-made-in-heaven/)/[CHN](http://codingpy.com/article/vim-and-python-match-in-heaven/).
[Vim tips wiki](http://vim.wikia.com/wiki/Vim_Tips_Wiki).

### Useful shortcuts
- `[count]G`:jump to line.
- `C-b` and `C-f`: pageup and pagedown.
- `f[character]` and `t[character]`: jump to [character] in line (`;` and `,` for next and previous match).
- `vip` and `vap`: select paragraph (versatile selection:`v[count][ia][wspb()[]{}"']` see [manual](http://vimdoc.sourceforge.net/htmldoc/motion.html#v_ip)).
- `C-a` and `C-x`: increase or decrease the number (remap to `\-a` and `\-x` to avoild conflict with tmux)

### [Vundle](https://github.com/VundleVim/Vundle.vim)
Install
```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
and configure `.vimrc` (see readme of vundle).

Run `:PluginInstall` in vim or `vim +PluginInstall +qall` in command line.

### [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai)
Add to `.vimrc`:
```vim
syntax on
colorscheme sublimemonokai
```

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
May need to compile manually.
```sh
cd ~/.vim/bundle/YouCompleteMe/ && ./install.py
# for mac, use system python2 to build, no need MacVim
cd ~/.vim/bundle/YouCompleteMe/ && /usr/bin/python ./install.py
```
Settings
```vim
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
```

### [Nerd commenter](https://github.com/scrooloose/nerdcommenter)
Default `<Leader>` is `\`.

Add a space after comment sign
```vim
let g:NERDSpaceDelims=1
```
Space may be duplicated in some language (e.g. python), to workaround set
```vim
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
```

### [vim-slime](https://github.com/jpalardy/vim-slime)
`C-c C-c` to sent seleted code. Use visual mode to select or `vip` (select paragraph) before senting.

`C-c v` or `:SlimeConfig` to reconfigure the target pane.

Configuration for tmux and ipython. Select the `default` tmux session, current window and second pane.
```vim
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": ".2"}
```

### Other plugins
- [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
- [terryma/vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
- vim-scripts/indentpython.vim
- vim-scripts/nextval
- vim-syntastic/syntastic
- nvie/vim-flake8
- [benmills/vimux](https://github.com/benmills/vimux)

## Tmux
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
### Bash PS1 config
```bash
export PS1='\[\e[1;33m\]$PWD/ \[\e[0m\]\n\u@\h@\t $ '
```
behaves like
```
/to/your/path
User@Host@Time $
```
