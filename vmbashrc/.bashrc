## Prompt and common commands
export PS1="\e[0;31m\u@\h \w: \e[m"
alias ls="ls -F --color"
alias ll="ls -lart"
alias vi="vim"

## Machine specific
alias GWD="cd ~/gitcode/ceph/src"

## Git stuff
alias diffgit="git diff --cached"
alias addgit="git add ."
export GIT_EDITOR="vim"

## Koding.com
alias koding="ssh shivanshu21@shivanshu21.koding.io"

## Let ls and dir have good colors
export GREP_OPTIONS='--color=auto'
eval `dircolors -b ~/.dir_colors`

## HTTP proxy
#export http_proxy="10.140.221.232:3128"
#export https_proxy="10.140.221.232:3128"
#export no_proxy="localhost,127.0.0.1"

## Cscope and Ctags
alias CSCOPE_FILES="find . -iname \"*.c\" -o -iname \"*.cpp\" -o -iname \"*.cc\" -o -iname \"*.h\" -o -iname \"*.hpp\" > ~/cephscope/cscope.files"
alias BCSCOPE="cd ~/cephscope/;cscope -b -q -k"
alias BCTAGS="cd /root/gitcode/ceph/src/;ctags -R"
