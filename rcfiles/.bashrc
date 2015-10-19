## Prompt and common commands
export PS1="\e[0;31m\u@\h \w: \e[m"
alias ls="ls -F --color"
alias ll="ls -lart"
alias vi="vim"
alias search="ls -F | grep \\"
alias nosearch="ls -F | grep -v \\"

## Machine specific
alias GWD="cd ~/gitcode/ceph/src"
alias VMCONNECT="ssh src0@192.168.56.102"
alias WMCONNECT="ssh src0@192.168.56.103"
alias XMCONNECT="ssh src0@192.168.56.104"
alias CHECKVMPING="ping 192.168.56.102"
alias SYSDEPLOY="./wenv.sh;screen -x;"

## Git stuff
alias diffgit="git diff --cached"
alias addgit="git add ."

## Koding.com
alias koding="ssh shivanshu21@shivanshu21.koding.io"

# let ls and dir have good colors :)
export GREP_OPTIONS='--color=auto'
eval `dircolors -b ~/.dir_colors`
