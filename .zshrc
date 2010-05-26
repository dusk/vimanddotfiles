# ~/.zshrc

# Environment {{{1
# ----------------

export PATH=/opt/local/lib/postgresql83/bin/:/opt/ruby-enterprise/bin:/Users/aannese/bin:/opt/local/bin:/opt/local/sbin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/bin/X11:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/sbin:`pwd`/deport_tools:"$PATH"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

eval `dircolors -b "$HOME/.dir_colors"`

if ! grep --color 2>&1 | grep un >/dev/null; then
    alias grep='grep --color=auto --exclude="*~" --exclude=tags'
    alias egrep='egrep --color=auto --exclude="*~" --exclude=tags'
fi

setopt rmstarsilent histignoredups
setopt noclobber nonomatch
setopt completeinword extendedglob
setopt autocd 
setopt hist_reduce_blanks

unsetopt bgnice autoparamslash

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
PERIOD=3600

periodic() { rehash }
namedir() { export $1=$PWD; : ~$1 }

function _rake_does_task_list_need_generating () {
  if [ ! -f .rake_tasks ]; then
    return 0;
  else
    accurate=$(stat -f%m .rake_tasks)
    changed=$(stat -f%m Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

function _rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    reply=( `cat .rake_tasks` )
  fi
}

compctl -K _rake rake

unset interactive domains host

# Aliases {{{1
# ------------

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

which sudo >/dev/null && alias sudo='sudo ' # this makes $1 expand as an alias

# process
alias psx="ps auxw | grep $1"
alias sgem='sudo gem'

# search
alias grep="grep -in"
alias ack="ack -Qi"
#alias find="find /tmp -exec grep $1 '{}' /dev/null \; -print"
alias rfind='find . -name *.rb | xargs grep -n'
alias afind='ack-grep -il'

# history
alias history='fc -l 1'

# directory walking
alias .='pwd'
alias ...='cd ../..'
alias -- -='cd -'
alias ls="ls -F --color=auto"
alias lsd='ls -ld *(-/DN)' # directories only
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -alr'
alias sl=ls # often screw this up

# super user
alias _='sudo'
alias ss='sudo su -'

# git
alias gss='git submodule --quiet foreach "(git status -a > /dev/null && echo \$path) || true"'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcg='git commit -am'
alias gb='git branch'
alias gba='git branch -a'
alias glog='git log --name-status'
alias gme='git log --name-status --author=alex'
alias gpick="git cherry-pick"
alias gcp="git cherry-pick"
alias gmaster="git co master"
alias gcm="git co master"
alias gco="git co"
alias gash="git stash"
alias gasha="git stash apply"
alias grh="git reset --hard"

# server stack
alias wf='cd ~/workfeed'
alias ur="unicorn_rails"
alias psql='psql83'
alias db="psql -Upostgres yam_development"
alias ptl="tail -f log/development.log"
alias rakev='rake TESTOPTS=-v'
alias routes='rake routes'
alias raket='rake -T | grep -in'
alias rdbm='rake db:migrate'
alias apacherestart='sudo /usr/sbin/apachectl restart'
alias ss='script/server'
alias sc='script/console'
alias sg='script/generate'
alias sgm='script/generate model'
alias sgc='script/generate controller'
alias sgmi='script/generate migration'
alias sgs='script/generate scaffold'

# Keybindings {{{1
# ----------------

autoload -U compinit
compinit

bindkey -v
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey -s '\e.' "..\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^j" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space

# Prompt {{{1
# --------------------
setopt prompt_subst
autoload -U colors && colors

hostcolor="01;37"
usercolor=$'\e[93m'
dircolor=$'\e[94m'

git_prompt_info() {
    if [ -d .svn ]; then
        ref=.svn
    else
        ref=${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/} || \
        ref=${$(git rev-parse HEAD 2>/dev/null)[1][1,7]} || \
        return
    fi

    branchcolor="$fg_bold[blue]"
    echo "(%{$branchcolor%}${ref}%{$reset_color%})"
}

[ $UID = '0' ] && usercolor="$fg_bold[white]"
reset_color=$'\e[00m'
e=`echo -ne "\e"`

PROMPT="%{${e}[${hostcolor}m%}%m%{${e}[00m%}:%{$dircolor%}%20<...<%~%<<%{${e}[00m%}%{${e}[00m%}\$(git_prompt_info) %# "

setopt promptsubst

unset hostcolor hostletter hostcode dircolor usercolor usercode
unset e

# Completion {{{1
# ---------------

setopt noautomenu
setopt complete_in_word
setopt always_to_end

unsetopt flowcontrol

WORDCHARS=''

autoload -U compinit
compinit

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

unsetopt MENU_COMPLETE
#setopt AUTO_MENU

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu yes select
# zstyle ':completion:*:*:*:*:processes' force-list always

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# Load known hosts file for auto-completion with ssh and scp commands
if [ -f ~/.ssh/known_hosts ]; then
  zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`
fi

# Complete on history
#zstyle ':completion:*:history-words' stop yes
#zstyle ':completion:*:history-words' remove-all-dups yes
#zstyle ':completion:*:history-words' list false
#zstyle ':completion:*:history-words' menu yes
