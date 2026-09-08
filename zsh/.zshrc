# -----------------------------------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# NOTE: Powerlevel10k no longer recieves support, so commenting it out and replacing with starship.
# -----------------------------------------------------------------------------------------------------

# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


# -----------------------------------------------------------------------------------------------------
# Zinit
# @see https://github.com/zdharma-continuum/zinit#install
# -----------------------------------------------------------------------------------------------------

# Set zinit directory (create if it doesn't exist) 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"

# Install zinit if it doesn't exist
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source the zinit file
source "${ZINIT_HOME}/zinit.zsh"


# -----------------------------------------------------------------------------------------------------
# Powerlevel10k (disabled, see comment on line 5)
# @see https://github.com/romkatv/powerlevel10k
# -----------------------------------------------------------------------------------------------------

# Add the Powerlevel10k plugin
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# -----------------------------------------------------------------------------------------------------
# Zsh Plugins
# @see https://github.com/zsh-users
# -----------------------------------------------------------------------------------------------------

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# zinit light olets/zsh-transient-prompt


# -----------------------------------------------------------------------------------------------------
# Snippets
# -----------------------------------------------------------------------------------------------------

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found


# -----------------------------------------------------------------------------------------------------
# Completions
# -----------------------------------------------------------------------------------------------------

autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# -----------------------------------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------------------------------

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# -----------------------------------------------------------------------------------------------------
# Keybindings
# -----------------------------------------------------------------------------------------------------

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# -----------------------------------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------------------------------

alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias zc='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias ls='gls --color=auto'
alias cat='bat'
alias overmind="TERMINFO= TERM=xterm-256color overmind"
alias tmc="$EDITOR ~/.config/tmux/tmux.conf"
alias console="php bin/console"
alias pint-fix="./vendor/bin/pint --config ~/workspace/configs/laravel-pint/pint.json --dirty"
alias pretty-diff="git diff --name-only --diff-filter=d | xargs npx prettier --write"
alias artifacts-generate="npx @openapitools/openapi-generator-cli generate \
    -i https://api.artifactsmmo.com/openapi.json \
    -g php \
    -o . \
    -c openapi-config.json"


# -----------------------------------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------------------------------

# Show all dotfiles in a fzf for easy editing
dot() {
  local file
  file=$(find ~/dotfiles -type f \
    -not -path "*/.git/*" \
    | fzf --height=40% --border --prompt="Edit dotfile: " \
          --preview 'bat --color=always --style=numbers {} 2>/dev/null || cat {}')
  [[ -n "$file" ]] && "$EDITOR" "$file"
}


# -----------------------------------------------------------------------------------------------------
# Shell integrations
# -----------------------------------------------------------------------------------------------------

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(mise activate zsh)"


# -----------------------------------------------------------------------------------------------------
# Envs
# -----------------------------------------------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"
export BAT_THEME="Catppuccin Mocha"
export LS_COLORS="$(vivid generate catppuccin-mocha-custom)"


# -----------------------------------------------------------------------------------------------------
# Misc (for EOF)
# -----------------------------------------------------------------------------------------------------

zinit cdreplay -q

# Append local config if there is one
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"

# Initialize Starship
eval "$(starship init zsh)"

# Enable Transient Prompt
# TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship module character)'

