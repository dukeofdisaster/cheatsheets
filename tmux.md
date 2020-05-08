# Tmux cheats 
Note, I use a tmux.conf with sane splitting; see below

```
# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

## now ctrl-a + | splits vertical, ctrl-a + - splits horizontal, ctrl-a +
## arrow to go whatever direction you want
```

So this should function pretty much 1:1 with any other tmux cheatsheets
just with a different bind key.


## windows
ctrl-a c
- create window
ctrl-a ,
- rename current window
ctrl-a & 
- close current window
ctrl-a p 
- previous window
ctrl-a n 
- next window

## COPY MODE
Copy mode lets you scroll in a tmux window

ctrl-a [
- enter copy mode
q
- quit mode
h
- move <- 
j
- move down
k
- move UP
l
- move -> 
w
- forward WORD
b 
- back WORD
