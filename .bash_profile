# direnv
#export ANY_ENV_HOME=$HOME/.anyenv
#export PATH=$PATH:$ANY_ENV_HOME/bin; eval "$(anyenv init -)";
#eval $(direnv hook bash)

# Load bashrc
if [ -f $HOME/.bashrc ] ; then
    . $HOME/.bashrc
fi

# Add custom bin
export PATH=$PATH:$HOME/bin

# Change ls colors
#export LSCOLORS=gxfxcxdxbxegedabagacad

# TODO pythonzはもう使わないので後で消す
# # pythonz
# # これがないとnpm installでエラーになる。
# # 私が構築手順(https://whiteplus.esa.io/posts/1328)の理解を
# # 間違えている可能性もある。
# export PATH=/usr/local/bin:$PATH

# goenv
##export GOPATH=$HOME/workspace/lenet/lenet_api
##export GOROOT=$HOME/.anyenv/envs/goenv/versions/`goenv version`
#export GOPATH=$HOME/go
#export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
##export GO_VERSION=1.7.5

# Haskell
#GHC_VERSION=ghc-8.0.2
#GHC_PATH=$HOME/.stack/programs/x86_64-osx/$GHC_VERSION/bin
#export PATH=$PATH:$HOME/.local/bin:$GHC_PATH

# Bison for phpenv PHP 7.2.12 install
#export PATH="/usr/local/opt/bison/bin:$PATH"

# genie
if [ type genie > /dev/null 2>&1 && "`ps -eo pid,lstart,cmd | grep systemd | grep -v -e grep -e systemd- | sort -n -k2 | awk 'NR==1 { print $1 }'`" != "1" ]; then
  genie -s
fi

# Homebrew
if [ -d $HOME/.homebrew ]; then
  # Mac
  eval $($HOME/.homebrew/bin/brew shellenv)
elif [ -d $HOME/.linuxbrew ]; then
  # Linux
  eval $($HOME/.linuxbrew/bin/brew shellenv)
fi
