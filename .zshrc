# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Aim to remove latency of loading conda
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"  ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma-continuum/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

typeset -g POWERLEVEL9K_MODE="nerdfont-complete"

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vcs dir_writable dir anaconda newline context prompt_char)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time newline)

typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\u250f "
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u2517 "

typeset -g POWERLEVEL9K_BACKGROUND=
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=" "
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="white"
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="red"

typeset -g POWERLEVEL9K_CONTEXT_{,REMOTE_}TEMPLATE="%m"
typeset -g POWERLEVEL9K_CONTEXT_{,REMOTE_}FOREGROUND="cyan"
typeset -g POWERLEVEL9K_CONTEXT_{ROOT,REMOTE_SUDO}_TEMPLATE="%B%n@%m"
typeset -g POWERLEVEL9K_CONTEXT_{ROOT,REMOTE_SUDO}_FOREGROUND="red"

typeset -g POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=""
typeset -g POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=""
typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND="009"

typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND="green"
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"

typeset -g POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=""
typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="105"
typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND="075"
typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="075"
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"

typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT="d h m s"
typeset -g POWERLEVEL9K_TIME_FOREGROUND="cyan"

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="magenta"

typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="152"

typeset -g GITSTATUS_NUM_THREADS=1

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
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
KEYTIMEOUT=1

# Load OMZ scripts
# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Load programs
zinit wait lucid from"gh-r" as"program" for \
    @junegunn/fzf \
    pick"**/fd" @sharkdp/fd \
    pick"**/bat" @sharkdp/bat \
    pick"**/exa" @ogham/exa

# Load plugins
zinit wait lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    multisrc"shell/*.zsh" id-as"junegunn/fzf_completions" \
        junegunn/fzf \
    Tarrasch/zsh-bd

# Load completions
zinit wait lucid as"completion" for \
    https://github.com/cgjosephlee/GNU-parallel-zsh-completion/raw/master/_parallel \
    https://github.com/sharkdp/fd/raw/master/contrib/completion/_fd \
    https://github.com/ogham/exa/raw/master/completions/zsh/_exa \
    https://github.com/TheLocehiliosan/yadm/raw/master/completion/zsh/_yadm \
    https://gist.githubusercontent.com/cgjosephlee/3881444e34a0b347075ba317150a2758/raw/86c3fe4ead1f83ae3e72cb37b7a96952ffdf07bb/_csvtk
zinit wait lucid light-mode blockf for \
    zsh-users/zsh-completions \
    esc/conda-zsh-completion \
    kloetzl/biozsh

# Load dircolors
# https://zdharma-continuum.github.io/zinit/wiki/LS_COLORS-explanation/
zinit ice atclone"dircolors -b src/dir_colors > clrs.zsh" \
    atpull"%atclone" pick"clrs.zsh" nocompile"!" \
    atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light arcticicestudio/nord-dircolors

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
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

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
alias lx='exa --group-directories-first'
alias la='exa --group-directories-first -a'
alias ll='exa -lgb --time-style=long-iso --icons --group-directories-first'
alias lt='exa -lgb --time-style=long-iso --icons -s new'
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
