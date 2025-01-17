# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Aim to remove latency of loading conda
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"  ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command chmod g-rwX "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

typeset -A ZINIT
ZINIT[NO_ALIASES]=1
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    @zdharma-continuum/zinit-annex-binary-symlink \
    @zdharma-continuum/zinit-annex-patch-dl

### End of Zinit's installer chunk

# Load theme
zinit ice depth=1 src"$HOME/.p10k.zsh"
zinit light @romkatv/powerlevel10k

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light @zdharma-continuum/fast-syntax-highlighting

# Load OMZ scripts
# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Load programs
zinit ice wait lucid from"gh-r" as"null" \
    completions dl"https://github.com/unixorn/fzf-zsh-plugin/raw/main/completions/_fzf" \
    atclone"./fzf --zsh > init.zsh" \
    atpull"%atclone" src"init.zsh" nocompile"!" lbin"!fzf"
zinit light @junegunn/fzf

zinit wait lucid from"gh-r" as"null" for \
    lbin"!**/bat" completions mv"**/bat.zsh -> _bat" \
        @sharkdp/bat \
    lbin"!**/fd" completions @sharkdp/fd \
    lbin"!**/rg" completions @BurntSushi/ripgrep \
    lbin"!lazygit" @jesseduffield/lazygit

## arm binary not available, do not load on macOS
zinit wait lucid if'[[ $OSTYPE != darwin* ]]' from"gh-r" as"null" for \
    lbin"!eza" completions dl"https://github.com/eza-community/eza/raw/main/completions/zsh/_eza" \
        @eza-community/eza

zinit ice wait lucid from"gh-r" as"null" \
    atclone"./zoxide init zsh > init.zsh" \
    atpull"%atclone" src"init.zsh" nocompile"!" \
    lbin"!zoxide" completions
zinit light @ajeetdsouza/zoxide

zinit ice wait lucid from"gh-r" as"null" \
    atclone'echo "export LS_COLORS=\"$(./vivid*/vivid generate nord)\"" > init.zsh' \
    atpull"%atclone" src"init.zsh" nocompile"!" \
    atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light @sharkdp/vivid

# Additional programs
typeset ZINIT_A_PROGRAMS=()
zinit wait lucid from"gh-r" as"null" for \
    if'(( $ZINIT_A_PROGRAMS[(I)lazydocker] ))' \
    lbin"!lazydocker" \
        @jesseduffield/lazydocker \
    if'(( $ZINIT_A_PROGRAMS[(I)jaq] ))' \
    lbin"!jaq-* -> jq" \
        @01mf02/jaq \
    if'(( $ZINIT_A_PROGRAMS[(I)jnv] ))' \
    lbin"!jnv" \
        @ynqa/jnv \
    if'(( $ZINIT_A_PROGRAMS[(I)csvtk] ))' \
    lbin"!csvtk" completions atclone"./csvtk genautocomplete --shell zsh --file _csvtk" atpull"%atclone" \
        @shenwei356/csvtk \
    if'(( $ZINIT_A_PROGRAMS[(I)nvim] ))' \
    ver"stable" bpick"*appimage" lbin"!nvim* -> nvim" \
        @neovim/neovim \
    if'(( $ZINIT_A_PROGRAMS[(I)nvim-r] ))' \
    ver"stable" bpick"*appimage" lbin"!nvim* -> nvim" \
        @neovim/neovim-releases \
    if'(( $ZINIT_A_PROGRAMS[(I)tmux] ))' \
    bpick"*AppImage" lbin"!tmux* -> tmux" \
        @nelsonenzo/tmux-appimage

# Load completions
zinit wait lucid as"completion" for \
    https://github.com/yadm-dev/yadm/raw/master/completion/zsh/_yadm \
    https://github.com/conda-incubator/conda-zsh-completion/raw/main/_conda \
    https://github.com/cgjosephlee/GNU-parallel-zsh-completion/raw/master/_parallel \
    @cgjosephlee/zsh-completions \
    @zsh-users/zsh-completions

# This one is to be ran just once, in interactive session.
# zinit creinstall /opt/homebrew/share/zsh/site-functions

# FZF settings
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER="**"
export FZF_COMPLETION_OPTS=""
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Enable vi key bindings
# zinit snippet OMZ::lib/key-bindings.zsh  # default emacs key bindings
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char
bindkey "^w" backward-kill-word
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
KEYTIMEOUT=1

# Disable selection after paste
zle_highlight=('paste:none')

# Auto-completion settings
# zstyle ":completion:*" verbose yes
# zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ":completion:*:messages" format "%d"
zstyle ":completion:*:warnings" format "No matches for: %B%d%b"
# zstyle -s ":completion:*:hosts" hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(grep -v '#' ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ":completion:*:hosts" hosts $_ssh_config
ZLE_SPACE_SUFFIX_CHARS=$'|'
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'

# Load custom profile
[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"

# Functions
src() {exec $SHELL}

# Aliases
setopt interactivecomments  # enable comments
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias ls='ls --color=auto --group-directories-first'
alias lx='eza --group-directories-first'
alias la='eza --group-directories-first -a'
alias ll='eza -lgb --time-style=long-iso --icons --group-directories-first'
alias lt='eza -lgb --time-style=long-iso --icons -s new'
alias l='less'
alias L='less -S'
alias zl='zless'
alias zL='zless -S'
alias grep='grep --color=auto'
alias tmux='tmux -2'
alias tl='tmux ls'
alias tn='tmux new'
alias ta='tmux a'
(( $+commands[nvim] )) && alias vi='nvim'
alias rp='realpath'
alias rps='realpath -s'
alias lg='lazygit'
