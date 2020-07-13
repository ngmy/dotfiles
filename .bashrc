alias lenet-update="ask_password && curl -F 'migrate=true' lenet-deploy.elasticbeanstalk.com/release"
alias ls='ls -G'
alias cp='gcp'

# TODO pythonzはもう使わないので後で消す
# # pythonz
# [[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# brew vim
alias vi='/usr/local/bin/vim'
alias vim='/usr/local/bin/vim'

# Enable git completion in prompt
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
# Display git branch name in prompt
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\h\[\033[00m\]:\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '

# Hack cd to enable direnv/dep in symlink
cd() {
    builtin cd "$@"
    if [ "$1" = "$HOME/lenet" -o "$1" = "$HOME/lenet-api" ]; then
        cd $(realpath .)
    fi
}

# Google Cloud SDK
source /Users/nagamiya/usr/local/src/google-cloud-sdk/completion.bash.inc
source /Users/nagamiya/usr/local/src/google-cloud-sdk/path.bash.inc
