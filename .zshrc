# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
CODE_FOLDER=$HOME/work
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git node npm zsh-syntax-highlighting  )

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
export PATH=$PATH:/home/tom/.powerline/scripts

function source_if_exists()
{
    if [ -f "$@" ]; then
        source "$@"
    else
        if [ ! -z $VERBOSE ]; then
            echo "could not find $@"
        fi
    fi
}

# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

source_if_exists ~/.bash_aliases
source_if_exists ~/.dots/till.sh
source_if_exists ~/.z-dir/z.sh
# source_if_exists ~/.fzf.zsh
source_if_exists ~/.dots/ff.bash
source_if_exists ~/.dots/fancy-ctrl-z.zsh
source_if_exists ~/.zsh_functions
source_if_exists ~/proxyconf.sh

# Hook in z jump
#function precmd () {
#_z --add "$(pwd -P)"
#}

# Taken from https://github.com/zsh-users/fizsh/blob/master/fizsh-dev/scripts/fizsh-miscellaneous.zsh
################################################
#
# Rebind tab so that it uses syntax-highlighting
#
# This is a bug in the syntax highlighting system (https://github.com/zsh-users/zsh-syntax-highlighting/issues/102)
# We work around it by calling all types of highlighters explictily
#

function _fizsh-expand-or-complete-and-highlight() {
  zle expand-or-complete
  _zsh_highlight_highlighter_brackets_paint
  _zsh_highlight_highlighter_main_paint
  _zsh_highlight_highlighter_cursor_paint
  _zsh_highlight_highlighter_pattern_paint
  _zsh_highlight_highlighter_root_paint
}

function dockernuke() {
    docker rm -fv $(docker ps -a -q);
    docker rmi -f $(docker images -q);
    docker volume rm $(docker volume ls);
    docker network rm $(docker network ls);
    BOOM="
        _.-^^---....,,--
    _--                  --_
  <                        >)
  |                         |
   \._                   _./
      \`\`\`--. . , ; .--\'\'\'
           | |   |
        .-=||  | |=-.
        \`-=#$%&%$#=-\'
           | ;  :neutral_face:
   _____.,-#%&$@%#&#~,._____
"
    echo -e $BOOM
}

function dockerclean(){
  docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && docker ps -a | cut -c-12 | xargs docker rm
}

alias s="git status"
alias git-reset-to-remote="git reset --hard origin/master"

function work() {
   cd ~/work/"$@" && code .
}

function config-the-git(){
  git config --global --add rebase.autostash true # don't make me stash manually and then pop it on git pull (rebase default)
}

function git-show() {
  git show ":/$@"
}

function gitlog-search(){
  git log --grep="$@" --format=fuller
}

function network-connections(){
  # list the current network connections
   nmcli con
}

function pid-for(){
  ps aux | grep $@
}

function pid-args-list(){ 
  # expect pid as input
  # output args to pid
  ps -aux | grep "$@"
}

function fiddler() {
  (mono ~/apps/fiddler/Fiddler.exe &)
}

function port-status() {
  netstat -tulpn
}

function restart-network-adapter() {
  # https://sysinfo.io/restart-network-ubuntu-16-04-xenial-xerus-linux/
  # list connections
  ifconfig
  # list installed network cards
  netstat -i
  # list all PCI devices
  lspci | egrep -i --color 'network|ethernet' 
  echo flushing/removing IP information from interface then restart networking service
  ip addr flush eth0 && systemctl restart networking.service
}

function connect-internet(){
  echo restarting network manager
  restart-network-manager
  sleep 3
  echo connecting to vpn
  ~/vpn-sign-in.sh
}

function restart-network-manager() {
  nmcli networking off
  nmcli networking on
}

function update-computer-all() {
  sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove
  # Fetches the list of available updates
  # Strictly upgrades the current packages
  # Installs updates (new ones)
  # clean up
}

function max-user-watches(){
  cat /proc/sys/fs/inotify/max_user_watches
}

function backup() {
  # expect file-name as input; e.g .zshrc
 cp "$1"{,-backup."$(date +%Y-%m-%d_%H_%M_%S)"} 
}
function zshrc-deploy-from-repo(){
  echo backing up
  backup ~/.zshrc
  echo copying to ~/.zshrc
  cp $CODE_FOLDER/linux-computer/.zshrc ~/.zshrc
}
function zshrc-move-to-repo(){
  cp ~/.zshrc $CODE_FOLDER/linux-computer/.zshrc
}
alias zshrc-save-to-repo="zshrc-move-to-repo"

function debug-with-chrome(){
  google-chrome --remote-debugging-port=9223
}

function k8s-list-services(){
  k8s-set-namespace-production
  kubectl get service
}

function k8s-pods-for-app(){
  k8s-set-namespace-production
  # expect app as input
  kubectl get pods -l app="$1"
}

function k8s-pods-by-restart-count(){
  k8s-set-namespace-production
  # get pods for current namespace
  kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
}

function k8s-pod-description(){
  k8s-set-namespace-production
  # expects pod-id as input
  # for current context, describe a pod:
  kubectl describe pod "$@"
}

function k8s-app-ingress-points(){
  k8s-set-namespace-production
  # expects app as input
  # identify the ingress
  kubectl get ingress "$@"
}

function k8s-set-namespace-production(){
  kubectl config set-context $(kubectl config current-context) --namespace=production
}

function k8s-dashboard(){
  echo Must be on vpn
  ~/vpn-sign-in.sh
  echo Just skip password in the dialog
  # non-blocking cli: background the `kubectl proxy` job with `&` to enable start chrome
  kubectl proxy & google-chrome http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
}

function k8s-help(){
  google-chrome https://kubernetes.io/docs/reference/kubectl/cheatsheet/#interacting-with-running-pods
}
alias k8s-cheatsheet="k8s-help"

zle -N _fizsh-expand-or-complete-and-highlight _fizsh-expand-or-complete-and-highlight

bindkey "^I" _fizsh-expand-or-complete-and-highlight

################################################
# Colors
ESC_SEQ="\x1b["
RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
BLUE=$ESC_SEQ"34;01m"
MAGENTA=$ESC_SEQ"35;01m"
CYAN=$ESC_SEQ"36;01m"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex" 
[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex" # use elixir defined in the kiex default as thee global default
source /home/stephen/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/vault/vault vault
