cd ~/bins/discmud || exit

tmux new-session -d -A -D -s discworld 
tmux attach-session -t discworld
