# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"
export JAVA_HOME="/usr/bin/java"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
zsh-autosuggestions
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Load Angular CLI autocompletion.
source <(ng completion script)
export JAVA_HOME=/Users/biman_giri/OpenJDK/jdk-17.0.2.jdk/Contents/Home/
export PATH="/opt/homebrew/Cellar/vim/9.0.1650/bin:$PATH"

#brew install bat
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias sd="cd \$(find * -type d | fzf)"
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --theme="zenburn" --line-range :500 {}"'


### Handling the history of the commands

HISTFILE=~/.histfile_zsh
HISTSIZE=1000000
SAVEHIST=10000000

##### Homebrew auto update disables otherwise it will updates the all the packages
## which cause the system packages break
export HOMEBREW_NO_AUTO_UPDATE=1


# add the alias for clear
alias c='clear'

# set your termial to work with vim key bindings
bindkey -v
bindkey kj vi-cmd-mode
bindkey jk vi-cmd-mode


###########set auto complete
#Autocomplete
autoload -U compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -C
_comp_options+=(globdots)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
	end-of-line
	vi-env-of-line
	vi-add-eol
)

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
	forward-word
	emacs-forward-word
	vi-forward-char
	vi-forward-word
	vi-forward-word-end
	vi-forward-blank-word
	vi-forward-blank-word-end
	vi-find-next-char
	vi-find-next-char-skip
)



# auto complete navigation
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char



# for better version of fzf
lfcd () {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
	    dir="$(cat "$tmp")"
	    rm -f "$tmp"
	    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
bindkey -s '^p' ' lfcd\n'
function cd {
    builtin cd "$@" && ls -F
}

bindkey -s "\C-f" ' fzf_out=$(fzf --layout=reverse --bind K:preview-up,J:preview-down,H:preview-page-up,L:preview-page-down --preview  \"bat --style=numbers --color=always --line-range :500 {}\"); [[ -z $fzf_out ]] && : || vim $fzf_out\n print -S "vim $fzf_out"\n'
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPT='--layout=reverse --height=60% --bind up:preview-up,down:preview-down'
# Interactive search.
# # Usage: ff or ff <folder>.
# # Separate searchterms by | without space
ff() {
[[ -n $1 ]] && cd $1 || # go to provided folder or noop
RG_DEFAULT_COMMAND="rg  -i -l --hidden --no-ignore-vcs"
selected=$(
FZF_DEFAULT_COMMAND="rg  --files --hidden --follow" fzf \
-m \
-e \
--ansi \
--phony \
--reverse \
--bind "ctrl-a:select-all" \
--bind "f12:execute-silent:(subl -b {})" \
	--bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
	--preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)
[[ -n $selected ]] && vim $selected # open multiple files in editor
}
bindkey -s "\C-g" ' ff\n'


#For ipython shell
alias ipython='python -m IPython --TerminalInteractiveShell.editing_mode=vi --no-autoindent'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# chnage the autosugesstion highlighet color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=red,bg=#ff00ff,bold" 
