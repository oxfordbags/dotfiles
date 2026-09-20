#!/bin/sh
# Re-theme tmux with a catppuccin flavour: set-flavor.sh latte|mocha
# Run from the client-light-theme / client-dark-theme hooks in ~/.tmux.conf.

tmux set -g @catppuccin_flavor "$1"

# The plugin sets its palette and module colours with `set -o` (only if unset),
# and expands the module colours once (-F), so the previous flavour's values
# have to be cleared before the config is sourced again. Options set in
# ~/.tmux.conf are re-applied by that source.
tmux show -g | awk '/^@(thm_|catppuccin_)/ && $1 != "@catppuccin_flavor" { print $1 }' | while read -r opt; do
	tmux set -gu "$opt"
done

tmux source-file ~/.tmux.conf
