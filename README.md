# Config files <!-- omit in toc -->
Some of my config files (vim, tmux, etc.). Config file should be renamed as `.filename` and put in home directory.

## TOC <!-- omit in toc -->
<!-- created by vscode Markdown All in One -->
- [Manage with stow](#manage-with-stow)
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
  - [SublimeREPL](#sublimerepl)
  - [Other plugins](#other-plugins)
- [Bash](#bash)
  - [Bash-it](#bash-it)
  - [Oh my bash](#oh-my-bash)
  - [Theme](#theme-1)
  - [Misc](#misc)
- [Zsh](#zsh)
  - [Setup zsh](#setup-zsh)
  - [Oh my zsh](#oh-my-zsh)
  - [Theme](#theme-2)
    - [powerlevel9k](#powerlevel9k)
    - [powerlevel10k](#powerlevel10k)
    - [dracula](#dracula)
  - [Plugins](#plugins)
    - [Fast-syntax-highlighting](#fast-syntax-highlighting)
    - [biozsh](#biozsh)
- [Vim](#vim)
  - [Manual installation](#manual-installation)
  - [Useful shortcuts](#useful-shortcuts)
  - [vim-plug](#vim-plug)
  - [vim-sublime-monokai](#vim-sublime-monokai)
  - [YouCompleteMe](#youcompleteme)
  - [Syntastic](#syntastic)
  - [Nerd commenter](#nerd-commenter)
  - [vim-slime](#vim-slime)
  - [Other plugins](#other-plugins-1)
- [NeoVim](#neovim)
  - [Manual installation](#manual-installation-1)
  - [vim-plug](#vim-plug-1)
  - [Other plugins](#other-plugins-2)
- [Tmux](#tmux)
  - [Manual installation](#manual-installation-2)
  - [Tmux Plugin Manager (tpm)](#tmux-plugin-manager-tpm)
  - [Other plugins](#other-plugins-3)
- [Misc](#misc-1)
  - [Manage dotfiles](#manage-dotfiles)


## Manage with stow
### Installation
Linux
```
sudo apt-get install stow
```
MacOS
```
brew install stow
```
From source
```sh
git submodule init
git submodule update
cd vendor/stow
autoreconf -iv
./configure && make install
```

### Usage
```sh
# install
stow -v -t $HOME karabiner

# uninstall
stow -v -t $HOME karabiner -D
```

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
- SublimeCodeIntel

## Bash
### [Bash-it](https://github.com/Bash-it/bash-it)
A community Bash framework.
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

### Misc
#### Bash PS1 config <!-- omit in toc -->
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
# install oh my zsh
CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# activate zsh in , e.g. .bashrc
exec zsh
```

### [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### Theme
#### [powerlevel9k](https://github.com/bhilburn/powerlevel9k)
Installation
```sh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

For configuration in `.zshrc`, see readme and wiki of powerlevel9k.

For color customization, all supported colors are ([ref](https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#segment-color-customization)):
```sh
for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
```

#### [powerlevel10k](https://github.com/romkatv/powerlevel10k)
A fast drop-in replacement for Powerlevel9k.

#### [dracula](https://draculatheme.com/zsh/)
A vampire style theme and color scheme for many programs.
```sh
wget -P ~/.oh-my-zsh/custom/themes https://github.com/dracula/zsh/raw/master/dracula.zsh-theme
```
### Plugins
#### [Fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)
An alternative of [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
```sh
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
# add to .zshrc plugin list and restart zsh
exec zsh
fast-theme safari
```

#### [biozsh](https://github.com/kloetzl/biozsh)
Zsh autocompletes for plenty bioinfomatic tools.
```sh
git clone https://github.com/kloetzl/biozsh.git ~/.oh-my-zsh/custom/plugins/biozsh
```

## Vim
- Make vim a light-weighted python IDE: [ENG](https://realpython.com/vim-and-python-a-match-made-in-heaven/)/[CHN](http://codingpy.com/article/vim-and-python-match-in-heaven/).
- [Vim tips wiki](http://vim.wikia.com/wiki/Vim_Tips_Wiki).

### Manual installation
_Painful and not tried. Consider to try NeoVim._
- https://www.vim.org/git.php
- https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

### Useful shortcuts
- `[count]G`: jump to line.
- `C-b` and `C-f`: pageup and pagedown.
- `f[character]` and `t[character]`: jump to [character] in line (`;` and `,` for next and previous match).
- `vip` and `vap`: select paragraph (versatile selection:`v[count][ia][wspb()[]{}"']` see [manual](http://vimdoc.sourceforge.net/htmldoc/motion.html#v_ip)).
- `C-a` and `C-x`: increase or decrease the number (remap to `\-a` and `\-x` to avoild conflict with tmux)

### [vim-plug](https://github.com/junegunn/vim-plug)
Install
```sh
# for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

<!-- ### [Vundle](https://github.com/VundleVim/Vundle.vim)
Install
```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
and configure `.vimrc` (see readme of vundle).

Run `:PluginInstall` in vim or `vim +PluginInstall +qall` in command line. -->

### [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai)
Add to `.vimrc`:
```vim
syntax on
colorscheme sublimemonokai
```

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
May need to compile manually.
```sh
cd ~/.vim/plugged/YouCompleteMe && ./install.py
# for mac, use system python to build
cd ~/.vim/plugged/YouCompleteMe && /usr/bin/python ./install.py
```
Settings
```vim
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
```
To support autocompletion for custome packages (eq. Anaconda), here add a python script `.ycm_global_extra_conf.py` to configure package path.

Python version for compiling ycm and launching ycm interpreter can be different (I compiled with system python 2.7 and launch ycm interpreter with anaconda python 3.6, and have completion for packages installed by anaconda).
```vim
let g:ycm_global_ycm_extra_conf = '~/.ycm_global_extra_conf.py'
```
`:YcmCompleter` subcommands
```
:YcmCompleter GetDoc
:YcmCompleter GoTo   # can be involked with ctrl+O and ctrl+I
```

### [Syntastic](https://github.com/vim-syntastic/syntastic)
To lint `.py` with flake8, need to install flake8 first.
```sh
conda install flake8
```
```vim
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
```
Color test for configuring color scheme
```vim
:so $VIMRUNTIME/syntax/colortest.vim
```

### [Nerd commenter](https://github.com/scrooloose/nerdcommenter)
Default `<leader>` is `\`.

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
- [vim-airline](https://github.com/vim-airline/vim-airline)
- [auto-pairs](https://github.com/jiangmiao/auto-pairs)
- [vim-surround](https://github.com/tpope/vim-surround)
- [vim-easy-align](https://github.com/junegunn/vim-easy-align)
- [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
- [coc.nvim](https://github.com/neoclide/coc.nvim) (language server protocol support)
- [nerdtree](https://github.com/preservim/nerdtree)
- indentpython.vim
- nextval

## [NeoVim](https://neovim.io)
- Config path: `~/.config/nvim/init.nvim`
- Differences between Nvim and Vim: https://neovim.io/doc/user/vim_diff.html

### Manual installation
Just download and enjoy!
```sh
# for linux
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
```
Python support: https://neovim.io/doc/user/provider.html#provider-python
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

### Other plugins
- [deoplete.nvim](https://github.com/Shougo/deoplete.nvim) (autocompletion)
- [ncm2](https://github.com/ncm2/ncm2) (autocompletion)

## [Tmux](https://github.com/tmux/tmux)
### Manual installation
1. Install [libevent](https://github.com/libevent/libevent)
2. Install tmux
```sh
./configure CFLAGS="-I$HOME/.local/include" LDFLAGS="-L$HOME/.local/lib" --prefix=$HOME/.local
make && make install
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
- [dotfiles example](https://github.com/xero/dotfiles)
- https://github.com/TheLocehiliosan/yadm
- https://github.com/thoughtbot/rcm
- https://github.com/andsens/homeshick
