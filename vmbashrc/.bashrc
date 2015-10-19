export PS1="\e[0;31m\u@\h \w: \e[m"
alias ls="ls -F --color"
alias ll="ls -latri --color"
alias GWD="cd ~/gitcode/ceph/src"
alias RCEPH="./vstart.sh -n -x -l"
alias vi="vim"
alias search="ls -F | grep \\"
alias nosearch="ls -F | grep -v \\"
alias CHECKHOST="ping 192.168.56.1"
alias REVEALYOURSELF="ifconfig | grep '192.168.56.'"
export GREP_OPTIONS='--color=auto'

# let ls and dir have good colors :)
eval `dircolors -b ~/.dir_colors`
