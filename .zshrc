typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# Enable Powerlevel10k instant prompt. Should stay close to the top of $HOME/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=false
POWERLEVEL9K_TRANSIENT_PROMPT=always
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv aws context dir vcs)
POWERLEVEL9k_RIGHT_PROMPT_ELEMENTS=(virtualenv status root_indicator background_jobs history time)
ZSH_DISABLE_COMPFIX=true
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa #add more if needed

# Import your bashrc or whatever profile:
[[ -e $HOME/.bashrc ]] && source $HOME'/.bashrc'

unameOut="$(uname -s)"
case "${unameOut}" in
	Linux*)  ZSH="/home/${USER}/.oh-my-zsh";;
	Darwin*) ZSH="/Users/${USER}/.oh-my-zsh";;
	MINGW*)  ZSH="noidea"
esac

DEFAULT_USER=anthony.quarnstrom
prompt_context() {
  # Custom (Random emoji)
  emojis=("⚡️" "🔥" "💀" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🇹🇭" "🚦" "🌙")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment black default "$USER ${emojis[$RAND_EMOJI_N]} "
}


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in $HOME/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  osx 
  kubectl
  docker
  helm
  pip
  virtualenv
  ssh-agent
  colored-man-pages
  compleat
  git-extras
  mvn
  python
  sublime
  sudo
  virtualenvwrapper
  web-search
  wd
  cp
  alias-tips
  brew
  colorize
  quoter
  ansiweather
  taskwarrior
  tmux
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $HOME/.zshrc"
# alias ohmyzsh="mate $HOME/.oh-my-zsh"

#Install awsp for this command
#npm install -g awsp 
alias awsp="source _awsp"

alias pip=/usr/local/bin/pip3

autoload -Uz compinit bashcompinit
compinit
bashcompinit

source $HOME/.bash_completion.d/compleat_setup
source $HOME/bin/wenv

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
if [ ! -x $TERMINAL_SOURCE ] && [ "$TERMINAL_SOURCE"=="jetbrains" ]; then
	[[ ! -f $HOME/.p10k.jetbrains.rc ]] ||  source $HOME/.p10k.jetbrains.rc
else
	[[ ! -f $HOME/.p10k.rc ]] || source $HOME/.p10k.rc
fi

export wenv_cfg="${XDG_CONFIG_HOME:-$HOME/.config}/wenv"

eval "$WENV_EXEC"
# enable bash completion functions
autoload bashcompinit
bashcompinit
# source wenv completion file
source $ZSH/custom/plugins/wenv/completion.bash
