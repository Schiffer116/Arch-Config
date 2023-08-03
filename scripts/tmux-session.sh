#! /usr/bin/sh

selected=$(find ~ -type d | fzf --layout=reverse --border=rounded --pointer="->" --preview="exa --tree --icons -L2 {}")
[ -z "$selected" ] && exit 0

selected_name=$(basename "$selected" | tr . _ | cut -c 1-7)


if ! tmux has-session -t="$selected_name" 2> /dev/null; then 
    tmux new-session -ds "$selected_name" -c "$selected"
fi

if [ -z "$TMUX" ]; then
    tmux a -t "$selected_name"
else
    tmux switch-client -t "$selected_name"
fi

