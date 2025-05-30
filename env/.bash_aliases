# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Look for the above pre-existing lines and add the following lines somewhere
# below them.  Otherwise, just add these lines near the end of the file.

alias pi_ws_rm_all="pi ws ls -a --format=json | jq '.[] | .path' | xargs -n1 pi ws rm"
alias tau='source ~/Documents/avi-varma/avi_scripts/tau.sh'
alias pi_chdir='~/develop/tau_extras/customer/bin/pi_user_utils/pi_chdir.py'
alias picd='source ~/develop/tau_extras/customer/bin/pi_user_utils/pi_chdir.sh'
alias iplm='source ~/Documents/avi-varma/avi_scripts/iplm.sh'
alias g='git'
alias mdx='cd /home/avi.varma/develop/tau/'
alias picd='cd /home/avi.varma/develop/picache/'
alias cd_test='cd /home/avi.varma/develop/tau/src/methodics/test/'

alias ps_cache='sudo ~/Documents/avi-varma/avi_scripts/kill_ps.sh'
alias kill_cache='sudo ~/Documents/avi-varma/avi_scripts/kill_pic_proc.sh'
alias kill_servers='sudo ~/Documents/avi-varma/avi_scripts/kill_servers.sh'
alias dir_run='~/Documents/avi-varma/avi_scripts/dir_run.sh'
