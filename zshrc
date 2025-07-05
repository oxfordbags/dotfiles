# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If the path be beautiful, let us not ask where it leads.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH


# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=nvim
export VISUAL="$EDITOR"
source ~/.aliases
export XDG_CONFIG_HOME=$HOME/.config

# Prompt fallback if p10k not installed
PROMPT="%F{0}%m %F{13}%1~ %F{7}$ %f"

# Load rbenv
# eval "$(rbenv init -)"
#
# # pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Automatically start tmux if not already inside it
if [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ] && [ -t 1 ]; then
  tmux attach-session -t main || tmux new-session -s main
fi
eval "$(/opt/homebrew/bin/mise activate zsh)"
