# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY AUTO_CD HIST_IGNORE_SPACE HIST_IGNORE_DUPS HIST_NO_STORE 

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle :compinstall filename '/home/toulouse/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload colors zsh/terminfo
colors

PROMPT="%{$terminfo[bold]%}%B[%n@%m:%~]%# %b%{$terminfo[sgr0]%}"
RPROMPT="{%? %{$terminfo[bold]$fg[magenta]%}%*%{$terminfo[sgr0]%}}"


alias fmd="svn diff --diff-cmd=fmdiff"
alias xc="open *.xcodeproj"
export M2_HOME=/usr/local/maven
export PATH=$M2_HOME/bin:$HOME/.local/`uname -m`/bin:$HOME/bin:/Users/toulouse/.gem/ruby/1.8/bin:$HOME/code/play:$PATH
export EDITOR=vim
export VISUAL=vim
export CLASSPATH=$HOME/.m2/repository:$CLASSPATH

source /Library/PostgreSQL/9.0/pg_env.sh

#rsync -vzrlpt --rsh=ssh 1Password.agilekeychain vps:1p-bak/

alias forward="ssh -v -NT -R '*:9000:localhost:9000' vps"
export PATH=$HOME/code/arcanist/bin:$PATH
