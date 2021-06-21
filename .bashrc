# include OS default .bashrc if it exists
if [ -f "${HOME}/.bashrc_os" ]; then
  source "${HOME}/.bashrc_os"
fi

# set EDITOR so it set the default text editor
export EDITOR='vim'

# set LSCOLORS so it colors ls output in Mac
if [ "$(uname)" == 'Darwin' ]; then
  export LSCOLORS='gxfxcxdxbxegedabagacad'
fi

# set git prompt variables so it shows a branch to a prompt if it is installed
# see https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if type __git_ps1 > /dev/null 2>&1; then
  GIT_PS1_SHOWDIRTYSTATE='true'
  GIT_PS1_SHOWSTASHSTATE='true'
  GIT_PS1_SHOWUNTRACKEDFILES='true'
  GIT_PS1_SHOWUPSTREAM='auto'
  GIT_PS1_SHOWCOLORHINTS='true'
  PROMPT_COMMAND="\
    __git_ps1 \
    '\[\e]0;${WSL_DISTRO_NAME}: \u@\h: \w\a\]${debian_chroot:+(${debian_chroot})}\[\033[01;33m\]${WSL_DISTRO_NAME}\[\033[00m\]:\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]' \
    '\\\$ ' \
    "
fi

# hook direnv into a shell if it is installed
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# set bash completion
complete -o default chrome
