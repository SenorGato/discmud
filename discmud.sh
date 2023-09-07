cd ~/bins/discmud || exit
./junk14.sh > /dev/null 2>&1 & clear
#Left column

tmux split-window -h -b -l 29 
#tmux split-window -v -l 1 -c ~/bins/discmud/ ./bloat.sh
tmux split-window -v -l 11 -c ~/bins/discmud/bin ./map
tmux select-pane -t 0
#tmux split-window -v -l 11 -c ~/bins/discmud/bin ./map
tmux split-window -v -l 1 -c ~/bins/discmud/ ./bloat.sh
tmux select-pane -t 3
#Center Column
tmux split-window -v -l 8 -c ~/bins/discmud/bin ./mdt
tmux select-pane -t 3
tmux split-window -v -b -l 8 -c ~/bins/discmud/bin ./chat_plugin
tmux select-pane -t 4
#tmux split-window -h -l 28 -c ~/bins/discmud/notes/ nvim notes
tmux select-pane -t 4
tmux send-keys "tt++ -G asami.tin" Enter
##tmux split-window -v -l 30 

#tmux split-window -v -b -l 8
#tmux select-pane -t 1
#Right column
#tmux split-window -h -l 29 
#tmux split-window -v -b -l 1
#tmux select-pane -t 1
##Chat
#tmux split-window -b -l 6
#tmux select-pane -t 2



